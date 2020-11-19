package com.gaia3d.web.mapper.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.joda.time.DateTimeZone;
import org.joda.time.LocalDateTime;

public class LocalDateTimeTypeHandler implements TypeHandler<LocalDateTime>{

	@Override
	public void setParameter(PreparedStatement ps, int i, LocalDateTime parameter, JdbcType jdbcType) throws SQLException {
		ps.setTimestamp(i, new java.sql.Timestamp(parameter.toDateTime(DateTimeZone.UTC).toDate().getTime()));		
	}

	@Override
	public LocalDateTime getResult(ResultSet rs, String columnName) throws SQLException {
		return new LocalDateTime(rs.getTimestamp(columnName).getTime(), DateTimeZone.UTC);		
	}

	@Override
	public LocalDateTime getResult(ResultSet rs, int columnIndex) throws SQLException {
		return new LocalDateTime(rs.getTimestamp(columnIndex).getTime(), DateTimeZone.UTC);
	}

	@Override
	public LocalDateTime getResult(CallableStatement cs, int columnIndex) throws SQLException {
		return new LocalDateTime(cs.getTimestamp(columnIndex).getTime(), DateTimeZone.UTC);
	}
}
