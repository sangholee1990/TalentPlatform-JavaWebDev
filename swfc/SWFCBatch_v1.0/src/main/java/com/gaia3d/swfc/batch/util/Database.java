package com.gaia3d.swfc.batch.util;

import java.io.Closeable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class Database implements Closeable{
	static final Logger logger = LogManager.getLogger(Database.class.getName());
	
	static {
		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		} catch (SQLException e) {
			logger.error("Register Database Driver", e);
			e.printStackTrace();
		}
	}
	
	Connection connection = null;
	PreparedStatement image_meta_query = null;
	PreparedStatement image_meta_insert = null;
	
	public void connect(String url, String username, String password) throws SQLException {
		this.connection = DriverManager.getConnection(url, username, password);
		this.image_meta_query = this.connection.prepareStatement("SELECT COUNT(*) FROM TB_IMAGE_META WHERE CODE=? AND CREATEDATE=? AND FILEPATH=?");
		this.image_meta_insert = this.connection.prepareStatement("INSERT INTO TB_IMAGE_META (CODE, CREATEDATE, FILEPATH) values (?,?,?)");
		
		if(logger.isDebugEnabled())
			logger.debug("Database open.");
	}
	
	public PreparedStatement preparedStatement(String sql) throws SQLException {
		return this.connection.prepareStatement(sql);
	}
	
	public boolean isExistImageMeta(String code, Timestamp timestamp, String filePath) throws SQLException {
		image_meta_query.clearParameters();
		image_meta_query.setString(1, code);
		image_meta_query.setTimestamp(2, timestamp);
		image_meta_query.setString(3, filePath);
		ResultSet rs = image_meta_query.executeQuery();
		boolean result = rs.next() && rs.getInt(1) == 0;
		rs.close();
		return !result;
	}
	
	public void insertImageMeta(String code, Timestamp timestamp, String filePath) throws SQLException {
		image_meta_insert.clearParameters();
		image_meta_insert.setString(1, code);
		image_meta_insert.setTimestamp(2, timestamp);
		image_meta_insert.setString(3, filePath);
		image_meta_insert.execute();
	}
	
	public void close() {
		if(logger.isDebugEnabled())
			logger.debug("Database close.");

		if(connection != null) {
			try {
				connection.close();
			} catch (Exception e) {
				logger.error(e);
			}
			connection = null;
		}
		
		if(image_meta_insert != null) {
			try {
				image_meta_insert.close();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
			}
			image_meta_insert = null;
		}

		if(image_meta_query != null) {
			try {
				image_meta_query.close();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
			}
			image_meta_query = null;
		}
	}
}
