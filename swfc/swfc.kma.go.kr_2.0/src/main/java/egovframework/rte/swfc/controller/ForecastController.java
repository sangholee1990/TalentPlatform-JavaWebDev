package egovframework.rte.swfc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itextpdf.text.DocumentException;

import egovframework.rte.swfc.dto.ForecastReportDTO;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.exception.ReportNotFoundException;
import egovframework.rte.swfc.service.ForecastReportService;

@Controller
public class ForecastController extends BaseController {
	
	@Autowired
	private ForecastReportService forecastReportService;
	
	@Autowired(required=true)
	@Qualifier(value="ForecastReportLocationResource")
	private FileSystemResource ForecastReportLocationResource;
	
	/**
	 * 구통보문 다운로드를 진행한다.
	 * @param model
	 * @param id
	 * @param response
	 * @throws DocumentException
	 * @throws IOException
	 * @throws ReportNotFoundException
	 */
	@RequestMapping(value = "/{lang}/forecastReport/download/{id}", method = RequestMethod.GET)
	public void downloadOldReport(ModelMap model, @PathVariable("id") int id, HttpServletResponse response) throws DocumentException, IOException, ReportNotFoundException {
		MapperParam param = new MapperParam();
		param.put("id", id);
		ForecastReportDTO report = forecastReportService.selectForecastReport(param);
		if(report == null) {
			throw new ReportNotFoundException();
		}
		
		String filename = report.getFile_nm1();
		response.setContentType("application/pdf");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", String.format("inline;filename=\"%s\";", filename));
		
		File path = null;
		if(report.getRpt_seq_n() < 10000){
			path = new File(ForecastReportLocationResource.getPath(), report.getFile_path1());
		}else{
			path = new File(ForecastReportLocationResource.getPath() + File.pathSeparator + report.getFile_path1(), report.getFile_nm1());
		}
		
		FileInputStream fis = null;
		OutputStream os = null;
		try{
			os = response.getOutputStream();
			fis = new FileInputStream(path);
			int readcount = 0;
	        byte[] buf = new byte[1024*1024];
	        while((readcount = fis.read(buf)) != -1){
	        	os.write(buf, 0, readcount);
	        }
		}catch (FileNotFoundException iex){
			throw new IOException("fileNotFoundException");
		}catch (IOException ioex){
			throw new IOException("IOException");
		}finally{
			if(fis != null)fis.close();
			if(os != null)os.close();
		}
	}

}
