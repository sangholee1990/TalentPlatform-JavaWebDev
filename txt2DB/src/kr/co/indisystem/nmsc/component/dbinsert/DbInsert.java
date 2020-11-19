package kr.co.indisystem.nmsc.component.dbinsert;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.indisystem.nmsc.component.dbinsert.util.PropertiesUtil;

import org.apache.log4j.Logger;

public class DbInsert {
	
	private static Logger logger = Logger.getLogger(DbInsert.class);
	
	private String driver = PropertiesUtil.getString("db.driver");
	private String url = PropertiesUtil.getString("db.url"); 
	private String id = PropertiesUtil.getString("db.id"); 
	private String password = PropertiesUtil.getString("db.password"); 
	private String separator = PropertiesUtil.getString("file.separator"); 
	
	private Connection connection = null;
	
	public void databaseConnection(){
		
		logger.info("database connection..");
		
		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(url, id, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void closeConnection(){
		logger.info("database close..");
		if(connection != null){
			try {
				connection.close();
				connection = null;
			} catch (SQLException e) {}
		}
	}
	
	public void insertBatch(List<String> datas){
		databaseConnection();
		
		if(connection == null){
			logger.error("database not connection..");
			return;
		}
		
		PreparedStatement ps = null;
		try {
			connection.setAutoCommit(false);
			int count = 0;
			String[] values;
			String[] valuesInfos = PropertiesUtil.getString("sql.insert.value.count.info").split(",");
			ps = connection.prepareStatement(PropertiesUtil.getString("sql.insert.update"));
			
			for (String data: datas) {
				values = data.split(separator);
				logger.debug("insert=> " + data);
				for(int index = 0; index < valuesInfos.length; index++){
					ps.setObject(index + 1, values[Integer.parseInt(valuesInfos[index])]); //파라메터 추가
				}
				
				ps.addBatch(); //배치 등록
				ps.clearParameters();
				
				if(count % 500 == 0){
					ps.executeBatch(); //배치 실행
					ps.clearBatch();
				}
				count++;
			}
			//ps.execute();
			ps.executeBatch(); //나머지 배치 실행
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			//logger.error("insert sql error ", e);
			try { connection.rollback();} catch (SQLException e1) {}
		}finally{
			if(ps != null) try { ps.close(); } catch (SQLException e) {}
			if(connection != null) try { connection.setAutoCommit(true); } catch (SQLException e) {}
			closeConnection();
		}
	}
	
	public void insert(List<String> datas){
		databaseConnection();
		
		if(connection == null){
			logger.error("database not connection..");
			return;
		}
		
		PreparedStatement ps = null;
		try {
			connection.setAutoCommit(false);
			int count = 0;
			String[] values;
			String[] valuesInfos = PropertiesUtil.getString("sql.insert.value.count.info").split(",");
			
			for (String data: datas) {
				values = data.split(separator);
				ps = connection.prepareStatement(PropertiesUtil.getString("sql.insert.update"));
				logger.debug("===========================================");
				for(int index = 0; index < valuesInfos.length; index++){
					logger.debug(index + 1 + "::" + values[Integer.parseInt(valuesInfos[index])]);
					ps.setObject(index + 1, values[Integer.parseInt(valuesInfos[index])]); //파라메터 추가
				}
				ps.execute();
				connection.commit();
				ps.clearParameters();
				ps.clearBatch();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			//logger.error("insert sql error ", e);
			try { connection.rollback();} catch (SQLException e1) {}
		}finally{
			if(ps != null) try { ps.close(); } catch (SQLException e) {}
			if(connection != null) try { connection.setAutoCommit(true); } catch (SQLException e) {}
			closeConnection();
		}
	}
	
	/**
	 * 파일을 라인단위로 읽어 들인다.
	 * @param filePath
	 * @return
	 */
	public List<String> readFile(String filePath){
		List<String> lines = new ArrayList<String>();
		BufferedReader br = null;   
		InputStreamReader isr = null;  
		FileInputStream fis = null;  
		File file = new File(filePath);
		
		try {
			fis = new FileInputStream(file);
			isr = new InputStreamReader(fis, "UTF-8");
			br = new BufferedReader(isr);
			String line;
			String[] lineData;
			while( (line = br.readLine()) != null) {
				if(!"".equals(line))lines.add(line); //공백이 아닌건 모두 추가한다.
			}
		} catch (FileNotFoundException  e) {
			logger.error("read file not found exception ", e);
		} catch (UnsupportedEncodingException  e) {
			logger.error("read file unsupported encoding exception", e);
		} catch (IOException  e) {
			logger.error("read file io exception", e);
		}finally{
			if(fis != null)try { fis.close(); } catch (IOException e) {}
			if(isr != null)try { isr.close(); } catch (IOException e) {}
			if(br != null)try { br.close(); } catch (IOException e) {}
		}
		
		return lines;
	}

	public static void main(String[] args) {
		
		logger.info("insert job start..");
		
		//args = new String[1];
		//args[0] = "C:\\Users\\indisystem10\\Desktop\\noaa19_201610271800.asc.stat";
		if(args == null || args.length == 0){
			logger.info("in file not found");
		}
		logger.info("read file " + args[0]);
		
		DbInsert inserter = new DbInsert();
		List<String> lines = inserter.readFile(args[0]);
		logger.info("insert line size :" + lines.size());
		if(lines != null && lines.size() > 0){
			inserter.insertBatch(lines);
		}else{
			logger.info("text file empty");
		}
		logger.info("insert job end..");
	}
}
