package com.gaia3d.web.mapper.simple;

public interface InsertMapper<T> {
	void Insert(T data);
	void InsertFile(T data);
}
