package xRayReInster;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GoesMegReInster {
	/**
	 * 테이블 명
	 */
	private String tableName = null;
	
	/**
	 * 파일명
	 */
	private String fileName = null;
	
	public GoesMegReInster(String tableName, String fileName){
		this.tableName = tableName;
		this.fileName = fileName;
	}
	
	
	//작업 요땅!!
	public void doJob() throws FileNotFoundException{
		List<GoesMagVo> readData = readText();
		insertDb(readData);
	}
	
	public List<GoesMagVo> readText() throws FileNotFoundException {

		List<GoesMagVo> list = new ArrayList<GoesMagVo>();
		BufferedReader in = null;
		try {
			in = new BufferedReader(new FileReader(fileName));
			String line;
			String tm;
			String mjd;
			String sec;
			while ((line = in.readLine()) != null) {
				if (!line.startsWith(":") && !line.startsWith("#")) {

					String[] values = line.replaceAll("\\s+", "#").split("#");

					tm = values[0] + values[1] + values[2] + values[3] + "00";
					mjd = values[4];
					sec = values[5];

					list.add(new GoesMagVo(tm, mjd, sec, 
							new BigDecimal(values[6]).toPlainString(), //HP
							new BigDecimal(values[7]).toPlainString(), //HE
							new BigDecimal(values[8]).toPlainString(), //HN
							new BigDecimal(values[9]).toPlainString())); //TOTAL_FLD
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (IOException e) {
				}
		}

		return list;
	}
	
	public void insertDb(List<GoesMagVo> readData){
		if(readData == null) return;
		
		
        Connection con = null;
        PreparedStatement pstmt = null;
        String queryUpdate = 
        		"MERGE INTO " + tableName+ " USING DUAL ON (TM = ?) " +
        		"WHEN MATCHED THEN UPDATE SET MJD = ?, SECOFDAY = ?, HP = ?, HE = ?, HN = ?, TOTAL_FLD = ?  " +                         
        		"WHEN NOT MATCHED THEN INSERT (TM, MJD, SECOFDAY, HP, HE, HN, TOTAL_FLD ) VALUES (?, ?, ?, ?, ?, ?, ?) ";
        
        
		try{
			int updateCount = 0;
			Class.forName(Global.Db.DATABASE_DRIVER);
			con = DriverManager.getConnection(Global.Db.DATABASE_URL,Global.Db.DATABASE_USER, Global.Db.DATABASE_PASSWORD);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(queryUpdate);
			GoesMagVo vo = null;
			
			System.out.println(tableName + " 테이블 총 읽은 건수 ==> " + readData.size());
			int len = readData.size();
			for(int i = 0; i < len; i++){
				vo = (GoesMagVo)readData.get(i);
				//System.out.println("insert db==>" + vo.toString());
				pstmt.setObject(1, vo.getTm());
				pstmt.setObject(2, vo.getMjd());
				pstmt.setObject(3, vo.getSecofDay());
				pstmt.setObject(4, vo.getHp());
				pstmt.setObject(5, vo.getHe());
				pstmt.setObject(6, vo.getHn());
				pstmt.setObject(7, vo.getTotalFld());
				pstmt.setObject(8, vo.getTm());
				pstmt.setObject(9, vo.getMjd());
				pstmt.setObject(10, vo.getSecofDay());
				pstmt.setObject(11, vo.getHp());
				pstmt.setObject(12, vo.getHe());
				pstmt.setObject(13, vo.getHn());
				pstmt.setObject(14, vo.getTotalFld());
				pstmt.addBatch();
				
				if(i % 500 == 0){
					updateCount += pstmt.executeBatch().length;
				}
			}
			
			updateCount += pstmt.executeBatch().length;
			
			System.out.println(tableName + " 테이블 최종 등록 건수 ==>" + updateCount);
			
			con.commit();
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			try {con.rollback();} catch (SQLException e1) {	}
			e.printStackTrace();
		}finally {
			try {
				con.setAutoCommit(true);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if(pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
			if(con != null) try { con.close(); } catch (SQLException e) {}
		}
	}
	
	public static void main(String[] args) throws FileNotFoundException {
		
		//GEOS 15
		GoesMegReInster job1 = new GoesMegReInster("SMT_GOES_MAG_S_T", "C:\\dev\\workspace\\kma\\xRayReInster\\SMT_GOES_MAG_S_T.txt");
		job1.doJob();
		
		//GEOS 13
		GoesMegReInster job2 = new GoesMegReInster("SMT_GOES_MAG_P_T", "C:\\dev\\workspace\\kma\\xRayReInster\\SMT_GOES_MAG_P_T.txt");
		job2.doJob();
		
		
	}
}
