package kr.co.indisystem.utils.hdf;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
@PropertySource({
	"classpath:/insolation/AreaInfoResource.properties",
	"classpath:/insolation/AreaLatLon.properties",
	"classpath:/insolation/L1bMetaPath.properties",
	"classpath:/insolation/L2MetaPath.properties",
	"classpath:/insolation/insolation.properties"
})
public class CsvDataReadWrite {
	
	@Autowired
	private Environment env;
	
	public String getPath(Map<String, String> params){
		StringBuffer path = new StringBuffer();
		path.append(env.getProperty("input.dir.home")); 
		path.append(params.get("sensor").equals("1") ? "MI" : "GOCI");
		path.append(File.separator);
		
		if(params.get("lvl").equals("le1b") || params.get("lvl").equals("l1b")){
			path.append("L1B");
		}else{
			path.append(params.get("type"));
		}
		path.append(File.separator);
		path.append("he5");
		path.append(File.separator);
		
		String[] date = params.get("date").split("-");
		
		path.append("Y" + date[0]);
		path.append(File.separator);
		path.append("M" + date[1]);
		path.append(File.separator);
		path.append("D" + date[2]);
		path.append(File.separator);
		path.append(params.get("fileNm"));
		
		return path.toString();
	}
	
	
	public String L1bRead(Map<String, String> params, int areaCheck) throws Exception{	
		String path = getPath(params);
		String type = params.get("type");
		int[] areaX          = new int [] {Integer.parseInt(env.getProperty("areaCnX1")), Integer.parseInt(env.getProperty("areaCnX2"))};
		int[] areaY          = new int [] {Integer.parseInt(env.getProperty("areaCnY1")), Integer.parseInt(env.getProperty("areaCnY2"))};
		int[] areaVX         = new int [] {Integer.parseInt(env.getProperty("areaCnVX1")), Integer.parseInt(env.getProperty("areaCnVX2"))};
		int[] areaVY         = new int [] {Integer.parseInt(env.getProperty("areaCnVY1")), Integer.parseInt(env.getProperty("areaCnVY2"))};
		
		File f = new File(path);
		if (!f.isFile()) {
			System.out.println(path + " : file not found.");
			return null;
		}
		if (params.get("fileNm").indexOf("_cf_") > -1) {
			areaX[0]  = Integer.parseInt(env.getProperty("areaCfX1"));
			areaX[1]  = Integer.parseInt(env.getProperty("areaCfX2"));
			areaY[0]  = Integer.parseInt(env.getProperty("areaCfY1"));
			areaY[1]  = Integer.parseInt(env.getProperty("areaCfY2"));
			areaVX[0] = Integer.parseInt(env.getProperty("areaCfVX1")); 
			areaVX[1] = Integer.parseInt(env.getProperty("areaCfVX2"));
			areaVY[0] = Integer.parseInt(env.getProperty("areaCfVY1"));
			areaVY[1] = Integer.parseInt(env.getProperty("areaCfVY2"));
		}
		Arrays.sort(areaX);
		Arrays.sort(areaY);
		Arrays.sort(areaVX);
		Arrays.sort(areaVY);
		
		int rangX = Math.abs(areaX[0] - areaX[1] ) + 1;
		int rangY = Math.abs(areaY[0] - areaY[1] ) + 1;

		double[][] last = new double[rangX][rangY];
		if(type.equals("vis")){
			rangX = Math.abs(areaVX[0] - areaVX[1] ) + 1;
			rangY = Math.abs(areaVY[0] - areaVY[1] ) + 1;
			last  = new double[rangX][rangY];
		}
		
		int arrNum = 2;
		if(type.equals("ir2")) arrNum = 4;
		if(type.equals("swir")) arrNum = 6;
		if(type.equals("wv")) arrNum = 8;
		if(type.equals("vis")) arrNum = 10;
		
		String metaPath = env.getProperty(type + "_metapath");
		double[][] l1b = Hdf5DataRead.L1bDataRead(path, metaPath, env.getProperty("input.dir.txt"), arrNum);
			
		if (areaCheck == 0) {
			CsvWrite(path.replace(".he5", ".csv"), l1b);
		}else{		
			for (int i = 0; i < rangX; i++)  {
				for (int j = 0; j < rangY; j++)  {
					int ii = i + areaX[0];
					int jj = j + areaY[0];
					if(type.equals("vis")){
						ii = i + areaVX[0];
						jj = j + areaVY[0];
					}
					last[i][j]  = l1b[ii][jj];
				}
				
			}
			CsvWrite(path.replace(".he5", ".csv"), last);
		}
		
		return path.replace(".he5", ".csv");
	}

	public String L2Read(Map<String, String> params, int areaCheck) throws Exception{
		String path = getPath(params);
		String type = params.get("type");
		int[] areaX          = new int [] {Integer.parseInt(env.getProperty("areaCnX1")), Integer.parseInt(env.getProperty("areaCnX2"))};
		int[] areaY          = new int [] {Integer.parseInt(env.getProperty("areaCnY1")), Integer.parseInt(env.getProperty("areaCnY2"))};
		int[] areaVX         = new int [] {Integer.parseInt(env.getProperty("areaCnVX1")), Integer.parseInt(env.getProperty("areaCnVX2"))};
		int[] areaVY         = new int [] {Integer.parseInt(env.getProperty("areaCnVY1")), Integer.parseInt(env.getProperty("areaCnVY2"))};

		File f = new File(path);
		if (! f.isFile()) {
			System.out.println(path + " : file not found.");
			return null;
		}
		if (params.get("fileNm").indexOf("_cf_") > -1) {
			areaX[0]  = Integer.parseInt(env.getProperty("areaCfX1"));
			areaX[1]  = Integer.parseInt(env.getProperty("areaCfX2"));
			areaY[0]  = Integer.parseInt(env.getProperty("areaCfY1"));
			areaY[1]  = Integer.parseInt(env.getProperty("areaCfY2"));
			areaVX[0] = Integer.parseInt(env.getProperty("areaCfVX1")); 
			areaVX[1] = Integer.parseInt(env.getProperty("areaCfVX2"));
			areaVY[0] = Integer.parseInt(env.getProperty("areaCfVY1"));
			areaVY[1] = Integer.parseInt(env.getProperty("areaCfVY2"));
		}
		Arrays.sort(areaX);
		Arrays.sort(areaY);
		Arrays.sort(areaVX);
		Arrays.sort(areaVY);
		
		int rangX = Math.abs(areaX[0] - areaX[1] ) + 1;
		int rangY = Math.abs(areaY[0] - areaY[1] ) + 1;
		double[][] lastL2 = null;
		double[][] l2Data = null;
	
		String metaPath = env.getProperty(type + "_METAPATH");
		l2Data = Hdf5DataRead.L2DataRead(path, metaPath, env.getProperty("input.dir.txt"));
		
		if (areaCheck == 0) {
			CsvWrite(path.replace(".h5", ".csv"), l2Data);
		} else {
			lastL2  = new double[rangX][rangY];
			for (int i = 0; i < rangX; i++)  {
				for (int j = 0; j < rangY; j++)  {
					int ii = i + areaX[0];
					int jj = j + areaY[0];
					
					lastL2[i][j]  = l2Data[ii][jj];
				}
			}
			CsvWrite(path.replace(".h5", ".csv"), lastL2);
		}
		return path.replace(".h5", ".csv");
	}
	
	public String L2CttpRead(Map<String, String> params, int areaCheck) throws Exception {
		String path = getPath(params);
		String type = params.get("type");
		int[] areaX          = new int [] {Integer.parseInt(env.getProperty("areaCnX1")), Integer.parseInt(env.getProperty("areaCnX2"))};
		int[] areaY          = new int [] {Integer.parseInt(env.getProperty("areaCnY1")), Integer.parseInt(env.getProperty("areaCnY2"))};
		int[] areaVX         = new int [] {Integer.parseInt(env.getProperty("areaCnVX1")), Integer.parseInt(env.getProperty("areaCnVX2"))};
		int[] areaVY         = new int [] {Integer.parseInt(env.getProperty("areaCnVY1")), Integer.parseInt(env.getProperty("areaCnVY2"))};

		File f = new File(path);
		if (! f.isFile()) {
			System.out.println(path + " : file not found.");
			return null;
		}
		if (params.get("fileNm").indexOf("_cf_") > -1) {
			areaX[0]  = Integer.parseInt(env.getProperty("areaCfX1"));
			areaX[1]  = Integer.parseInt(env.getProperty("areaCfX2"));
			areaY[0]  = Integer.parseInt(env.getProperty("areaCfY1"));
			areaY[1]  = Integer.parseInt(env.getProperty("areaCfY2"));
			areaVX[0] = Integer.parseInt(env.getProperty("areaCfVX1")); 
			areaVX[1] = Integer.parseInt(env.getProperty("areaCfVX2"));
			areaVY[0] = Integer.parseInt(env.getProperty("areaCfVY1"));
			areaVY[1] = Integer.parseInt(env.getProperty("areaCfVY2"));
		}
		Arrays.sort(areaX);
		Arrays.sort(areaY);
		Arrays.sort(areaVX);
		Arrays.sort(areaVY);
		
		int rangX = Math.abs(areaX[0] - areaX[1] ) + 1;
		int rangY = Math.abs(areaY[0] - areaY[1] ) + 1;
		
		double[][] lastCtp  = new double[rangX][rangY];
		double[][] lastCtt  = new double[rangX][rangY];
		double[][] lastCth   = new double[rangX][rangY];
		

		String metaPath = env.getProperty(params.get("type") + "_METAPATH");
		
		List cttp = Hdf5DataRead.L2CttpRead(path, env.getProperty("input.dir.txt"));
		
		double[][] ctp = (double[][]) cttp.get(0);
		double[][] ctt = (double[][]) cttp.get(1);
		double[][] cth = (double[][]) cttp.get(2);
		
		String zip = path.replace(".h5", ".zip");
		path = path.replace(".h5", ".csv");
		String ctpNm = path.replace("_cttp", "_ctp");
		String cttNm = path.replace("_cttp", "_ctt");
		String cthNm = path.replace("_cttp", "_cth");
		if (areaCheck == 0) {
			CsvWrite(ctpNm, ctp);
			CsvWrite(cttNm, ctt);
			CsvWrite(cthNm, cth);
		} else {
			
			for (int i = 0; i < rangX; i++)  {
				for (int j = 0; j < rangY; j++)  {
					int ii = i + areaX[0];
					int jj = j + areaY[0];
					
					lastCtp[i][j]  = ctp[ii][jj];
					lastCtt[i][j]  = ctt[ii][jj];
					lastCth[i][j]  = cth[ii][jj];
				}
				
			}
			CsvWrite(ctpNm, lastCtp);
			CsvWrite(cttNm, lastCtt);
			CsvWrite(cthNm, lastCth);
		}

		 createZipFile(zip, new String[]{ctpNm, cttNm, cthNm});
		 
		 return zip;
	}
	
	public void createZipFile(String zipPath, String[] files){
		FileInputStream in = null;
		ZipOutputStream out = null;
		File file = null;
		try {
			out = new ZipOutputStream(new FileOutputStream(zipPath));
			for(String path : files){
				file = new File(path);
				if(file.exists()){
					in = new FileInputStream(file);
					out.putNextEntry(new ZipEntry(file.getName()));
					int len;
					byte[] buf = new byte[1024 * 2];
		            while ((len = in.read(buf)) > 0) {
		                out.write(buf, 0, len);
		            }
		            out.closeEntry();
		            in.close();
		            file.delete();
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try{if(in != null) in.close();}catch(Exception e){}
			try{if(out != null) out.close();}catch(Exception e){}	
		}
	}
	
	public void CsvWrite(String outFile, double[][] inData) throws Exception {
        int rows = inData.length;
        int cols = inData[0].length;
        
        BufferedWriter outt = null;
        try{
        	outt = new BufferedWriter(new FileWriter(outFile)); 
        	for (int i=0; i<rows; i++){

        		for (int j=0; j<cols; j++){
					outt.write(String.valueOf(inData[i][j]+","));
	    		}
				outt.newLine();
	    	}
			outt.close();
        }catch (Exception e) {
//        	log.error("HDF5 TO BINARY MAKE ERROR ");
        	throw e;
		}finally{
			try{
				if(outt != null){
					outt.close();
				}
			}catch(IOException ie){}
		}       
	}


	

}//Class end