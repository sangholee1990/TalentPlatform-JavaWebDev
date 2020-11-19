package com.gaia3d.web.mapper.simple;

import java.util.List;

public interface SelectMapper<T> {
	T SelectOne(Object parameter);
	int Count(Object parameter);
	int SelectUniqueExcelDataCount(Object parameter);
	List<T> SelectMany(Object parameter);
}
