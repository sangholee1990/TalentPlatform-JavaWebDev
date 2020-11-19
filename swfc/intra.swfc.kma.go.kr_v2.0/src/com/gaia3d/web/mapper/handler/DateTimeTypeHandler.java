package com.gaia3d.web.mapper.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;
import org.joda.time.DateTime;

@MappedTypes(DateTime.class)
public class DateTimeTypeHandler implements TypeHandler<DateTime>
{

	@Override
	public void setParameter(PreparedStatement ps, int i, DateTime parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DateTime getResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DateTime getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DateTime getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}