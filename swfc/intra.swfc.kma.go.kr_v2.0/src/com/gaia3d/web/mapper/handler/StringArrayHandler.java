package com.gaia3d.web.mapper.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;
import org.springframework.util.StringUtils;

import com.google.common.base.Joiner;


@MappedJdbcTypes(JdbcType.VARCHAR)
@MappedTypes(String[].class)
public class StringArrayHandler extends BaseTypeHandler<String[]>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		ps.setString(i, Joiner.on('\n').join(parameter));
	}

	@Override
	public String[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String result = rs.getString(columnName);
		if(StringUtils.isEmpty(result))
			return new String[0];
		
		return result.split("\\r?\\n");
	}

	@Override
	public String[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String result = rs.getString(columnIndex);
		if(StringUtils.isEmpty(result))
			return new String[0];
		
		return result.split("\\r?\\n");
	}

	@Override
	public String[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
