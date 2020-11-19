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

/**
 * 양성자 플럭스 (GOES-13, GOES-15) 원자료를 db에 재등록 하는 프로그램
 * 
 * @author mjhwang
 *
 */
public class ParticleReInster {
	
	
	public static void main(String[] args) throws FileNotFoundException {
		//양성자 플럭스 GEOS 15 :: SMT_GOES_PARTICLE_S_T
		ParticleReInster job1 = new ParticleReInster("SMT_GOES_PARTICLE_S_T", "C:\\dev\\workspace\\kma\\xRayReInster\\SMT_GOES_PARTICLE_S_T.txt");
		job1.doJob();
		
		//양성자 플럭스 GEOS 13 :: SMT_GOES_PARTICLE_P_T
		ParticleReInster job2 = new ParticleReInster("SMT_GOES_PARTICLE_P_T", "C:\\dev\\workspace\\kma\\xRayReInster\\SMT_GOES_PARTICLE_P_T.txt");
		job2.doJob();
		
	}

	/**
	 * 테이블 명
	 */
	private String tableName = null;
	
	/**
	 * 파일명
	 */
	private String fileName = null;
	
	public ParticleReInster(String tableName, String fileName){
		this.tableName = tableName;
		this.fileName = fileName;
	}
	
	
	//작업 요땅!!
	public void doJob() throws FileNotFoundException{
		List<ParticleVo> readData = readText();
		insertDb(readData);
	}

	public List<ParticleVo> readText() throws FileNotFoundException {

		List<ParticleVo> list = new ArrayList<ParticleVo>();
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

					list.add(new ParticleVo(tm, mjd, sec, 
							new BigDecimal(values[6]).toPlainString(), //p1
							new BigDecimal(values[7]).toPlainString(), //p5
							new BigDecimal(values[8]).toPlainString(), //p10
							new BigDecimal(values[9]).toPlainString(), //p30
							new BigDecimal(values[10]).toPlainString(), //p50
							new BigDecimal(values[11]).toPlainString(), //p100
							new BigDecimal(values[12]).toPlainString(), //e8
							new BigDecimal(values[13]).toPlainString(), //e20
							new BigDecimal(values[14]).toPlainString())); //e40
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
	
	public void insertDb(List<ParticleVo> readData){
		if(readData == null) return;
		
		
        Connection con = null;
        PreparedStatement pstmt = null;
        String queryUpdate = 
        		"MERGE INTO "+tableName+" USING DUAL ON (TM = ?) " +
        		"WHEN MATCHED THEN UPDATE SET MJD = ?, SECOFDAY = ?, P1=?, P5=?, P10=?, P30=?, P50=?, P100=?, E8=?, E20=?, E40=?  " +                         
        		"WHEN NOT MATCHED THEN INSERT (TM, MJD, SECOFDAY, P1, P5, P10, P30, P50, P100, E8, E20, E40 ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
        
		try{
			
			int updateCount = 0;
			Class.forName(Global.Db.DATABASE_DRIVER);
			con = DriverManager.getConnection(Global.Db.DATABASE_URL,Global.Db.DATABASE_USER, Global.Db.DATABASE_PASSWORD);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(queryUpdate);
			
			int len = readData.size();
			ParticleVo vo = null;
			System.out.println("촏 등록건수 ==> " + readData.size());
			for(int i = 0; i < len; i++){
				vo = (ParticleVo)readData.get(i);
				//System.out.println("insert db==>" + vo.toString());
				pstmt.setObject(1, vo.getTm());
				pstmt.setObject(2, vo.getMjd());
				pstmt.setObject(3, vo.getSecofday());
				pstmt.setObject(4, vo.getP1());
				pstmt.setObject(5, vo.getP5());
				pstmt.setObject(6, vo.getP10());
				pstmt.setObject(7, vo.getP30());
				pstmt.setObject(8, vo.getP50());
				pstmt.setObject(9, vo.getP100());
				pstmt.setObject(10, vo.getE8());
				pstmt.setObject(11, vo.getE20());
				pstmt.setObject(12, vo.getE40());
				pstmt.setObject(13, vo.getTm());
				pstmt.setObject(14, vo.getMjd());
				pstmt.setObject(15, vo.getSecofday());
				pstmt.setObject(16, vo.getP1());
				pstmt.setObject(17, vo.getP5());
				pstmt.setObject(18, vo.getP10());
				pstmt.setObject(19, vo.getP30());
				pstmt.setObject(20, vo.getP50());
				pstmt.setObject(21, vo.getP100());
				pstmt.setObject(22, vo.getE8());
				pstmt.setObject(23, vo.getE20());
				pstmt.setObject(24, vo.getE40());
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

}
