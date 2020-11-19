package com.gaia3d.web.mapper.simple;

import com.gaia3d.web.dto.MapperParam;

public interface DeleteMapper<T> {

	void Delete(T data);
	void Delete(MapperParam param);
	void DeleteFile(MapperParam param);
}
