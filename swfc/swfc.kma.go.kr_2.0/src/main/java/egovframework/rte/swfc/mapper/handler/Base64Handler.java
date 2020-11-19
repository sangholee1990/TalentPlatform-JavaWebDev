package egovframework.rte.swfc.mapper.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;


@MappedJdbcTypes(JdbcType.VARCHAR)
public class Base64Handler extends BaseTypeHandler<String>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
	}

	@Override
	public String getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String result = rs.getString(columnName);
		if(org.apache.commons.lang.StringUtils.isEmpty(result))
			return "";
		
		return new String(org.springframework.security.crypto.codec.Base64.encode(result.getBytes()));
	}

	@Override
	public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String result = rs.getString(columnIndex);
		if(StringUtils.isEmpty(result))
			return "";
		
		return new String(org.springframework.security.crypto.codec.Base64.encode(result.getBytes()));
	}

	@Override
	public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}