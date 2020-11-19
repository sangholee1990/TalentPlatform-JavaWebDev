package com.gaia3d.web.util;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;

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
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

public class ExportWarningReportPdf {
	final BaseColor data1Color = BaseColor.YELLOW;
	final BaseColor data2Color = BaseColor.RED;
	final BaseColor data3Color = new BaseColor(0, 176, 80);
	
	private FileSystemResource ForecastReportLocationResource;
	
	public class PageEvent extends PdfPageEventHelper {
		@Override
		public void onGenericTag(PdfWriter writer, Document pdfDocument, Rectangle rect, String text) {
			if ("rectangle".equals(text))
				strip(writer.getDirectContent(), rect);
			else if ("ellipse".equals(text))
				ellipse(writer.getDirectContentUnder(), rect);
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

	public ExportWarningReportPdf(File basePath, String font) throws DocumentException, IOException {
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

		String wrn_flag_str = "";
		wrn_flag_str = "S".equals(dto.getWrn_flag()) ? "발령":"해제";
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM");
		
		String title = dto.getTitle() + " " + wrn_flag_str + " (제 " + sdf.format(dto.getPublish_dt()) + " - " + dto.getRmk1() + " 호)";
		
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

		PdfPCell summaryCell = new PdfPCell();
		
		List list = new List(false, 15f);
		list.setIndentationLeft(5f);
		list.setListSymbol(new Chunk("\u25CB", fontNormal12));
		
		if(dto.getContents() != null && !dto.getContents().isEmpty()) {
			for(String content : dto.getContents().split("--")) {	
				if(!StringUtils.isEmpty(StringUtils.trim(content))){
					Chunk chunk = new Chunk(content, fontNormal12);
					chunk.setCharacterSpacing(-0.4f);
					ListItem listItem = new ListItem(chunk);
					listItem.setSpacingAfter(3.0f);
					list.add(listItem);
				}
			}
		}
		
		summaryCell.addElement(list);
		
		createContentCell("개 요", mainTable, summaryCell);
		
		PdfPTable table = new PdfPTable(new float[]{1.5f, 3f, 3f, 3f});
		table.setWidthPercentage(100f);
		
		PdfPCell cell = new PdfPCell(new Phrase("구분", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED_ALL);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("기상위성운영", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("극항로 항공기상", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("전리권기상", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("특보종류", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED_ALL);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase(dto.getNot1_type(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot2_type(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot3_type(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBackgroundColor(new BaseColor(255, 230, 187));
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);			
		
		cell = new PdfPCell(new Phrase("발표시각", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED_ALL);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);					

		cell = new PdfPCell(new Phrase(dto.getNot1_publish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot2_publish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot3_publish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("종료시각", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED_ALL);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot1_finish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);			
		
		cell = new PdfPCell(new Phrase(dto.getNot2_finish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		
		table.addCell(cell);			

		cell = new PdfPCell(new Phrase(dto.getNot3_finish(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);			

		cell = new PdfPCell(new Phrase("대상", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED_ALL);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot1_tar(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot2_tar(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot3_tar(), fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_BASELINE);
		cell.setPaddingLeft(8f);
		cell.setPaddingRight(8f);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		PdfPCell c = new PdfPCell(table);
		c.setBorder(Rectangle.BOX);
		c.setBorderWidth(1f);
		c.setPadding(0);
		mainTable.addCell(c);
			
		createContentCell("주의사항", mainTable, new PdfPCell(createWRNNotice(dto)));
		
		createContentCell("상세정보", mainTable, new PdfPCell(특보상세정보(writer, dto, params)));
		
		
		String footerText = String.valueOf(params.get("footerText2"));
		//if(footerText == null)footerText = "□ 연락처 070-7850-5735 / 홈페이지  http://swfc.kma.go.kr ";
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

		mainTable.setComplete(true);
		mainTable.getRow(1).setMaxHeights(document.getPageSize().getHeight() - document.topMargin() - document.bottomMargin() - mainTable.getTotalHeight() + mainTable.getRow(1).getMaxHeights());
		document.add(mainTable);
		document.close();
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
	
	private PdfPTable 특보상세정보(PdfWriter writer, ForecastReportDTO dto, Map<String, Object> params) throws DocumentException, MalformedURLException, IOException {
		PdfPCell cell;
		
		PdfPTable detailTable = new PdfPTable(2);
		detailTable.setWidthPercentage(100f);
		detailTable.setWidths(new float[]{1f, 1f});
		
		cell = new PdfPCell(new Phrase(dto.getFile_title1(), fontBold12));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setPadding(8f);
		detailTable.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getFile_title2(), fontBold12));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setPadding(8f);
		detailTable.addCell(cell);

		try {
			File file1 = new File(ForecastReportLocationResource.getPath(), dto.getFile_path1());
			Image file1Image = Image.getInstance(file1.toURI().toURL());
			
			file1Image.scaleToFit(200f, 200f);
			
			cell = new PdfPCell(file1Image);
			cell.setBorder(Rectangle.NO_BORDER);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			detailTable.addCell(cell);
		}catch(Exception ex) {
			detailTable.addCell(ex.getMessage());
		}
		
		try {
			File file2 = new File(ForecastReportLocationResource.getPath(), dto.getFile_path2());
			Image file2Image = Image.getInstance(file2.toURI().toURL());
			
			file2Image.scaleToFit(200f, 200f);
			
			cell = new PdfPCell(file2Image);
			cell.setBorder(Rectangle.NO_BORDER);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			detailTable.addCell(cell);
		}catch(Exception ex) {
			detailTable.addCell(ex.getMessage());
		}
		
		String footerText1 = String.valueOf(params.get("footerText1"));
		if(footerText1 == null) footerText1 = "※ 태양복사, 태양고에너지 입자, 지구자기장 교란에 관한 예경보는 미래창조과학부 우주전파센터에서 제공";
		
		cell = new PdfPCell(new Phrase(footerText1, fontNormal10));
		cell.setColspan(2);
		cell.setBorder(0);
        cell.setPaddingBottom(10f);
		detailTable.addCell(cell);
		
		return detailTable;
	}	
	
	private PdfPTable createWRNNotice(ForecastReportDTO dto) throws BadElementException {
		PdfPTable table = new PdfPTable(new float[]{1.0f,3.0f});
		table.setWidthPercentage(100f);
		
		PdfPCell cell = new PdfPCell(new Phrase("구        분", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		cell.setBackgroundColor(new BaseColor(241, 241, 241));
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("주 의 사 항", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("기상위성운영", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		cell.setBackgroundColor(new BaseColor(241, 241, 241));
		table.addCell(cell);

		cell = new PdfPCell(new Phrase(dto.getNot1_desc()==null?null:Joiner.on("\0및\0").skipNulls().join(dto.getNot1_desc()), fontNormal12));
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("극항로 항공기상", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		cell.setBackgroundColor(new BaseColor(241, 241, 241));
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot2_desc()==null?null:Joiner.on("\0및\0").skipNulls().join(dto.getNot2_desc()), fontNormal12));
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("전리권기상", fontBold12));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		cell.setBackgroundColor(new BaseColor(241, 241, 241));
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase(dto.getNot3_desc()==null?null:Joiner.on("\0및\0").skipNulls().join(dto.getNot3_desc()), fontNormal12));
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPaddingBottom(5f);
		table.addCell(cell);
		
		return table;
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
		parentTable.addCell(table);
	}
	
	public static void main(String[] arg) {
		
		String[] test = {"통신장애 발생가능", "GPS 신호오차 발생가능"};
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(Joiner.on("\0및\0").skipNulls().join(test));
	}
}
