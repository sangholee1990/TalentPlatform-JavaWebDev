package com.gaia3d.web.mapper;

import java.util.List;

import com.gaia3d.web.dto.DbInfoDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface DbinfoMapper extends BasicMapper<DbInfoDTO> {
	
	List<DbInfoDTO> SelectTableSpaceInfo(Object params);
	
}
