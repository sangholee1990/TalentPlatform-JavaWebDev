package egovframework.rte.swfc.mapper.simple;

import java.util.List;

public interface SelectMapper<T> {
	T SelectOne(Object parameter);
	int Count(Object parameter);
	List<T> SelectMany(Object parameter);
}
