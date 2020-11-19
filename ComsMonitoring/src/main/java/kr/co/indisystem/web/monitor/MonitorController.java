package kr.co.indisystem.web.monitor;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import kr.co.indisystem.utils.hdf.CsvDataReadWrite;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 기본 컨트롤러
 * 
 *	Index, Http Error Page
 * 
 * */
@Controller
public class MonitorController {
	
	@Autowired
	private MonitorServiceImpl service;
	
	@Autowired
	private Environment env;
	
//	@Autowired
//	private InputCsvDataReadWrite csv;
	
	/**
	 * 첫 페이지
	 * */
	@RequestMapping({"/monitor"})
	public String index(ModelMap model){
		return "/monitor";
	}	
	
	/**
	 * 위성 영상 
	 * 
	 * 
	 * */
	@RequestMapping(value="/comsImageList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> comsImageList(ModelMap model, @RequestParam Map<String, Object> params){
		String sensor = Integer.parseInt((String)params.get("sensor"))  == 1 ? "mi" : "goci";
		String lvl = (String) params.get("lvl");
		String data = (String) params.get("data");
		String date = (String) params.get("date");
		String hour = (String) params.get("hour");
		String yn = (String) params.get("initYn");
		if(lvl.equals("le1b")) data = "le1b";
		if(lvl.equals("le2") && data.equals("")) data = "le2";  
		String[] searchSeq = env.getProperty("search_info_" + sensor + "_" + data).split(",");
		params.put("searchSeq", searchSeq);
		params.put("date", date.replace("-", ""));
		
		List<Map<String, String>> list = service.comsImageList(params);
		if(yn.equals("Y") && list.size() == 0 && hour != null){	//오늘 영상 없음 ---> 최근 수집 영상 
			Map<String, String> image = service.comsLastImageList(params);
			params.put("date", image.get("scan_dt"));
			params.put("hour", image.get("scan_tm").substring(0, 2));
			list = service.comsImageList(params);
			Map<String, String> map = new HashMap<String, String>();
			map.put("date", image.get("scan_dtf"));
			map.put("hour", image.get("scan_tm").substring(0, 2));
			list.add(map);
		}
		return list;
	}	
	
	/**
	 * 일사량 영상
	 * 
	 * 
	 * */
	@RequestMapping(value="/comsInsImageList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<String>> comsInsImageList(ModelMap model, @RequestParam Map<String, Object> params){
		String date = ((String) params.get("date")).replace("-", "");
		String hour = (String) params.get("hour");
		String yn = (String) params.get("initYn");
		String insPath = env.getProperty("path.coms.ins.image");
		int h = hour.equals("") ? 0 : Integer.parseInt(hour);
		DateTime dt = new DateTime(Integer.parseInt(date.substring(0,4)), Integer.parseInt(date.substring(4,6)), Integer.parseInt(date.substring(6,8)), h, 0, DateTimeZone.UTC);
		String path = MessageFormat.format(insPath, dt.toString("yyyy"), dt.toString("MM"), dt.toString("dd"));
		DateTime end = hour.equals("") ? dt.plusDays(1) : dt.plusHours(1);
		params.put("dt", dt);
		params.put("end", end);
		params.put("path", path);
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		try{
			List<String> list = service.comsInsImageList(params);
			if(yn.equals("Y") &&  list == null && hour != null){
				dt = dt.minusHours(1);
				path = MessageFormat.format(insPath, dt.toString("yyyy"), dt.toString("MM"), dt.toString("dd"));
				end = dt.plusHours(1);
				list = service.comsInsImageList(params);
				while (list == null) {
					dt = dt.minusHours(1);
					path = MessageFormat.format(insPath, dt.toString("yyyy"), dt.toString("MM"), dt.toString("dd"));
					params.put("dt", dt);
					params.put("end", dt.plusHours(1));
					params.put("path", path);
					list = service.comsInsImageList(params);
				}
				List<String> dates = new ArrayList<String>();
				dates.add(dt.toString("yyyy-MM-dd HH"));
				map.put("date", dates);
			}
			map.put(path, list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}	
	
	/**
	 * 영상별 수집 현황
	 * 
	 * 
	 * */
	@RequestMapping(value="/todayMonitorCount", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> todayMonitorCount(ModelMap model, @RequestParam Map<String, Object> params){
		String[] searchSeq = env.getProperty("search_info_total").split(",");
		params.put("searchSeq", searchSeq);
		return service.todayMonitorCount(params);
	}	
	
	/**
	 * 일별 수집 현황
	 * 
	 * */
	@RequestMapping(value="/totalMonitorCount", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> monthMonitorCount(ModelMap model, @RequestParam Map<String, Object> params){
		String yn = (String) params.get("initYn");
		if(yn.equals("N")){
			DateTime date = new DateTime(DateTimeZone.UTC);
			date = date.minusDays(20);
			params.put("eDate", date.toString("yyyy-MM-dd"));
			params.put("sDate", date.minusDays(3).toString("yyyy-MM-dd"));
		}
		String[] searchSeq = env.getProperty("search_info_total").split(",");
		params.put("searchSeq", searchSeq);
		return service.monthMonitorCount(params);
	}	
	
	
	/**
	 * @throws IOException 
	 * 이미지 Load
	 * 
	 * */
	@RequestMapping(value="/imageView", method = RequestMethod.GET)
	public void imageView(ModelMap model, @RequestParam Map<String, Object> param, HttpServletResponse res){
		InputStream in = null;
		res.setContentType(MediaType.IMAGE_PNG_VALUE);
		try {
			in = new FileInputStream((String)param.get("path"));
			FileCopyUtils.copy(in, res.getOutputStream());
			res.flushBuffer();
		} catch (final IOException e) {
			e.printStackTrace();
		}
	}	

	
	/**
	 * 일사량영상 다운로드
	 * 
	 * 
	 * */
	@RequestMapping(value="/lDownload", method = RequestMethod.GET)
	public void localFileDownload(ModelMap model, @RequestParam Map<String, Object> param, HttpServletResponse res){
        OutputStream out = null;
        FileInputStream fis = null;
        try {
        	File file = new File((String)param.get("path"));
        	if(file.exists()){
        		res.setContentType("applicaiton/download;charset=utf-8");
        		res.setContentLength((int)file.length());
        		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
        		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
        		res.setHeader("Content-Transfer-Encoding", "binary");
        		out = res.getOutputStream();
        		fis = new FileInputStream(file);
        		FileCopyUtils.copy(fis, out);
        		out.flush();
        	}
        } catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
        }
	}	
	
	/**
	 * 위성영상 이미지 다운로드
	 * 
	 * 
	 * */
	@RequestMapping(value="/uDownload", method = RequestMethod.GET)
	public void urlFileDownload(ModelMap model, @RequestParam Map<String, Object> param, HttpServletResponse res){
        OutputStream out = null;
        InputStream in = null;
        try {
        	URL url = new URL((String)param.get("path"));
            URLConnection urlConnection = url.openConnection();
            in = urlConnection.getInputStream();
            res.setContentType("applicaiton/download;charset=utf-8");
            res.setHeader("Content-Disposition", "attachment;filename=\""+(String)param.get("imageNm")+"\";");
            res.setHeader("Content-Transfer-Encoding", "binary");
        	res.setContentLength(urlConnection.getContentLength());
        	out = res.getOutputStream();
            FileCopyUtils.copy(in, out);
            out.flush();
        } catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) { try { in.close(); } catch (Exception e2) {}}
        }
	}	
	
	/**
	 * 위성영상 엑셀 다운로드
	 * */
	@RequestMapping(value="/textDownload", method = RequestMethod.GET)
	public void textFileDownload(ModelMap model, @RequestParam Map<String, String> params, HttpServletResponse res){
		String lvl = params.get("lvl");//(String) param.get("sensor");
		String type = params.get("type");
		String outFile = null;
		OutputStream out = null;
	    FileInputStream fis = null;
	    File file =  null;
	    
	    try {
			if (lvl.equals("le1b")) {
				outFile = csvDataRead.L1bRead(params, 1);
			} else {
				if (type.equals("CTTP")) {
					outFile = csvDataRead.L2CttpRead(params, 1);
				} else {
					outFile = csvDataRead.L2Read(params, 1);
				}
			}
			if(outFile != null){
				file = new File(outFile);
				if(file.exists()){
					res.setContentType("application/octet-stream;charset=utf-8");
	        		res.setContentLength((int)file.length());
	        		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
	        		res.setHeader("Content-Disposition", "attachment;filename=\"" + fileName.replace("zzz", type) +"\";");
	        		res.setHeader("Content-Transfer-Encoding", "binary");
	        		out = res.getOutputStream();
	        		fis = new FileInputStream(file);
	        		FileCopyUtils.copy(fis, out);
	        		out.flush();
	        		file.delete();
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
        	 if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
        	
        }

	}	
	
	@Autowired
	private CsvDataReadWrite csvDataRead;	//Excel Convert he5

}//class end