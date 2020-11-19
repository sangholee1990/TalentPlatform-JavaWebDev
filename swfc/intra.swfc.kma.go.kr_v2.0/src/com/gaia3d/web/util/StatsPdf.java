package com.gaia3d.web.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.ClassPathResource;

import com.gaia3d.web.controller.admin.StatsController;
import com.gaia3d.web.dto.ChartData;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.SWPCAceMag;
import com.gaia3d.web.dto.SWPCGoesProtonFlux;
import com.gaia3d.web.dto.SWPCGoesXray1M;
import com.gaia3d.web.dto.SimpleDoubleValueChartData;
import com.gaia3d.web.dto.SimpleIntegerValueChartData;
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
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfAction;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class StatsPdf {
	
	final BaseFont baseFont;
	final Font font20;
	final Font fontBold20;
	final Font fontBold20Under;
	final Font fontNormal12;
	final Font fontBold12;
	final Font fontNormal10;
	final Font fontBold10;
	final Font fontBold10Blue;
	final Font small = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC);
	
	PdfPCell defaultCellStyle = new PdfPCell();
	
	final File basePath;
	
	public StatsPdf(File basePath, String font) throws DocumentException, IOException {
		this.basePath = basePath;
		
		defaultCellStyle.setPadding(5);
		defaultCellStyle.setHorizontalAlignment(Element.ALIGN_CENTER);
		defaultCellStyle.setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		baseFont = BaseFont.createFont(font, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		
		font20 = new Font(baseFont, 20);
		fontBold20 = new Font(baseFont, 20, Font.BOLD);
		fontBold20Under = new Font(baseFont, 20, Font.BOLD|Font.UNDERLINE);
		fontNormal12 = new Font(baseFont, 12);
		fontBold12 = new Font(baseFont, 12, Font.BOLD);
		
		fontNormal10 = new Font(baseFont, 8);
		fontBold10 = new Font(baseFont, 10, Font.BOLD);
		fontBold10Blue = new Font(baseFont, 10, Font.BOLD, BaseColor.BLUE);
	}
	
	public void createPdf(Map<String, Object> pdfParamMap, OutputStream output, String startYear, String startMonth, String search_current, String search_kind) throws Exception {
		
		List<SWPCGoesXray1M> xrayStatReport =  (List<SWPCGoesXray1M>)pdfParamMap.get("xrayTable");
		List<SWPCGoesProtonFlux> protonStatReport = (List<SWPCGoesProtonFlux>)pdfParamMap.get("protonTable");
		List<SimpleIntegerValueChartData> kpStatReport = (List<SimpleIntegerValueChartData>)pdfParamMap.get("kpTable");
		List<SimpleDoubleValueChartData> mpStatReport = (List<SimpleDoubleValueChartData>)pdfParamMap.get("mpTable");
		List<SWPCAceMag> btStatReport = (List<SWPCAceMag>)pdfParamMap.get("btTable");
		List<SimpleDoubleValueChartData> bulk_spdStatReport = (List<SimpleDoubleValueChartData>)pdfParamMap.get("bulk_spdTable");
		List<SimpleDoubleValueChartData> pro_densStatReport = (List<SimpleDoubleValueChartData>)pdfParamMap.get("pro_densTable");
		List<SimpleDoubleValueChartData> ion_tempStatReport = (List<SimpleDoubleValueChartData>)pdfParamMap.get("ion_tempTable");
		
		String xrayImage = (String)pdfParamMap.get("xrayImage");
		String protonImage = (String)pdfParamMap.get("protonImage");
		String mpImage = (String)pdfParamMap.get("mpImage");
		String kpImage = (String)pdfParamMap.get("kpImage");
		String btImage = (String)pdfParamMap.get("btImage");
		String bulk_spdImage = (String)pdfParamMap.get("bulk_spdImage");
		String pro_densImage = (String)pdfParamMap.get("pro_densImage");
		String ion_tempImage = (String)pdfParamMap.get("ion_tempImage");
		
		Document document = new Document();		// com.lowagie.text.Document 클래스 인스턴스 생성
		PdfWriter writer = PdfWriter.getInstance(document, output);     // 문서를 하드디스크에 써넣음
		document.setMarginMirroring(false);								// 홀수 / 짝수 페이지의 여백 반영을 하지 않음
		document.open();                                                // 문서의 시작
		
		PdfPTable mainTable = new PdfPTable(1);							// 문서 메인 테이블 객체 생성
		mainTable.getDefaultCell().setBorderWidth(1.0f);                // 문서 메인 테이블의 테두리 길이 설정
		mainTable.setWidthPercentage(100f); 							// 문서 메인 테이블의 길이를 설정
		mainTable.setTotalWidth(PageSize.A4.getWidth() - document.leftMargin() - document.rightMargin() * mainTable.getWidthPercentage() / 100);
		mainTable.setLockedWidth(true);
		
		// 제목, 게시자, 발료일, 로고 테이블
		PdfPTable titleTable = new PdfPTable(1);
		titleTable.setWidthPercentage(100f);
		titleTable.getDefaultCell().setBorder(0);
		titleTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		titleTable.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
				
		// 제목
		titleTable.addCell(new Phrase("우주기상 월간통계", fontBold20Under));
		
		PdfPTable subTitleTable = new PdfPTable(2);
		// 로고
		ClassPathResource s = new ClassPathResource("kma.jpg");
		// File s = new File("kma.jpg");
		Image iconImage = Image.getInstance(s.getURL());
		iconImage.scaleToFit(50f, 50f);
		PdfPCell iconCell = new PdfPCell(iconImage);
		iconCell.setBorder(0);
		iconCell.setRowspan(6);
		subTitleTable.addCell(iconCell);
		
		PdfPCell publisherCell = new PdfPCell(new Phrase("\n국가기상위성센터", fontBold12));
		publisherCell.setBorder(0);
		publisherCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publisherCell);
		
		PdfPCell publishDateCell = new PdfPCell(new Phrase("\n" + startYear + "년" + " " + startMonth + "월",  fontBold12));
		publishDateCell.setBorder(0);
		publishDateCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		subTitleTable.addCell(publishDateCell);	
		
		subTitleTable.setWidthPercentage(100f);
		subTitleTable.setExtendLastRow(false, false);
		
		titleTable.addCell(subTitleTable);
		titleTable.setComplete(true);
		mainTable.addCell(titleTable);
		
		if(search_current == null ) search_current = "";
		if(search_current.equals("")) {
			PdfPTable contentTable1 = new PdfPTable(1);

			// 태양복사폭풍
			if(xrayStatReport != null || xrayImage != null){
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable1.addCell(cell);
				afterTableSetting("태양복사폭풍", contentTable1);
			}
			
			if(search_kind.equals("") && xrayStatReport != null && xrayImage != null){
				contentTable1.addCell(Image.getInstance(xrayImage));
				contentTable1.addCell("\n");
				contentTable1.addCell(gridXrayStatReport(xrayStatReport));
			}
			
			if(search_kind.equals("grid") && xrayStatReport != null) {
				contentTable1.addCell(gridXrayStatReport(xrayStatReport));
			}
			
			if(search_kind.equals("graph") && xrayImage != null) {
				contentTable1.addCell(Image.getInstance(xrayImage));
			}
			
			titleTable.addCell(contentTable1);
			mainTable.addCell(contentTable1);
			
			PdfPTable contentTable2 = new PdfPTable(1);   // 문서 내용 테이블 객체 생성
			
			// 태양입자폭풍
			if(protonStatReport != null || protonImage != null){
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable2.addCell(cell);
				afterTableSetting("태양입자폭풍", contentTable2);
			}
						
			if(search_kind.equals("") && protonStatReport != null && protonImage != null){
				contentTable2.addCell(Image.getInstance(protonImage));
				contentTable2.addCell("\n");
				contentTable2.addCell(gridProtonStatReport(protonStatReport));
			}
						
			if(search_kind.equals("grid") && protonStatReport != null) {
				contentTable2.addCell(gridProtonStatReport(protonStatReport));
			}
						
			if(search_kind.equals("graph") && protonImage != null){
				contentTable2.addCell(Image.getInstance(protonImage));
			}
			
			mainTable.addCell(contentTable2);
			
			PdfPTable contentTable3 = new PdfPTable(1);
			
			// 지자기폭풍
			if(kpStatReport != null || kpImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable3.addCell(cell);
				afterTableSetting("지자기 폭풍", contentTable3);
			}
						
			if(search_kind.equals("") && kpStatReport != null && kpImage != null) {
				contentTable3.addCell(Image.getInstance(kpImage));
				contentTable3.addCell("\n");
				contentTable3.addCell(gridKpStatReport(kpStatReport));
			}
						
			if(search_kind.equals("grid") && kpStatReport != null) {
				contentTable3.addCell(gridKpStatReport(kpStatReport));
			}
						
			if(search_kind.equals("graph") && kpImage != null){
				contentTable3.addCell(Image.getInstance(kpImage));
			}
			
			mainTable.addCell(contentTable3);
			
			PdfPTable contentTable4 = new PdfPTable(1);
			
			// 자기권계면
			if(mpStatReport != null || mpImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable4.addCell(cell);
				afterTableSetting("자기권 계면", contentTable4);
			}
					
			if(search_kind.equals("") && search_kind.equals("") && mpStatReport != null && mpImage != null) {
				contentTable4.addCell(Image.getInstance(mpImage));
				contentTable4.addCell("\n");
				contentTable4.addCell(gridMpStatReport(mpStatReport));
			}
						
			if(search_kind.equals("grid") && mpStatReport != null) {
				contentTable4.addCell(gridMpStatReport(mpStatReport));
			}
						
			if(search_kind.equals("graph") && mpImage != null) {
				contentTable4.addCell(Image.getInstance(mpImage));
			}
			
			mainTable.addCell(contentTable4);
			
			PdfPTable contentTable5 = new PdfPTable(1);
			
			// IMF자기장
			if(btStatReport != null || btImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable5.addCell(cell);
				afterTableSetting("IMF자기장", contentTable5);
			}
								
			if(search_kind.equals("") && search_kind.equals("") && btStatReport != null && btImage != null) {
				contentTable5.addCell(Image.getInstance(btImage));
				contentTable5.addCell("\n");
				contentTable5.addCell(gridBtStatReport(btStatReport));
			}
									
			if(search_kind.equals("grid") && btStatReport != null) {
				contentTable5.addCell(gridBtStatReport(btStatReport));
			}
									
			if(search_kind.equals("graph") && btImage != null) {
				contentTable5.addCell(Image.getInstance(btImage));
			}
						
			mainTable.addCell(contentTable5);
				
			PdfPTable contentTable6 = new PdfPTable(1);
			
			// 태양풍 속도
			if(bulk_spdStatReport != null || bulk_spdImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable6.addCell(cell);
				afterTableSetting("태양풍 속도", contentTable6);
			}
			
			if(search_kind.equals("") && search_kind.equals("") && bulk_spdStatReport != null && bulk_spdImage != null) {
				contentTable6.addCell(Image.getInstance(bulk_spdImage));
				contentTable6.addCell("\n");
				contentTable6.addCell(gridBulk_spdStatReport(bulk_spdStatReport));
			}
			
			if(search_kind.equals("grid") && bulk_spdStatReport != null) {
				contentTable6.addCell(gridBulk_spdStatReport(bulk_spdStatReport));
			}
						
			if(search_kind.equals("graph") && bulk_spdImage != null) {
				contentTable6.addCell(Image.getInstance(bulk_spdImage));
			}
			
			mainTable.addCell(contentTable6);
			
			PdfPTable contentTable7 = new PdfPTable(1);
			
			// 태양풍 밀도
			if(pro_densStatReport != null || pro_densImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable7.addCell(cell);
				afterTableSetting("태양풍 밀도", contentTable7);
			}
						
			if(search_kind.equals("") && search_kind.equals("") && pro_densStatReport != null && pro_densImage != null) {
				contentTable7.addCell(Image.getInstance(pro_densImage));
				contentTable7.addCell("\n");
				contentTable7.addCell(gridPro_densStatReport(pro_densStatReport));
			}
						
			if(search_kind.equals("grid") && pro_densStatReport != null) {
				contentTable7.addCell(gridPro_densStatReport(pro_densStatReport));
			}
									
			if(search_kind.equals("graph") && pro_densImage != null) {
				contentTable7.addCell(Image.getInstance(pro_densImage));
			}
			
			mainTable.addCell(contentTable7);
			
			PdfPTable contentTable8 = new PdfPTable(1);
			
			// 태양풍 온도
			if(ion_tempStatReport != null || ion_tempImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable8.addCell(cell);
				afterTableSetting("태양풍 온도", contentTable8);
			}
			
			if(search_kind.equals("") && ion_tempStatReport != null && ion_tempImage != null) {
				contentTable8.addCell(Image.getInstance(ion_tempImage));
				contentTable8.addCell("\n");
				contentTable8.addCell(gridIon_tempStatReport(ion_tempStatReport));
			}
						
			if(search_kind.equals("grid") && ion_tempStatReport != null) {
				contentTable8.addCell(gridIon_tempStatReport(ion_tempStatReport));
			}
									
			if(search_kind.equals("graph") && ion_tempImage != null) {
				contentTable8.addCell(Image.getInstance(ion_tempImage));
			}
			
			mainTable.addCell(contentTable8);
		}
			
		if(search_current.equals("XRAY") && xrayStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(xrayStatReport != null || xrayImage != null){
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("태양복사폭풍", contentTable);
			}
			
			if(search_kind.equals("") && xrayStatReport != null && xrayImage != null){
				contentTable.addCell(Image.getInstance(xrayImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridXrayStatReport(xrayStatReport));
			}
			
			if(search_kind.equals("grid") && xrayStatReport != null){
				contentTable.addCell(gridXrayStatReport(xrayStatReport));
			}
			
			if(search_kind.equals("graph") && xrayImage != null) {
				contentTable.addCell(Image.getInstance(xrayImage));
			}
			
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("PROTON") && protonStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(protonStatReport != null || protonImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("태양입자폭풍", contentTable);
			}
			
			if(search_kind.equals("") && protonStatReport != null && protonImage != null) {
				contentTable.addCell(Image.getInstance(protonImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridProtonStatReport(protonStatReport));
			}
			
			if(search_kind.equals("grid") && protonStatReport != null){
				contentTable.addCell(gridProtonStatReport(protonStatReport));
			}
			
			if(search_kind.equals("graph") && protonImage != null){
				contentTable.addCell(Image.getInstance(protonImage));
			}
			
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("KP") && kpStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(kpStatReport != null || kpImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("지자기 폭풍", contentTable);
			}
			
			if(search_kind.equals("") && kpStatReport != null && kpImage != null) {
				contentTable.addCell(Image.getInstance(kpImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridKpStatReport(kpStatReport));
			}
		
			if(search_kind.equals("grid") && kpStatReport != null) {
				contentTable.addCell(gridKpStatReport(kpStatReport));
			}
			
			if(search_kind.equals("graph") && kpImage != null) {
				contentTable.addCell(Image.getInstance(kpImage));
			}
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("MP") && mpStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(mpStatReport != null || mpImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("자기권 계면", contentTable);
			}
			
			if(search_kind.equals("") && search_kind.equals("") && mpStatReport != null && mpImage != null) {
				contentTable.addCell(Image.getInstance(mpImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridMpStatReport(mpStatReport));
			}
			
			if(search_kind.equals("grid") && mpStatReport != null) {
				contentTable.addCell(gridMpStatReport(mpStatReport));
			}
			
			if(search_kind.equals("graph") && mpImage != null) {
				contentTable.addCell(Image.getInstance(mpImage));
			}
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("BT") && btStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(btStatReport != null || btImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("IMF자기장", contentTable);
			}
			
			if(search_kind.equals("") && btStatReport != null && btImage != null) {
				contentTable.addCell(Image.getInstance(btImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridBtStatReport(btStatReport));
			}
			
			if(search_kind.equals("grid") && btStatReport != null) {
				contentTable.addCell(gridBtStatReport(btStatReport));
			}
						
			if(search_kind.equals("graph") && btImage != null) {
				contentTable.addCell(Image.getInstance(btImage));
			}
			
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("BULK_SPD") && bulk_spdStatReport != null) {	
			PdfPTable contentTable = new PdfPTable(1);
			if(bulk_spdStatReport != null || bulk_spdImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("태양풍 속도", contentTable);
			}
			
			if(search_kind.equals("") && bulk_spdStatReport != null && bulk_spdImage != null) {
				contentTable.addCell(Image.getInstance(bulk_spdImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridBulk_spdStatReport(bulk_spdStatReport));
			}
			
			if(search_kind.equals("grid") && bulk_spdStatReport != null) {
				contentTable.addCell(gridBulk_spdStatReport(bulk_spdStatReport));
			}
						
			if(search_kind.equals("graph") && bulk_spdImage != null) {
				contentTable.addCell(Image.getInstance(bulk_spdImage));
			}
			
			mainTable.addCell(contentTable);
		}
		
		if(search_current.equals("PRO_DENS") && pro_densStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(pro_densStatReport != null || pro_densImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("태양풍 밀도", contentTable);
			}
			
			if(search_kind.equals("") && pro_densStatReport != null && pro_densImage != null) {
				contentTable.addCell(Image.getInstance(pro_densImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridPro_densStatReport(pro_densStatReport));
			}
			
			if(search_kind.equals("table") && pro_densStatReport != null) {
				contentTable.addCell(gridPro_densStatReport(pro_densStatReport));
			}
						
			if(search_kind.equals("grid") && pro_densImage != null) {
				contentTable.addCell(Image.getInstance(pro_densImage));
			}
			
			mainTable.addCell(contentTable);
		}
				
		if(search_current.equals("ION_TEMP") && ion_tempStatReport != null) {
			PdfPTable contentTable = new PdfPTable(1);
			if(ion_tempStatReport != null || ion_tempImage != null) {
				PdfPCell cell = new PdfPCell(new Phrase("\n"));
				cell.setBorder(0);
				contentTable.addCell(cell);
				afterTableSetting("태양풍 온도", contentTable);
			}
			
			if(search_kind.equals("") && ion_tempStatReport != null && ion_tempImage != null) {
				contentTable.addCell(Image.getInstance(ion_tempImage));
				contentTable.addCell("\n");
				contentTable.addCell(gridIon_tempStatReport(ion_tempStatReport));
			}
			
			if(search_kind.equals("grid") && ion_tempStatReport != null) {
				contentTable.addCell(gridIon_tempStatReport(ion_tempStatReport));
			}
						
			if(search_kind.equals("graph") && ion_tempImage != null) {
				contentTable.addCell(Image.getInstance(ion_tempImage));
			}
			
			mainTable.addCell(contentTable);
		}
		

		titleTable.setComplete(true);
		
		document.add(mainTable);
		document.close(); 	// 문서를 닫음
	}
	
	/**
	 * 서브 테이블의 제목값을 셋팅한후 테이블 반환 
	 * @return
	 */
	private PdfPTable getTableInit(){
		PdfPTable summaryTable3 = new PdfPTable(new float[] {1f, 1f, 1f});
		summaryTable3.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		summaryTable3.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		summaryTable3.getDefaultCell().setBackgroundColor(BaseColor.DARK_GRAY);
		summaryTable3.addCell(new Phrase("날짜", fontBold12));
		summaryTable3.addCell(new Phrase("평균", fontBold12));
		summaryTable3.addCell(new Phrase("최대값", fontBold12));
		summaryTable3.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
		summaryTable3.getDefaultCell().setBackgroundColor(BaseColor.WHITE);
		summaryTable3.setWidthPercentage(90);
		return summaryTable3;
	}
	
	/**
	 * 
	 * 서브 테이블을 셋팅
	 * @return
	 */
	private void afterTableSetting(String title, PdfPTable contentTable){
		contentTable.setWidthPercentage(100f);
		contentTable.getDefaultCell().setBorder(0);
		contentTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		if(title != null) contentTable.addCell(new Phrase(title, fontBold12));
	}
	
	/**
	 * 
	 * 태양복사폭풍 PDF 테이블 
	 * @return
	 */
	private PdfPTable gridXrayStatReport(List<SWPCGoesXray1M> xrayStatReport){
		PdfPTable summaryTable = getTableInit();
		if(xrayStatReport != null){
			for(int i=0; i<xrayStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(xrayStatReport.get(i).getTm(), fontNormal10));
				
				if(xrayStatReport.get(i).getAvg_long_flux() == null && xrayStatReport.get(i).getMax_long_flux() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(""));
				} else {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(xrayStatReport.get(i).getAvg_long_flux()), fontNormal10));
				}
				
				if(xrayStatReport.get(i).getMax_long_flux() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(""));
				} else {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(xrayStatReport.get(i).getMax_long_flux()), fontNormal10));
				}
			}
		} 
		return summaryTable;
	}
	
	/**
	 * 
	 * 태양입자폭풍 PDF 테이블
	 * @return
	 */
	private PdfPTable gridProtonStatReport(List<SWPCGoesProtonFlux> protonStatReport){
		PdfPTable summaryTable = getTableInit();
		if(protonStatReport != null){
			for(int i=0; i<protonStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(protonStatReport.get(i).getTm(), fontNormal10));
				
				if(protonStatReport.get(i).getAvg_p5() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(" "));
				} else if(protonStatReport.get(i).getAvg_p5() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(protonStatReport.get(i).getAvg_p5()), fontNormal10));
				}
				
				if(protonStatReport.get(i).getMax_p5() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(" "));
				} else if(protonStatReport.get(i).getMax_p5() != null){
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(protonStatReport.get(i).getMax_p5()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * 지자기폭풍  PDF 테이블
	 * @return
	 */
	private PdfPTable gridKpStatReport(List<SimpleIntegerValueChartData> kpStatReport){
		PdfPTable summaryTable = getTableInit();
		if(kpStatReport != null){
			for(int i=0; i<kpStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(kpStatReport.get(i).getTm(), fontNormal10));
				
				if(kpStatReport.get(i).getAvg_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(" "));
				} else if(kpStatReport.get(i).getAvg_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(kpStatReport.get(i).getAvg_value()), fontNormal10));
				}
				
				if(kpStatReport.get(i).getMax_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(" "));
				} else if(kpStatReport.get(i).getMax_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(kpStatReport.get(i).getMax_value()), fontNormal10));
				}
				
				
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * 자기권계면 PDF 테이블
	 * @return
	 */
	private PdfPTable gridMpStatReport(List<SimpleDoubleValueChartData> mpStatReport){
		PdfPTable summaryTable = getTableInit();
		if(mpStatReport != null){
			for(int i=0; i<mpStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(mpStatReport.get(i).getTm(), fontNormal10));
				
				if(mpStatReport.get(i).getAvg_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(mpStatReport.get(i).getAvg_value() != null){
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(mpStatReport.get(i).getAvg_value()), fontNormal10));
				}
				
				if(mpStatReport.get(i).getMax_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(mpStatReport.get(i).getMax_value() != null){
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(mpStatReport.get(i).getMax_value()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * IMF 자기장 PDF 테이블
	 * @return
	 */
	private PdfPTable gridBtStatReport(List<SWPCAceMag> btStatReport) {
		PdfPTable summaryTable = getTableInit();
		if(btStatReport != null) {
			for(int i=0; i<btStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(btStatReport.get(i).getTm(), fontNormal10));
				
				if(btStatReport.get(i).getAvg_bt() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(btStatReport.get(i).getAvg_bt() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(btStatReport.get(i).getAvg_bt()), fontNormal10));
				}
				
				if(btStatReport.get(i).getMax_bt() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(btStatReport.get(i).getMax_bt() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(btStatReport.get(i).getMax_bt()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * 태양풍 속도  PDF 테이블
	 * @return
	 */
	private PdfPTable gridBulk_spdStatReport(List<SimpleDoubleValueChartData> bulk_spdStatReport) {
		PdfPTable summaryTable = getTableInit();
		if(bulk_spdStatReport != null) {
			for(int i=0; i<bulk_spdStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(bulk_spdStatReport.get(i).getTm(), fontNormal10));
				
				if(bulk_spdStatReport.get(i).getAvg_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(bulk_spdStatReport.get(i).getAvg_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(bulk_spdStatReport.get(i).getAvg_value()), fontNormal10));
				}
				
				if(bulk_spdStatReport.get(i).getMax_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(bulk_spdStatReport.get(i).getMax_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(bulk_spdStatReport.get(i).getMax_value()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * 태양풍 밀도  PDF 테이블
	 * @return
	 */
	private PdfPTable gridPro_densStatReport(List<SimpleDoubleValueChartData> pro_densStatReport ) {
		PdfPTable summaryTable = getTableInit();
		if(pro_densStatReport != null) {
			for(int i=0; i<pro_densStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(pro_densStatReport.get(i).getTm(), fontNormal10));
				
				if(pro_densStatReport.get(i).getAvg_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(pro_densStatReport.get(i).getAvg_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(pro_densStatReport.get(i).getAvg_value()), fontNormal10));
				}
				
				if(pro_densStatReport.get(i).getMax_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(pro_densStatReport.get(i).getMax_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(pro_densStatReport.get(i).getMax_value()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
	
	/**
	 * 
	 * 태양풍 온도  PDF 테이블
	 * @return
	 */
	private PdfPTable gridIon_tempStatReport(List<SimpleDoubleValueChartData> ion_tempStatReport ) {
		PdfPTable summaryTable = getTableInit();
		if(ion_tempStatReport != null) {
			for(int i=0; i<ion_tempStatReport.size(); i++) {
				summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				summaryTable.addCell(new Phrase(ion_tempStatReport.get(i).getTm(), fontNormal10));
				
				if(ion_tempStatReport.get(i).getAvg_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(ion_tempStatReport.get(i).getAvg_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(ion_tempStatReport.get(i).getAvg_value()), fontNormal10));
				}
				
				if(ion_tempStatReport.get(i).getMax_value() == null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(" ");
				} else if(ion_tempStatReport.get(i).getMax_value() != null) {
					summaryTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
					summaryTable.addCell(new Phrase(String.valueOf(ion_tempStatReport.get(i).getMax_value()), fontNormal10));
				}
			}
		}
		return summaryTable;
	}
}
