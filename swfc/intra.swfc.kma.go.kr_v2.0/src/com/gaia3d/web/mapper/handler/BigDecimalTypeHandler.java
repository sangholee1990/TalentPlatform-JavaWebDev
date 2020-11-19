package com.gaia3d.web.mapper.handler;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BigDecimalTypeHandler implements TypeHandler {

	private static final Logger logger = LoggerFactory.getLogger(BigDecimalTypeHandler.class);
			
	@Override
	public Integer getResult(ResultSet rs, String columnName)
			throws SQLException {
		BigDecimal big = rs.getBigDecimal(columnName);
		
	    return parseBigDecimal(big);
	}



	@Override
	public Integer getResult(ResultSet rs, int columnIndex) throws SQLException {
		BigDecimal big = rs.getBigDecimal(columnIndex);
		return parseBigDecimal(big);
	}

	@Override
	public Integer getResult(CallableStatement cs, int columnIndex)
			throws SQLException {
		BigDecimal big =  cs.getBigDecimal(columnIndex);

		return parseBigDecimal(big);
	}


	@Override
	public void setParameter(PreparedStatement ps, int i, Object val,
			JdbcType jdbcType) throws SQLException {
		
		ps.setInt(i, (Integer) val);
		
	}


	private Integer parseBigDecimal(BigDecimal big) {
		
		//logger.debug("BigDecimalTypeHandler ---> " + big);
		String number= big.toString();
        return Integer.parseInt(number);
	}






}
