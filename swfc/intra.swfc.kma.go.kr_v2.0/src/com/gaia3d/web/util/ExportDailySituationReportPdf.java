package com.gaia3d.web.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.core.io.FileSystemResource;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class ExportDailySituationReportPdf {
	
	
	private FileSystemResource FigureLocationResource;
	
	
	final BaseColor data1Color = BaseColor.YELLOW;
	final BaseColor data2Color = BaseColor.RED;
	final BaseColor data3Color = new BaseColor(0, 176, 80);
	
	final BaseFont baseFont;
	final Font font20;
	final Font fontBold20;
	final Font fontBold20UnderLine;
	final Font fontNormal12;
	final Font fontBold12;
	final Font fontNormal10;
	final Font fontBold10;
	final Font fontBold10Blue;
	final Font small = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC);
	
	PdfPCell defaultCellStyle = new PdfPCell();
	    
	final File basePath;
	
	public ExportDailySituationReportPdf(File basePath, String font) throws DocumentException, IOException {
		this.basePath = basePath;
		
		defaultCellStyle.setPadding(5);
		defaultCellStyle.setHorizontalAlignment(Element.ALIGN_CENTER);
		defaultCellStyle.setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		baseFont = BaseFont.createFont(font, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		
		font20 = new Font(baseFont, 20);
		fontBold20 = new Font(baseFont, 20, Font.BOLD);
		fontBold20UnderLine = new Font(baseFont, 20, Font.BOLD | Font.UNDERLINE);
		fontNormal12 = new Font(baseFont, 12);
		fontBold12 = new Font(baseFont, 12, Font.BOLD);

		fontNormal10 = new Font(baseFont, 10);
		fontBold10 = new Font(baseFont, 10, Font.BOLD);
		fontBold10Blue = new Font(baseFont, 10, Font.BOLD, BaseColor.BLUE);
	}
	
	public FileSystemResource getFigureLocationResource() {
		return FigureLocationResource;
	}

	public void setFigureLocationResource(FileSystemResource figureLocationResource) {
		FigureLocationResource = figureLocationResource;
	}




	public void createPdf(Map<String, Object> dto, OutputStream output) throws Exception {
		
		Image iconImage = null;
		Document document = new Document();
		PdfWriter writer = PdfWriter.getInstance(document, output);
		//writer.setPageEvent(new PageEvent());
		// document.setMargins(20, 20, 20, 20);
		HTMLWorker htmlWorker = new HTMLWorker(document);
		document.setMarginMirroring(false);
		document.open();
		
		//Paragraph paragraph = new Paragraph();
		
		
		PdfPTable wapper = new PdfPTable(1);
		wapper.getDefaultCell().setBorderWidth(0f);
		wapper.setWidthPercentage(100f);
		wapper.setTotalWidth((PageSize.A4.getWidth() - document.leftMargin() - document.rightMargin()) * wapper.getWidthPercentage() / 100);
		wapper.setLockedWidth(true);

		
		PdfPTable titleWrapper = new PdfPTable(1);
		titleWrapper.getDefaultCell().setBorderWidth(1.0f);
		
		//제목, 게시자, 발료일, 로고 테이블
		PdfPTable titleTable = new PdfPTable(1);
		titleTable.setWidthPercentage(100f);
		titleTable.getDefaultCell().setBorder(0);
		titleTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		titleTable.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		//제목
		
		String title = (String)dto.get("TITLE");
		titleTable.addCell(new Phrase(title, fontBold20UnderLine));
		//String date = dto.get("PUBLIC_DT") + " (" + dto.get("PUBLIC_DAY_NM") + ") " + dto.get("PUBLIC_HOUR") ;
		
		Date publishDate = (Date)dto.get("PUBLISH_DT"); //보고일
		
		SimpleDateFormat df = new SimpleDateFormat("\nyyyy년 MM월 dd일 (E) HH시 mm분\n");
		PdfPTable subTitleTable = new PdfPTable(1);
		//PdfPCell publisherCell = new PdfPCell(new Phrase(String.format("\n보고자 :, %s", "황명진"), fontBold12));
		PdfPCell publishDateCell = new PdfPCell(new Phrase(df.format(publishDate), fontBold12));
		publishDateCell.setBorder(0);
		publishDateCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publishDateCell);
		
		String publishWriter = (String)dto.get("WRITER"); //작성자
		PdfPCell publisherCell = new PdfPCell(new Phrase(String.format("\n보고자 : %s", publishWriter), fontBold12));
		publisherCell.setBorder(0);
		publisherCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publisherCell);
		
		subTitleTable.setWidthPercentage(100f);
		subTitleTable.setExtendLastRow(false, false);
		
		titleTable.addCell(subTitleTable);
		titleTable.setComplete(true);
		
		titleWrapper.addCell(titleTable);
		titleWrapper.setExtendLastRow(false, false);
		titleWrapper.setComplete(true);
		wapper.addCell(titleWrapper);
		
		
		PdfPCell cell = null;
		
		
		wapper.addCell(new Phrase("\n"));
		
		
		PdfPTable contentWrapper = new PdfPTable(1);
		contentWrapper.getDefaultCell().setBorderWidth(1.0f);
		contentWrapper.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		contentWrapper.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);
		
		//-----------------------------------------------//
		// 우주기상 일일 자료 상황
		//-----------------------------------------------//
		PdfPTable content = new PdfPTable(9);
		content.setWidthPercentage(100f);
		content.getDefaultCell().setLeading(0, 1.2f);
		float[] columnWidths = new float[]{7f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f};
		content.setWidths(columnWidths);
		content.getDefaultCell().setBorder(1);
		
		cell = new PdfPCell(new Phrase("우주기상 일일 자료사항", fontNormal10));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBackgroundColor(BaseColor.GRAY);
		cell.setFixedHeight(25f);
		cell.setBorder(1);
		cell.setColspan(9);
		content.addCell(cell);
		
		cell = new PdfPCell();
		cell.setMinimumHeight(30f);
		content.addCell(cell);
		
		
		String[] titles = new String[]{"태양복사폭풍\n(X-선 유속)", "태양입자폭풍\n(10Mev이상 입자량)", "지자기폭풍\n(Kp 지수)", "자기권계면\n(자기권계면 위치)"};
		for(String t : titles){
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setLeading(0, 1.2f);
			cell.setColspan(2);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		cell = new PdfPCell(new Phrase("그래프", fontNormal10));
		cell.setFixedHeight(120f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		
		//이미지 타이틀 넣기
		Date publishDateUtc = DateUtils.addHours(publishDate, -9);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH");
		String[] dateParameter = sdf.format(publishDateUtc).split("-"); 
		String yyyy = dateParameter[0];
		String mm = dateParameter[1];
		String dd = dateParameter[2];
		String hh = dateParameter[3];
		String fullDate = yyyy+mm+dd+hh;
		
		
		/*
		String xfluxImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_xflux_5m.png";
		String kpImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_kp_index.png";
		String protonImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_goes13_proton.png";
		String geomagImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_geomag_B.png";
		
		
		//이지지 넣기
		String[] images = new String[]{xfluxImgPattern,protonImgPattern,kpImgPattern,geomagImgPattern}; 
		for(String img : images){
			try{
				iconImage = Image.getInstance( MessageFormat.format(img, yyyy,mm,dd,hh,fullDate) );
				iconImage.scaleToFit(95f, 95f);
				cell = new PdfPCell(iconImage);
			}catch(Exception e){
				cell = new PdfPCell(new Phrase(""));
			}
			cell.setColspan(2);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		//이지지 넣기
		String[] images = new String[]{xfluxImgPattern,protonImgPattern,kpImgPattern,geomagImgPattern}; 
		for(String img : images){
			try{
				iconImage = Image.getInstance( MessageFormat.format(img, yyyy,mm,dd,hh,fullDate) );
				iconImage.scaleToFit(95f, 95f);
				cell = new PdfPCell(iconImage);
			}catch(Exception e){
				cell = new PdfPCell(new Phrase(""));
			}
			cell.setColspan(2);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		*/
		String xfluxImgPattern = FigureLocationResource.getPath() + (String)dto.get("FILE_PATH1") + "/" + (String)dto.get("FILE_NM1");
		String protonImgPattern = FigureLocationResource.getPath() + (String)dto.get("FILE_PATH2") + "/" + (String)dto.get("FILE_NM2");
		String kpImgPattern = FigureLocationResource.getPath() + (String)dto.get("FILE_PATH3") + "/" + (String)dto.get("FILE_NM3");
		String geomagImgPattern = FigureLocationResource.getPath() + (String)dto.get("FILE_PATH4") + "/" + (String)dto.get("FILE_NM4");
		
		//이지지 넣기
		String[] images = new String[]{xfluxImgPattern,protonImgPattern,kpImgPattern,geomagImgPattern}; 
		for(String img : images){
			try{
				//System.out.println(img);
				iconImage = Image.getInstance( img );
				iconImage.scaleToFit(115f, 115f);
				cell = new PdfPCell(iconImage);
			}catch(Exception e){
				cell = new PdfPCell(new Phrase(""));
			}
			cell.setPadding(0);
			cell.setColspan(2);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		
		cell = new PdfPCell(new Phrase("일일최대값", fontNormal10));
		cell.setRowspan(2);
		cell.setFixedHeight(66f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		
		String[] dailyMaxGradesTitles = new String[]{"최대등급\n(W/m2)", "최대치\n(pfu)", "최대치", "최소값\n(RE)" }; 
		String[] dailyMaxGrades = new String[]{(String)dto.get("NOT1_DESC"), (String)dto.get("NOT2_DESC"), (String)dto.get("NOT3_DESC"), (String)dto.get("NOT4_DESC") }; 
		
		for(int i = 0; i < dailyMaxGradesTitles.length; i++){
			cell = new PdfPCell(new Phrase(dailyMaxGradesTitles[i], fontNormal10));
			cell.setFixedHeight(33f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
			
			cell = new PdfPCell(new Phrase(dailyMaxGrades[i], fontNormal10));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		String[] dailyMaxTimeTitles = new String[]{"시간\n(UTC)", "시간\n(UTC)", "시간\n(UTC)", "시간\n(UTC)" }; 
		String[] dailyMaxTimes = new String[]{(String)dto.get("XRAY_TM"), (String)dto.get("PROTON_TM"), (String)dto.get("KP_TM"), (String)dto.get("GEOMAG_TM") }; 
		
		for(int i = 0; i < dailyMaxTimeTitles.length; i++){
			cell = new PdfPCell(new Phrase(dailyMaxTimeTitles[i], fontNormal10));
			cell.setFixedHeight(33f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
			
			cell = new PdfPCell(new Phrase(dailyMaxTimes[i], fontNormal10));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		content.setComplete(true);
		contentWrapper.addCell(content);
		
		
		//-----------------------------------------------//
		// 우주기상 정보 및 기타 전달 상황
		//-----------------------------------------------//
		content = new PdfPTable(5);
		content.setWidthPercentage(100f);
		content.getDefaultCell().setBorder(1);
		content.getDefaultCell().setLeading(0, 1.5f);
		
		cell = new PdfPCell(new Phrase("우주기상 정보 및 기타 전달 상황", fontNormal10));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBackgroundColor(BaseColor.GRAY);
		cell.setFixedHeight(25f);
		cell.setBorder(1);
		cell.setColspan(5);
		content.addCell(cell);
		
		cell = new PdfPCell(new Phrase("우주기상특보", fontNormal10));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(100f);
		cell.setRowspan(5);
		content.addCell(cell);
		
		titles = new String[] {"", "기상위성운영", "극항로 항공기상", "전리권 기상"};
		for(String t : titles){
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setFixedHeight(20f);
			content.addCell(cell);
		}
		
		String[] wrnGrades = new String[]{"등급",(String)dto.get("NOT1_TYPE"), (String)dto.get("NOT2_TYPE"), (String)dto.get("NOT3_TYPE")};
		for(String t : wrnGrades){
			if(t == null || "".equals(t)) t = "-";
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setFixedHeight(20f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		
		String[] wrnsTimes = new String[]{"발령시각(KST)",(String)dto.get("NOT1_PUBLISH"), (String)dto.get("NOT2_PUBLISH"), (String)dto.get("NOT3_PUBLISH")};
		for(String t : wrnsTimes){
			if(t == null || "".equals(t)) t = "-";
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setFixedHeight(20f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		String[] wrneTimes = new String[]{"해제시각(KST)",(String)dto.get("NOT1_FINISH"), (String)dto.get("NOT2_FINISH"), (String)dto.get("NOT3_FINISH")};
		for(String t : wrneTimes){
			if(t == null || "".equals(t)) t = "-";
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setFixedHeight(20f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		String[] wrnMaxVals = new String[]{"발생규모(최대치)",(String)dto.get("NOT1_TAR"), (String)dto.get("NOT2_TAR"), (String)dto.get("NOT3_TAR")};
		for(String t : wrnMaxVals){
			if(t == null || "".equals(t)) t = "-";
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setFixedHeight(20f);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		
		//=========================================================//
		// 우주기상 정보
		//=========================================================//
		sdf = new SimpleDateFormat("MM월 dd일");
		Date preDate = DateUtils.addDays(publishDate, -1);
		cell = new PdfPCell(new Phrase("우주기상정보\n(KST)\n(" + sdf.format(preDate) + " 9시\n~\n" + sdf.format(publishDate )+ " 9시)", fontNormal10));
		cell.setLeading(0, 1.2f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		cell = new PdfPCell(new Paragraph((String)dto.get("CONTENTS"), fontNormal10));
		//cell = new PdfPCell();
		cell.setLeading(0, 1.2f);
		cell.setColspan(4);
		cell.setMinimumHeight(120f);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		//paragraph.add("- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준\n- 태양 활동은 낮음 수준");
		
		//cell.addElement(paragraph);
		content.addCell(cell);
		
		//=========================================================//
		// 향후 3일 전망
		//=========================================================//
		Date nextDate = DateUtils.addDays(publishDate, +2);
		cell = new PdfPCell(new Phrase("향후 3일 전망\n(KST)\n(" + sdf.format(publishDate )+ "\n~\n"+ sdf.format(nextDate ) +")", fontNormal10));
		cell.setLeading(0, 1.2f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		
		Paragraph contactText = new Paragraph((String)dto.get("RMK1"), fontNormal10);
		//contactText.setLeading(20f);
		cell = new PdfPCell(contactText);
		cell.setLeading(0, 1.2f);
		cell.setColspan(4);
		cell.setMinimumHeight(90f);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		//=========================================================//
		// 자료 미 수신 현황
		//=========================================================//
		cell = new PdfPCell(new Phrase("자료 미 수신\n 현황", fontNormal10));
		cell.setRowspan(2);
		cell.setMinimumHeight(35f);
		cell.setLeading(0, 1.2f);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		titles = new String[]{"자료명", "장애시각", "복구시각", "내용"};
		for(String t : titles){
			cell = new PdfPCell(new Phrase(t, fontNormal10));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		String[] infos = new String[]{(String)dto.get("INFO1"), (String)dto.get("INFO2"), (String)dto.get("INFO3"), (String)dto.get("INFO4")};
		for(String info : infos){
			if(info == null || "".equals(info)) info = "-";
			cell = new PdfPCell(new Phrase(info, fontNormal10));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			content.addCell(cell);
		}
		
		//=========================================================//
		// 기타
		//=========================================================//
		cell = new PdfPCell(new Phrase("기타", fontNormal10));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		
		String etc = (String)dto.get("RMK2");
		if(etc == null) etc = "없음";
		cell = new PdfPCell(new Phrase(etc, fontNormal10));
		cell.setColspan(4);
		cell.setMinimumHeight(30f);
		if("".equals(etc) || "없음".equals(etc)){
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		}else{
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		}
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		content.addCell(cell);
		
		
		content.setComplete(true);
		
		contentWrapper.addCell(content);
		
		contentWrapper.setExtendLastRow(false, false);
		contentWrapper.setComplete(true);
		
		wapper.addCell(contentWrapper);
		
		
		
		
		
		//연락처 정보 작성
		/*
		PdfPTable contactTable = new PdfPTable(2);
		Paragraph contactText = new Paragraph("□ 연락처 070-7850-5735 / 홈페이지 ", fontBold10);
		Chunk imdb = new Chunk("http://swfc.kma.go.kr", fontBold10Blue);
		imdb.setAction(new PdfAction(new URL("http://swfc.kma.go.kr")));
		contactText.add(imdb);
		PdfPCell contactCell= new PdfPCell(contactText); 
		contactCell.setPadding(5f);
		contactCell.setBorder(0);
		contactTable.addCell(contactCell);
		wapper.addCell(contactTable);		
		//createContentCell("연락처 070-7850-5735 / 홈페이지 http://swfc.kma.go.kr", mainTable, null);
		*/
		
		wapper.setComplete(true);
		wapper.getRow(1).setMaxHeights(document.getPageSize().getHeight() - document.topMargin() - document.bottomMargin() - wapper.getTotalHeight() + wapper.getRow(1).getMaxHeights());
		document.add(wapper);
		
		document.close();

	}
	
	public static void main(String[] args){
		String fontPath = String.format("%s,%s", "D:\\test\\BATANG.TTC", 0);
		try {
			ExportDailySituationReportPdf pdf = new ExportDailySituationReportPdf(new File("d:\\test\\test.pdf"), fontPath);
			ByteArrayOutputStream  os = new ByteArrayOutputStream ();
			try {
				pdf.createPdf(null, os);
			
				FileOutputStream fos = new FileOutputStream("C:/Users/Administrator/Desktop/test.pdf");
				os.writeTo(fos);
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
