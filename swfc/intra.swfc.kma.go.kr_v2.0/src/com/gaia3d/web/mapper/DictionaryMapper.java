package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.dto.DictionaryDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface DictionaryMapper extends BasicMapper<DictionaryDTO> {
	
	List<DictionaryDTO> selectDictionaryExcelList(Object params);
	
	int SelectUniqueExcelDataCount(Object params);
	
	void insertDictionary(Object params);
	
	void updateDictionary(Object params);
	
	void deleteDictionary(Object params);
}
