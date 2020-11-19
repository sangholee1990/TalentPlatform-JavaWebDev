package kr.co.indisystem.web.monitor;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface MonitorMapper {
//위성영상
	List<Map<String, String>> comsImageList(Map<String, Object> params);
	Map<String, String> comsLastImageList(Map<String, Object> params);

//영상별 수집현황
	List<Map<String, String>> todayMonitorCount(Map<String, Object> params);

//일별 수집 현황
	List<Map<String, Object>> totalMonitorCount(Map<String, Object> params);
	List<String> dateAllList(Map<String, Object> params);
}//class end