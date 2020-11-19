package egovframework.rte.swfc.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import egovframework.rte.swfc.dto.BoardsDTO;
import egovframework.rte.swfc.dto.BoardsFileDTO;
import egovframework.rte.swfc.dto.CodeDTO;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.mapper.BoardMapper;

@Service("boardService")
public class BoardService extends BaseService {
	
	public List<BoardsDTO> listBoard(Map<String, Object> parameter) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		return mapper.SelectMany(parameter);
	}
	
	public BoardsDTO viewBoard(MapperParam param) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		mapper.updateHit(param);
		return mapper.SelectOne(param);
	}
	
	public List<BoardsFileDTO> listBoardFile(Map<String, Object> parameter) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		return mapper.SelectManyFiles(parameter);
	}
	
	public BoardsFileDTO viewBoardFile(MapperParam param) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		return mapper.SelectOneFile(param);
	}
	
	public int selectCountBoard(Map<String, Object> parameter) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		return mapper.Count(parameter);
	}
	
	public List<CodeDTO> selectBoardSectionCode(Map<String, Object> parameter) {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		return mapper.selectBoardSectionCode(parameter);
	}
}
