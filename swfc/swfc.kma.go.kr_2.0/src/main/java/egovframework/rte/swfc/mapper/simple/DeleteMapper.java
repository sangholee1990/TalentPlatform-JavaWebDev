package egovframework.rte.swfc.mapper.simple;

import egovframework.rte.swfc.dto.MapperParam;


public interface DeleteMapper<T> {

	void Delete(T data);
	void Delete(MapperParam param);
}
