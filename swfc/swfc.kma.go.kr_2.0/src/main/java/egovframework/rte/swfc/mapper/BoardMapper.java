package egovframework.rte.swfc.mapper;

import java.util.List;

import egovframework.rte.swfc.dto.BoardsDTO;
import egovframework.rte.swfc.dto.BoardsFileDTO;
import egovframework.rte.swfc.dto.CodeDTO;
import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface BoardMapper extends BasicMapper<BoardsDTO> {
	
	void updateHit(Object param);
	BoardsFileDTO SelectOneFile(Object parameter);
	List<BoardsFileDTO> SelectManyFiles(Object parameter);
	
	List<CodeDTO> selectBoardSectionCode(Object param);
	
}
