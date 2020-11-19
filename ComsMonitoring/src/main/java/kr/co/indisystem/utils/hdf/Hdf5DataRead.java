package kr.co.indisystem.utils.hdf;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JTable;

import ncsa.hdf.object.Attribute;
import ncsa.hdf.object.HObject;
import ncsa.hdf.object.h5.H5File;


public class Hdf5DataRead {
	
	public static double[][] L2DataRead(String inFile, String metaPath, String txtPath) throws Exception {
		
		if (metaPath == null) {
			System.out.println("massage : metapath = null => Checking product name");
			return null;
		}
		
		H5File file = new H5File(inFile, H5File.READ);
		
		HObject obj = file.get(metaPath);
		HDF5Converter convert = new HDF5Converter(obj);
		JTable l2 = convert.getData();

		List meta = obj.getMetadata();
		
		Attribute attrScal = (Attribute) meta.get(4);
		Attribute attrOffs = (Attribute) meta.get(3);
		double intScal = Double.parseDouble(attrScal.toString("  "));
		double intOffs = Double.parseDouble(attrOffs.toString("  "));

		int rows = l2.getRowCount();		// = 1544
		int cols = l2.getColumnCount();	// = 1934
		double l2Data[][] = new double[cols][rows];
		
		for (int i = 0; i < rows; i++) {
			for (int j = 0; j < cols; j++) {
				l2Data[j][i] = (double) Integer.parseInt(String.valueOf(l2.getValueAt(i,j))) * intScal + intOffs;
			}
		}
		return l2Data;
	}
	
	public static double[][] L1bDataRead(String inFile, String metaPath, String txtPath, int arrNum) throws Exception {

		if (metaPath == null) {
			System.out.println("massage : metapath = null => Checking product name");
			return null;
		}
		
		H5File file = new H5File(inFile, H5File.READ);

		HObject obj = file.get(metaPath);
		HDF5Converter convert = new HDF5Converter(obj);
		JTable table = convert.getData();

		int rows = table.getRowCount();		// = 1544
		int cols = table.getColumnCount();	// = 1934

		double data[][] = new double[cols][rows];
		
		double[][] conversion = ConversionDataRead(null, txtPath); 
		
		for (int i = 0; i < rows; i++) {
			for (int j = 0; j < cols; j++) {
				data[j][i] =  conversion[arrNum][Integer.parseInt(String.valueOf(table.getValueAt(i,j)))];
			}
		}
		
		return data;
	}
	
	public static List L2CttpRead(String inFile, String txtPath) throws Exception {
		
		String ctpMetaPath = "/Product/Cloud_Top_Height";
		String cttMetaPath = "/Product/Cloud_Top_Pressure";
		String cthMetaPath = "/Product/Cloud_Top_Temperature";
		
		H5File file = new H5File(inFile, H5File.READ);
		
		// ctp data
		HObject ctpObj = file.get(ctpMetaPath);
		HDF5Converter ctpConvert = new HDF5Converter(ctpObj);
		JTable ctp = ctpConvert.getData();
		
		// ctt data
		HObject cttObj = file.get(cttMetaPath);
		HDF5Converter cttConvert = new HDF5Converter(cttObj);
		JTable ctt = cttConvert.getData();
		
		// cth data
		HObject cthObj = file.get(cthMetaPath);
		HDF5Converter cthConvert = new HDF5Converter(cthObj);
		JTable cth = cthConvert.getData();
		
		int rows = ctp.getRowCount();		// = 1544
		int cols = ctp.getColumnCount();	// = 1934
		
		double ctpData[][] = new double[cols][rows];
		double cttData[][] = new double[cols][rows];
		double cthData[][] = new double[cols][rows];
		
		for (int i = 0; i < rows; i++) {
			for (int j = 0; j < cols; j++) {
				ctpData[j][i] =  Integer.parseInt(String.valueOf(ctp.getValueAt(i,j)));
				cttData[j][i] =  Integer.parseInt(String.valueOf(ctt.getValueAt(i,j)));
				cthData[j][i] = Integer.parseInt(String.valueOf(cth.getValueAt(i,j)));
			}
		}
			
		List<Object> cttpData = new ArrayList<Object>();
		cttpData.add(ctpData);
		cttpData.add(cttData);
		cttpData.add(cthData);

		return cttpData;
	}
	
	
	public static double[][] getTableData(H5File file, String path, int conversionDepth, String txtPath) throws Exception {
		
//		System.out.println(inFile);
//		H5File file = new H5File(inFile, H5File.READ);
		
		// ir1 data
		HObject obj = file.get(path);
		HDF5Converter ir1Convert = new HDF5Converter(obj);
		JTable table = ir1Convert.getData();
		
		int rows = table.getRowCount();		// = 1544
		int cols = table.getColumnCount();	// = 1934
		
		double dataTable[][] = new double[cols][rows];
		
		double[][] conversion = ConversionDataRead(null, txtPath); 
		
		for (int i = 0; i < rows; i++) {
			for (int j = 0; j < cols; j++) {
				dataTable[j][i] =  conversion[conversionDepth][Integer.parseInt(String.valueOf(table.getValueAt(i,j)))];
			}
		}
		
		
		
		return dataTable;
		
	}
	
	public static double[][] ConversionDataRead(String arg[], String txtPath) throws Exception {
		
		String ConverPath = txtPath + "COMS_MI_Conversion_Table.txt";
		
		BufferedReader in = new BufferedReader(new FileReader(ConverPath));
		
		String dataLine = null;
		
		double[][] conversion = new double[11][1024];
		
		int i = 0;
		int j = 0;
		
		while ((dataLine = in.readLine()) != null) {
			String[] dl = dataLine.split(",");
			for (j = 0; j < dl.length; j++) {
				conversion[j][i] = Double.valueOf(dl[j]);
			}
			i++;
		}
		
		in.close();
		
		
		return conversion;
		
	}


}