package egovframework.rte.swfc.mapper.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;


@MappedJdbcTypes(JdbcType.VARCHAR)
@MappedTypes(String[].class)
public class StringArrayHandler extends BaseTypeHandler<String[]>{

	public void setNonNullParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		ps.setString(i, org.apache.commons.lang.StringUtils.join(parameter, '\n'));
	}

	public String[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String result = rs.getString(columnName);
		if(StringUtils.isEmpty(result))
			return new String[0];
		
		return result.split("\\r?\\n");
	}

	public String[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String result = rs.getString(columnIndex);
		if(StringUtils.isEmpty(result))
			return new String[0];
		
		return result.split("\\r?\\n");
	}

	public String[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return null;
	}

}
