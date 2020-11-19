package com.gaia3d.web.mapper;

import java.util.List;

import com.gaia3d.web.dto.BoardsDTO;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface BoardMapper extends BasicMapper<BoardsDTO> {
	
	void IncreaseHit(Object param);
	
	List<CodeDTO> selectBoardSectionCode(Object param);
}
