/**
 * 
 */
package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;



/**
 * @author Administrator
 *
 */
public interface GnssMapper {
	
	/**
	 * gnss 지점 정보 목록을 가져온다.
	 * @param params
	 * @return
	 */
	List<Map<String, String>> listGnssStation(Object params);
	List<Map<String, String>> listGnssStationMappingInfo(Object params);
	/**
	 * 하나의 gnss 지점 정보를 가져온다.
	 * @param params
	 * @return
	 */
	Map<String, String> selectGnssStation(Object params);
	/**
	 * gnss 지점정보의 목록 갯수를 가져온다.
	 * @param params
	 * @return
	 */
	int countGnssStation(Object params);
	int insertGnssStationMappingInfo(Object params);
	/**
	 * gnss 지점 정보를 삭제한다.
	 * @param params
	 * @return
	 */
	int deleteGnssStation(Object params);
	int deleteGnssStationMappingInfo(Object params);
	/**
	 * gnss 지점 정보를 수정한다.
	 * @param params
	 * @return
	 */
	int updateGnssStation(Object params);
	/**
	 * gnss 지점 정보를 등록한다.
	 * @param params
	 * @return
	 */
	int insertGnssStation(Object params);
	
	int selectMaxSeqNo();
	
}
