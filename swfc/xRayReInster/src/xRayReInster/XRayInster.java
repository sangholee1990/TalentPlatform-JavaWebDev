/**
 * 
 */
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
 * @author mjhwang
 *
 */
public class XRayInster {
	
	final static String readFile = "C:\\dev\\workspace\\kma\\xRayReInster\\20160317_Gp_xr_1m.txt";
	
	public static List<XRayVo> readText() throws FileNotFoundException{
		
		
		List<XRayVo> list = new ArrayList<XRayVo>();
		BufferedReader in = null;
		try {
			in = new BufferedReader(new FileReader(readFile));
			String line;
			String tm;
			String mjd;
			String sec;
			String shortVal;
			String longVal;
			while ((line = in.readLine()) != null) {
				if(!line.startsWith(":") && !line.startsWith("#")){
					
					String[] values = line.replaceAll("\\s+", "#").split("#");
					
					tm = values[0] + values[1] + values[2] + values[3] + "00";
					mjd = values[4];
					sec = values[5];
					shortVal = values[6];
					longVal = values[7];
					
					list.add(new XRayVo(tm, mjd, sec, new BigDecimal(shortVal).toPlainString(), new BigDecimal(longVal).toPlainString()));
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
	    }finally {
			if(in != null)try { in.close(); } catch (IOException e) {}
		}
		
		return list;
	}
	
	public static void insertDb(List<XRayVo> readData){
		if(readData == null) return;
		
		
        Connection con = null;
        PreparedStatement pstmt = null;
        String queryUpdate = 
        		"MERGE INTO SMT_GOES_XRAY_1M_T USING DUAL ON (TM = ?) " +
        		"WHEN MATCHED THEN UPDATE SET MJD = ?, SECOFDAY = ?, SHORT_FLUX = ?, LONG_FLUX = ?  " +                         
        		"WHEN NOT MATCHED THEN INSERT (TM, MJD, SECOFDAY, SHORT_FLUX, LONG_FLUX ) VALUES (?, ?, ?, ?, ?) ";
        
        
		try{
			int[] updateCount;
			Class.forName(Global.Db.DATABASE_DRIVER);
			con = DriverManager.getConnection(Global.Db.DATABASE_URL,Global.Db.DATABASE_USER, Global.Db.DATABASE_PASSWORD);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(queryUpdate);
			XRayVo vo = null;
			
			System.out.println("촏 등록건수 ==> " + readData.size());
			int len = readData.size();
			for(int i = 0; i < len; i++){
				vo = (XRayVo)readData.get(i);
				System.out.println("insert db==>" + vo.toString());
				pstmt.setObject(1, vo.getTm());
				pstmt.setObject(2, vo.getMjd());
				pstmt.setObject(3, vo.getSecofday());
				pstmt.setObject(4, vo.getShortFlux());
				pstmt.setObject(5, vo.getLongFlux());
				pstmt.setObject(6, vo.getTm());
				pstmt.setObject(7, vo.getMjd());
				pstmt.setObject(8, vo.getSecofday());
				pstmt.setObject(9, vo.getShortFlux());
				pstmt.setObject(10, vo.getLongFlux());
				pstmt.addBatch();
			}
			
			updateCount = pstmt.executeBatch();
			
			System.out.println("최종등록건수 ==>" + updateCount.length);
			
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
		List<XRayVo> readData = readText();
		insertDb(readData);
		
		
	}
}
