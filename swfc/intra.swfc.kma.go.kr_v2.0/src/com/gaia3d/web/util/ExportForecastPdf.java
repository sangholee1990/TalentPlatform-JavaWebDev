package com.gaia3d.web.util;


import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.joda.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;

import com.gaia3d.web.controller.ReportController.ForecastReportType;
import com.gaia3d.web.dto.ForecastReportDTO;
import com.google.common.base.Joiner;
import com.itextpdf.text.BadElementException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfAction;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPRow;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPTableEvent;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;

public class ExportForecastPdf {

	private FileSystemResource ForecastReportLocationResource;
	private FileSystemResource FigureLocationResource;
	private PdfStyle pdfStyle = new PdfStyle();
	
	final BaseColor data1Color = BaseColor.YELLOW;
	final BaseColor data2Color = BaseColor.RED;
	final BaseColor data3Color = new BaseColor(0, 176, 80);
	
	public class PageEvent extends PdfPageEventHelper {
		@Override
		public void onGenericTag(PdfWriter writer, Document pdfDocument, Rectangle rect, String text) {
			if ("rectangle".equals(text))
				strip(writer.getDirectContent(), rect);
			else if ("ellipse".equals(text))
				ellipse(writer.getDirectContentUnder(), rect);
		}
		
		private void rectangle(PdfContentByte content, Rectangle rect) {
            content.saveState();
            content.setRGBColorFill(0x00, 0x00, 0xFF);
            content.ellipse(rect.getLeft() - 3f, rect.getBottom() - 5f, rect.getRight() + 3f, rect.getTop() + 3f);
            content.fill();
            content.restoreState();
        }	
		
		private void strip(PdfContentByte content, Rectangle rect) {
            content.rectangle(rect.getLeft() - 1, rect.getBottom() - 5f,
                    rect.getWidth(), rect.getHeight() + 8);
            content.rectangle(rect.getLeft(), rect.getBottom() - 2,
                    rect.getWidth() - 2, rect.getHeight() + 2);
            float y1 = rect.getTop() + 0.5f;
            float y2 = rect.getBottom() - 4;
            for (float f = rect.getLeft(); f < rect.getRight() - 4; f += 5) {
                content.rectangle(f, y1, 4f, 1.5f);
                content.rectangle(f, y2, 4f, 1.5f);
            }
            content.eoFill();
        }
 
		private void ellipse(PdfContentByte content, Rectangle rect) {
            content.saveState();
            content.setRGBColorFill(0x00, 0x00, 0xFF);
            content.ellipse(rect.getLeft() - 3f, rect.getBottom() - 5f, rect.getRight() + 3f, rect.getTop() + 3f);
            content.fill();
            content.restoreState();
        }	
	}
	
	class ModelData {
		public Date[] date;
		public  float[] data;
	}
	
	public class ForecastInfoData {
		public ForecastInfoData(String date, Double... data) {
			this.Date = date;
			this.Data = new float[data.length];
			for(int i=0; i<data.length; ++i) {
				if(data[i] != null) {
					this.Data[i] = data[i].floatValue();
				} else {
					this.Data[i] = 0.0f;	
				}
			}
		}
		
		public ForecastInfoData(String date, float... data) {
			this.Date = date;
			this.Data = data;
		}
		
		public float[] Data;
		public String Date;
	}

	public class ForecastInfoTableEvent extends PdfPageEventHelper implements PdfPTableEvent {

		private java.util.List<ForecastInfoData> data;
		
		public ForecastInfoTableEvent(java.util.List<ForecastInfoData> data) {
			this.data = data;
		}
		

		@Override
		public void tableLayout(PdfPTable table, float[][] widths, float[] heights, int headerRows, int rowStart, PdfContentByte[] canvases) {
			PdfContentByte cb = canvases[PdfPTable.TEXTCANVAS];
			cb.saveState();

			// cb.setRGBColorStroke(255, 0, 0);
			int dataCount = data.size();
			float baseHeight = heights[6];
			float maxHeight = heights[6] - heights[1];

			cb.setColorStroke(BaseColor.BLACK);
			cb.setLineWidth(0.5f);
			for (int i = 0; i < dataCount; ++i) {
				int dataLength = data.get(i).Data.length;

				float cellMinX = widths[5][i + 1];
				float cellMaxX = widths[5][i + 2];
				float cellWidth = cellMaxX - cellMinX;

				float dataWidth = cellWidth / (dataLength + 1);

				for (int j = 0; j < dataLength; ++j) {
					float minx = cellMinX + (dataWidth / 2) + (dataWidth * j);
					float maxx = minx + dataWidth;
					float miny = baseHeight;
					float maxy = (miny-(miny - maxHeight * data.get(i).Data[j])) < -2 ? (miny - maxHeight * data.get(i).Data[j]) : (miny - maxHeight * data.get(i).Data[j]) + 2;
					
					BaseColor color;
					switch (j) {
					case 0:
						color = data1Color;
						break;
					case 1:
						color = data2Color;
						break;
					case 2:
						color = data3Color;
						break;
					default:
						color = BaseColor.BLACK;
						break;
					}

					cb.setColorFill(color);
					cb.rectangle(minx, maxy, maxx - minx, miny - maxy);
					cb.fillStroke();
				}
			}
			cb.restoreState();
		}
	}

	final BaseFont baseFont;
	final Font font20;
	final Font fontBold20;
	final Font fontNormal12;
	final Font fontBold12;
	final Font fontNormal10;
	final Font fontBold10;
	final Font fontBold10Blue;
	final Font small = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC);
    
    PdfPCell defaultCellStyle = new PdfPCell();
    
    final File basePath;


	public ExportForecastPdf(File basePath, String font) throws DocumentException, IOException {
		this.basePath = basePath;
		
		defaultCellStyle.setPadding(5);
		defaultCellStyle.setHorizontalAlignment(Element.ALIGN_CENTER);
		defaultCellStyle.setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		baseFont = BaseFont.createFont(font, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		
		font20 = new Font(baseFont, 20);
		fontBold20 = new Font(baseFont, 20, Font.BOLD);
		fontNormal12 = new Font(baseFont, 12);
		fontBold12 = new Font(baseFont, 12, Font.BOLD);

		fontNormal10 = new Font(baseFont, 10);
		fontBold10 = new Font(baseFont, 10, Font.BOLD);
		fontBold10Blue = new Font(baseFont, 10, Font.BOLD, BaseColor.BLUE);
	}
	
	public FileSystemResource getForecastReportLocationResource() {
		return ForecastReportLocationResource;
	}

	public void setForecastReportLocationResource(FileSystemResource forecastReportLocationResource) {
		ForecastReportLocationResource = forecastReportLocationResource;
	}
	
	public FileSystemResource getFigureLocationResource() {
		return FigureLocationResource;
	}
	
	public void setFigureLocationResource(FileSystemResource figureLocationResource) {
		FigureLocationResource = figureLocationResource;
	}
	
	private PdfPCell setAlignMiddle(PdfPCell cell) {
		Phrase phrase = cell.getPhrase();
		if(phrase != null) {
			float fontSize = phrase.getFont().getSize();
			float capHeight = phrase.getFont().getBaseFont().getFontDescriptor(BaseFont.CAPHEIGHT, fontSize);
			cell.setPaddingBottom(2*(fontSize-capHeight));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		}
		return cell;
	}

	public void createPdf(ForecastReportDTO dto, OutputStream output, Map<String, Object> params) throws Exception {
		Document document = new Document();
		PdfWriter writer = PdfWriter.getInstance(document, output);
		//writer.setPageEvent(new PageEvent());
		// document.setMargins(20, 20, 20, 20);
		document.setMarginMirroring(false);
		document.open();

		PdfPTable mainTable = new PdfPTable(1);
		mainTable.getDefaultCell().setBorderWidth(1.0f);
		mainTable.setWidthPercentage(100f);
		mainTable.setTotalWidth((PageSize.A4.getWidth() - document.leftMargin() - document.rightMargin()) * mainTable.getWidthPercentage() / 100);
		mainTable.setLockedWidth(true);
		
		//제목, 게시자, 발료일, 로고 테이블
		PdfPTable titleTable = new PdfPTable(1);
		titleTable.setWidthPercentage(100f);
		titleTable.getDefaultCell().setBorder(0);
		titleTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		titleTable.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		// 통보문 PDF 제목에서 발행호수 삭제
//		SimpleDateFormat sdf = new SimpleDateFormat("MM");
//		String title = dto.getTitle() + " (제 " + sdf.format(dto.getPublish_dt()) + " - " + dto.getPublish_seq_n() + " 호)";
		
		String title = dto.getTitle();
		
		//제목
		titleTable.addCell(new Phrase(title, fontBold20));
		
		PdfPTable subTitleTable = new PdfPTable(2);
		//로고
		ClassPathResource s = new ClassPathResource("kma.jpg");
		//File s = new File("kma.jpg");
		Image iconImage = Image.getInstance(s.getURL());
		iconImage.scaleToFit(70f, 70f);
		PdfPCell iconCell = new PdfPCell(iconImage);
		iconCell.setBorder(0);
		iconCell.setRowspan(6);
		subTitleTable.addCell(iconCell);
		
		PdfPCell publisherCell = null;
		
		String rptWriter = dto.getWriter();
		if(rptWriter == null || "".equals(rptWriter) || "null".equals(rptWriter.toLowerCase())){
			publisherCell = new PdfPCell(new Phrase("\n국가기상위성센터", fontBold12));
		}else{
			publisherCell = new PdfPCell(new Phrase(String.format("\n국가기상위성센터, %s", dto.getWriter()), fontBold12));
		}
		publisherCell.setBorder(0);
		publisherCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publisherCell);

		SimpleDateFormat df = new SimpleDateFormat("\nyyyy년 MM월 dd일 HH시mm분 발표\n");
		PdfPCell publishDateCell = new PdfPCell(new Phrase(df.format(dto.getPublish_dt()), fontBold12));
		publishDateCell.setBorder(0);
		publishDateCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publishDateCell);
		
		subTitleTable.setWidthPercentage(100f);
		subTitleTable.setExtendLastRow(false, false);
		
		titleTable.addCell(subTitleTable);
		titleTable.setComplete(true);
		mainTable.addCell(titleTable);

		PdfPCell cell = null;
		
		cell = new PdfPCell();
		List list = new List(false, 15f);
		list.setIndentationLeft(5f);
		list.setListSymbol(new Chunk("\u25CB", fontNormal12));
		if(dto.getContents() != null && !dto.getContents().isEmpty()) {
			for(String content : dto.getContents().split("--")) {
				if(!StringUtils.isEmpty(StringUtils.trim(content))){
					Chunk chunk = new Chunk(content, fontNormal12);
					chunk.setCharacterSpacing(-0.4f);
					ListItem listItem = new ListItem(chunk);
					listItem.setSpacingAfter(0f);
					list.add(listItem);
				}
			}
		}
		cell.addElement(list);
		
		if(dto.getRpt_type() == ForecastReportType.FCT && "N".equals(dto.getRpt_kind())) {
			cell.addElement(createSummary(dto));
		}
		
		createContentCell("개 요", mainTable, cell);
		
		//주의사항 작성
		createContentCell("주의사항", mainTable, new PdfPCell(createFCTNotice(dto)));
		
		createContentCell("상세정보", mainTable, new PdfPCell(예보상세정보(writer, dto, params)));
		
		
		String footerText = String.valueOf(params.get("footerText2"));

		//if(footerText == null)footerText = "□ 연락처 070-7850-5735 / 홈페이지 http://swfc.kma.go.kr/ko/alerts.do ";
        if(footerText == null)footerText = "□ 상세한 우주기사예보는 기상청 홈페이지( http://swfc.kma.go.kr )를 참고하시기 바랍니다. / 연락처 070-7850-5735";//연락처 070-7850-5735 / 홈페이지  http://swfc.kma.go.kr

        String firstTxt = footerText;
		if(footerText.indexOf("http://") != -1){
			firstTxt = footerText.substring(0, footerText.indexOf("http://"));
		}
		String secondTxt = getHttpURL(footerText);
		if(StringUtils.isEmpty(secondTxt))secondTxt="";

        String lastTxt = footerText.substring( footerText.indexOf("http://") + secondTxt.length(), footerText.length());

		//연락처 정보 작성
		PdfPTable contactTable = new PdfPTable(1);
		Paragraph contactText = new Paragraph(firstTxt, fontBold10);
		Chunk imdb = new Chunk(secondTxt, fontBold10Blue);
		imdb.setAction(new PdfAction(new URL(secondTxt)));
		contactText.add(imdb);
        contactText.add(lastTxt);
		PdfPCell contactCell= new PdfPCell(contactText); 
		contactCell.setPadding(5f);
		contactCell.setBorder(0);
		contactTable.addCell(contactCell);
		mainTable.addCell(contactTable);		
		//createContentCell("연락처 070-7850-5735 / 홈페이지 http://swfc.kma.go.kr", mainTable, null);

		mainTable.setComplete(true);
		mainTable.getRow(1).setMaxHeights(document.getPageSize().getHeight() - document.topMargin() - document.bottomMargin() - mainTable.getTotalHeight() + mainTable.getRow(1).getMaxHeights());
		document.add(mainTable);
		document.close();
	}
	
	private PdfPTable 예보상세정보(PdfWriter writer, ForecastReportDTO dto, Map<String, Object> params) throws DocumentException {
		PdfPTable detailTable = new PdfPTable(2);
		detailTable.setWidthPercentage(100f);
		detailTable.setWidths(new float[]{5.5f, 4.5f});
		
		pdfStyle.setCellStyle(detailTable.getDefaultCell(), Element.ALIGN_CENTER, Element.ALIGN_TOP);
		
		PdfPCell cell;
		
		if("N".equals(dto.getRpt_kind())) {
			cell = new PdfPCell(new Phrase("최근 3일 우주기상 정보", fontBold12));
			pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			cell.setBorder(0);
			cell.setPaddingRight(10f);
			detailTable.addCell(cell);
			
			cell = new PdfPCell(new Phrase("우주기상 예보", fontBold12));
			pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			cell.setBorder(0);
			detailTable.addCell(cell);
		} else {
			cell = new PdfPCell(new Phrase("우주기상 정보", fontBold12));
			pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			cell.setBorder(0);
			cell.setPaddingRight(10f);
			detailTable.addCell(cell);
			
			cell = new PdfPCell(new Phrase("지구자기권계면의 위치", fontBold12));
			cell.setBorder(0);
			pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			detailTable.addCell(cell);
		}
		
		cell = new PdfPCell(new Phrase("<일 최대값>", fontNormal10));
		pdfStyle.setCellStyle(cell, Element.ALIGN_RIGHT, Element.ALIGN_MIDDLE);
		cell.setBorder(0);
		cell.setPaddingRight(20f);
		detailTable.addCell(cell);

		cell = new PdfPCell(new Phrase(" ", fontNormal10));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		cell.setBorder(0);
		detailTable.addCell(cell);
		
		PdfPTable t = createForecastInfo(writer, dto);
		cell = new PdfPCell(t);
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_TOP);
		cell.setBorder(0);
		cell.setPaddingRight(20f);
		detailTable.addCell(cell);
		
		final float maxHeight = t.getTotalHeight();
		final float lastCompletedRowHeight = t.getRowHeight(t.getLastCompletedRowIndex());
		
		if("N".equals(dto.getRpt_kind())) {
			cell = new PdfPCell(createForecastInfo2(maxHeight, lastCompletedRowHeight, dto));
		} else {
			cell = new PdfPCell(createForecastInfo3(dto));
			pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_TOP);
		}
		
		cell.setBorder(0);
		detailTable.addCell(cell);
		
		String footerText1 = String.valueOf(params.get("footerText1"));
		if(footerText1 == null) footerText1 = "※ 태양복사, 태양고에너지 입자, 지구자기장 교란에 관한 예경보는 미래창조과학부 우주전파센터에서 제공";
		//cell = new PdfPCell(new Phrase("※ 우주기상 예측정보는 기상청 우주기상 예측모델과 NOAA SWPC 의 우주기상 예측을 참고한 정보입니다.", fontNormal10));
		cell = new PdfPCell(new Phrase(footerText1, fontNormal10));
		cell.setColspan(2);
		cell.setBorder(0);
        cell.setPaddingBottom(15f);
		detailTable.addCell(cell);
		return detailTable;
	}
	
	/**
	 * 텍스트 영역에서 http 주소정보를 추출하여 가장 처음 나온 URL 주소를 반환한다.
	 * @param text
	 * @return
	 */
	private String getHttpURL(String text){
		String regex = "\\(?\\b(http://|www[.])[-A-Za-z0-9+&amp;@#/%?=~_()|!:,.;]*[-A-Za-z0-9+&amp;@#/%=~_()|]";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(text);
		while (m.find()) {
			String urlStr = m.group();
			return urlStr;
		}
		return null;
	}
	
	private PdfPCell 우주기상등급(String grade) {
		PdfPCell cell = new PdfPCell(new Phrase(grade, fontNormal12));
	    pdfStyle.setCellStyle(cell, Rectangle.BOTTOM + Rectangle.RIGHT, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
	    return cell;
	}
	
	private PdfPTable createSummary(ForecastReportDTO dto) {
		PdfPTable table = new PdfPTable(new float[]{2.0f, 1f, 2.0f});
		table.setWidthPercentage(100f);
		table.setSpacingBefore(10f);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.getDefaultCell().setPadding(2f);
		table.getDefaultCell().setPaddingBottom(5f);
		
		PdfPCell cell = new PdfPCell(new Phrase("우주기상 실황", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		cell.setPadding(2f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("우주기상 등급", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		cell.setPadding(2f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("현재 값", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		cell.setPadding(2f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		table.addCell(new Phrase("태양 X선 플럭스", fontNormal12));
		table.addCell(우주기상등급(dto.getXrayGrade()));
		Phrase phrase = null;
		if(dto.getXray() != null) {
			phrase = new Phrase(String.format("%e", dto.getXray()), fontNormal12);
			phrase.add(" W/m");
			Chunk subScript = new Chunk("2", small);
		    subScript.setTextRise(5f);
		    phrase.add(subScript);
		    cell = new PdfPCell(phrase);
		    cell.setBorder(Rectangle.BOTTOM + Rectangle.RIGHT);
			table.addCell(cell);
		} else {
			table.addCell("");
		}
		
		table.addCell(new Phrase("태양 양성자 플럭스", fontNormal12));
		table.addCell(우주기상등급(dto.getProtonGrade()));
		if(dto.getProton() != null) {
			phrase = new Phrase(String.valueOf(dto.getProton()), fontNormal12);
			phrase.add(" s");
			Chunk subScript = new Chunk("-2", small);
		    subScript.setTextRise(5f);
		    phrase.add(subScript);
		    phrase.add("ster");
		    phrase.add(subScript);
		    phrase.add("cm");
		    subScript = new Chunk("-2", small);
		    subScript.setTextRise(5f);
		    phrase.add(subScript);
		    cell = new PdfPCell(phrase);
		    cell.setBorder(Rectangle.BOTTOM + Rectangle.RIGHT);
			table.addCell(cell);
		} else {
			table.addCell("");
		}
		
		table.addCell(new Phrase("지구 자기장교란 지수 Kp", fontNormal12));
		table.addCell(우주기상등급(dto.getKpGrade()));
		if(dto.getKp() != null) {
		    cell = new PdfPCell(new Phrase(String.valueOf(dto.getKp()), fontNormal12));
		    cell.setBorder(Rectangle.BOTTOM + Rectangle.RIGHT);
			table.addCell(cell);
		} else {
			table.addCell("");
		}
		
		table.addCell(new Phrase("지구 자기권계면 위치", fontNormal12));
		table.addCell(우주기상등급(dto.getMpGrade()));
		if(dto.getMp() != null) {
		    cell = new PdfPCell(new Phrase(String.valueOf(dto.getMp()) + "×지구반경", fontNormal12));
		    cell.setBorder(Rectangle.BOTTOM + Rectangle.RIGHT);
			table.addCell(cell);
		}else {
			table.addCell("");
		}
		
		cell = new PdfPCell(new Phrase("※ 우주기상 영향수준은 0(낮음)~5(심각)단계로 구분", fontNormal12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_RIGHT, Element.ALIGN_CENTER);
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setPaddingTop(5f);
		cell.setColspan(3);
		table.addCell(cell);
		return table;
	}
	
	private PdfPTable createFCTNotice(ForecastReportDTO dto) throws BadElementException {
		PdfPTable table = new PdfPTable(new float[]{1.2f,3f,3f,3f});
		table.setWidthPercentage(100f);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		PdfPCell cell = new PdfPCell(new Phrase("종류", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_JUSTIFIED_ALL, Element.ALIGN_MIDDLE, 30f, new BaseColor(241, 241, 241));
		cell.setPaddingLeft(6f);
		cell.setPaddingRight(6f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("기상위성운영", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("극항로 항공기상", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("전리권기상", fontBold12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("주의사항", fontNormal12));
		pdfStyle.setCellStyle(cell, Element.ALIGN_JUSTIFIED_ALL, Element.ALIGN_MIDDLE, 50f, new BaseColor(241, 241, 241));
		cell.setPaddingLeft(4f);
		cell.setPaddingRight(4f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		table.addCell(new Phrase(dto.getNot1_desc()==null?null:Joiner.on('\n').skipNulls().join(dto.getNot1_desc()), fontNormal12));
		table.addCell(new Phrase(dto.getNot2_desc()==null?null:Joiner.on('\n').skipNulls().join(dto.getNot2_desc()), fontNormal12));
		table.addCell(new Phrase(dto.getNot3_desc()==null?null:Joiner.on('\n').skipNulls().join(dto.getNot3_desc()), fontNormal12));

		return table;
	}
	
	private PdfPTable createForecastInfo(PdfWriter writer, ForecastReportDTO dto) throws BadElementException {
		PdfPTable table = new PdfPTable(new float[]{2f,3f,3f,3f});
		table.setTotalWidth(300f);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setPadding(5f);
		
		java.util.List<ForecastInfoData> data = new ArrayList<ForecastInfoData>();
		LocalDate writeDate = new LocalDate(dto.getWrite_dt());
		
		
		Paragraph paragraph = new Paragraph();
		if("N".equals(dto.getRpt_kind())) {
			data.add(new ForecastInfoData(writeDate.minusDays(2).toString("MM월 dd일"), dto.getNot1_max_val1(), dto.getNot2_max_val1(), dto.getNot3_max_val1()));
			data.add(new ForecastInfoData(writeDate.minusDays(1).toString("MM월 dd일"),  dto.getNot1_max_val2(), dto.getNot2_max_val2(), dto.getNot3_max_val2()));
			data.add(new ForecastInfoData(writeDate.toString("MM월 dd일"), dto.getNot1_max_val3(), dto.getNot2_max_val3(), dto.getNot3_max_val3()));
			
			paragraph.add(getTitle(writer.getDirectContent(), data1Color, " 기상위성운영 "));
			paragraph.add(getTitle(writer.getDirectContent(), data2Color, " 극항로 항공기상 "));
			paragraph.add(getTitle(writer.getDirectContent(), data3Color, " 전리권기상 "));
		} else {
			data.add(new ForecastInfoData(writeDate.minusDays(2).toString("MM월 dd일"), dto.getNot1_max_val3(), dto.getNot2_max_val3(), dto.getNot3_max_val3()));
			data.add(new ForecastInfoData(writeDate.minusDays(1).toString("MM월 dd일"),  dto.getNot1_max_val2(), dto.getNot2_max_val2(), dto.getNot3_max_val2()));
			data.add(new ForecastInfoData(writeDate.toString("MM월 dd일"), dto.getNot1_max_val1(), dto.getNot2_max_val1(), dto.getNot3_max_val1()));
			
			paragraph.add(getTitle(writer.getDirectContent(), data1Color, " 태양복사 "));
			paragraph.add(getTitle(writer.getDirectContent(), data2Color, " 태양고에너지입자 "));
			paragraph.add(getTitle(writer.getDirectContent(), data3Color, " 지구자기장교란 "));
		}
		table.setTableEvent(new ForecastInfoTableEvent(data));
		
		
		PdfPCell topCell = new PdfPCell(paragraph);
		topCell.setColspan(4);
		pdfStyle.setCellStyle(topCell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE, 25f, new BaseColor(220, 216, 194));
		
		table.addCell(topCell);
		table.addCell(textHeader("심 각"));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textHeader("경 계"));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textHeader("주 의"));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textHeader("관 심"));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textHeader("일 반"));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textContent(" "));
		table.addCell(textCell2("기 준"));
		for(ForecastInfoData d : data) {
			table.addCell(textCell2(d.Date));
		}
		
		table.setComplete(true);
		return table;
	}
	
	private PdfPTable createForecastInfo2(float maxHeight, float lastRowHeight, ForecastReportDTO dto) {
		PdfPTable table = new PdfPTable(new float[]{2f,1.5f,1.5f});
		table.setTotalWidth(300f);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.getDefaultCell().setPadding(5f);
		
		
		PdfPCell topCell = new PdfPCell(new Phrase("우주기상 특보 발생확률(시험운영)", fontNormal10));
		pdfStyle.setCellStyle(topCell, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE, 25f, new BaseColor(220, 216, 194));
		topCell.setColspan(3);
		topCell.setPadding(5f);
		table.addCell(topCell);
		
		float rowHeight = (maxHeight - 25f - lastRowHeight) / 3; 
		
		NumberFormat percentFormat = NumberFormat.getPercentInstance();
		PdfPCell cell = textHeader("기상위성운영");
		cell.setFixedHeight(rowHeight);
		table.addCell(cell);
		table.addCell(dto.getNot1_probability1()==null?null:percentFormat.format(dto.getNot1_probability1()));
		table.addCell(dto.getNot1_probability2()==null?null:percentFormat.format(dto.getNot1_probability2()));
		
		cell = textHeader("극항로 항공기상");
		cell.setFixedHeight(rowHeight);
		table.addCell(cell);
		table.addCell(dto.getNot2_probability1()==null?null:percentFormat.format(dto.getNot2_probability1()));
		table.addCell(dto.getNot2_probability2()==null?null:percentFormat.format(dto.getNot2_probability2()));
		
		cell = textHeader("전리권기상");
		cell.setFixedHeight(rowHeight);
		table.addCell(cell);
		table.addCell(dto.getNot3_probability1()==null?null:percentFormat.format(dto.getNot3_probability1()));
		table.addCell(dto.getNot3_probability2()==null?null:percentFormat.format(dto.getNot3_probability2()));
		
		LocalDate writeDate = new LocalDate(dto.getWrite_dt());
		table.addCell(textCell2("기 준"));
		table.addCell(textCell2(writeDate.plusDays(1).toString("MM월 dd일")));
		table.addCell(textCell2(writeDate.plusDays(2).toString("MM월 dd일")));
		
		table.setExtendLastRow(false, false);
		table.setComplete(true);
		
		return table;
	}
	
	private PdfPTable createForecastInfo3(ForecastReportDTO dto) {
		PdfPTable table = new PdfPTable(1);
		table.setWidthPercentage(100f);
		
		PdfPCell cell;
		
		try {
			File file1 = new File(FigureLocationResource.getPath() + File.separator + dto.getFile_path1(), dto.getFile_nm1());
			Image file1Image = Image.getInstance(file1.toURI().toURL());
			file1Image.scaleToFit(180f, 180f);
			
			cell = new PdfPCell(file1Image);
			cell.setBorder(Rectangle.NO_BORDER);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
		} catch (Exception e) {
			// TODO: handle exception
			table.addCell(e.getMessage());
		}
		
		return table;
	}
	
	private PdfPCell textHeader(String title) {
		PdfPCell cell = new PdfPCell(new Phrase(title, fontNormal10));
		cell.setBackgroundColor(new BaseColor(197, 215, 240));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		setAlignMiddle(cell);
		return cell;
	}
	
	private PdfPCell textContent(String title) {
		PdfPCell cell = new PdfPCell(new Phrase(title, fontNormal10));
		cell.setFixedHeight(26f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		setAlignMiddle(cell);
		return cell;
	}
	
	private PdfPCell textCell2(String title) {
		PdfPCell cell = new PdfPCell(new Phrase(title, fontNormal10));
		cell.setBackgroundColor(new BaseColor(217, 217, 217));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		setAlignMiddle(cell);
		return cell;
	}

	
	private Phrase getTitle(PdfContentByte canvas, BaseColor color, String title) throws BadElementException {
		canvas.saveState();
		PdfTemplate template = canvas.createTemplate(12f, 12f);
		template.setLineWidth(0.5f);
		template.setColorFill(color);
		template.setColorStroke(BaseColor.BLACK);
		template.rectangle(0f, 0f, 12f, 12f);
		template.fillStroke();
		canvas.restoreState();
		Phrase phrase = new Phrase(new Chunk(Image.getInstance(template), 0f, -2f));
		phrase.add(new Chunk(title, fontNormal10));
		return phrase;
	}

	private void createContentCell(String title, PdfPTable parentTable, PdfPCell content) {
		PdfPTable table = new PdfPTable(1);
		PdfPCell titleCell = new PdfPCell(new Paragraph("□ " + title, fontBold12));
		titleCell.setPadding(5f);
		titleCell.setBorder(Rectangle.NO_BORDER);
		table.addCell(titleCell);
		if(content != null) {
			content.setBorder(0);
			content.setPadding(5f);
			table.addCell(content);
		}
		
		PdfPCell subCell = new PdfPCell(table);
		if("개 요".equals(title)) {
			subCell.setMinimumHeight(200f);
		}
		else if("주의사항".equals(title)) {
			subCell.setMinimumHeight(100f);
		}
		else if("상세정보".equals(title)) {
			subCell.setMinimumHeight(250f);
		}
		
		subCell.setBorderWidth(1.0f);
		
		parentTable.addCell(subCell);
	}
}
