package kr.co.indisystem.web.monitor;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class MonitorServiceImpl {

	@Autowired
	private MonitorMapper mapper;
	
	@Value("${path.coms.ins.image}")
	private String insImage;

	/**
	 * 영상별 수집 현황 목록
	 * */
	public List<Map<String, String>> comsImageList(Map<String, Object> params) {
		return mapper.comsImageList(params);  
	}

	/**
	 * 영상별 수집 현황 마지막 영상
	 * */
	public Map<String, String> comsLastImageList(Map<String, Object> params) {
		return mapper.comsLastImageList(params);  
	}
	
	/**
	 * 일사량 영상 목록
	 * */
	public List<String> comsInsImageList(Map<String, Object> params) {
		List<String> result = null;
		DateTime dt = (DateTime) params.get("dt");
		DateTime end = (DateTime) params.get("end");
	
		File dir = new File((String)params.get("path"));	
		
		if(dir.exists()){
			File[] files = dir.listFiles(new FilenameFilter() {
				@Override
				public boolean accept(File dir, String name) {
					return name.endsWith(".png");
				}
			});
			if(files.length > 0){
				Pattern pt = Pattern.compile("\\d{4}\\d{2}\\d{2}\\d{2}\\d{2}");
				for (int i = 0; i < files.length; i++) {
					File file = files[i];
					String fileNm = file.getName();
					Matcher mt = pt.matcher(fileNm);
					if(mt.find()){
						String fd = mt.group(0);
						DateTime fileDt = new DateTime(Integer.parseInt(fd.substring(0,4)), Integer.parseInt(fd.substring(4,6)), Integer.parseInt(fd.substring(6,8)), Integer.parseInt(fd.substring(8,10)), Integer.parseInt(fd.substring(10,12)), DateTimeZone.UTC);
						if((fileDt.isEqual(dt.getMillis()) || fileDt.isAfter(dt.getMillis())) && fileDt.isBefore(end.getMillis())){
							if(result == null) result = new ArrayList<String>();
							result.add(fileNm);
						}
					}
				}				
			}
		}
		return result;
	}
	
	/**
	 * 영상별 수집 현황 목록
	 * */
	public List<Map<String, String>> todayMonitorCount(Map<String, Object> params) {
		return mapper.todayMonitorCount(params);
	}
	
	/**
	 * 일별 수집 현황 목록
	 * */
	public Map<String, Object> monthMonitorCount(Map<String, Object> params) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<String> dateList = null;
		List<Map<String, Object>> dataList = null;
		String yn = (String) params.get("initYn");
		dataList = mapper.totalMonitorCount(params);
		if(yn.equals("Y")) {
			dateList = mapper.dateAllList(params);
			Map<String, List<String>> data = new HashMap<String, List<String>>();
			for(Map<String, Object> map : dataList){
				String seq = String.valueOf(map.get("search_info_seq"));
				if(data.get(seq) == null)
					data.put(seq, new ArrayList<String>());
				int dateIdx = dateList.indexOf(String.valueOf(map.get("scan_date")));
				if(dateIdx > -1)
					data.get(seq).add(dateIdx, String.valueOf(map.get("cnt")));								
			}
			result.put("data", data);
		}else{
			result.put("data", dataList);
		}
		result.put("date", dateList);
		return result;
	}
	
}//class end