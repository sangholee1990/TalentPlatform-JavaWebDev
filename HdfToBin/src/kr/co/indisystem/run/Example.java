package kr.co.indisystem.run;

import java.io.File;

import kr.co.indisystem.util.HDF5Converter;
import ncsa.hdf.object.HObject;
import ncsa.hdf.object.h5.H5File;

public class Example {
	
	public static void main(String[] args) throws Exception{
		String inFile = "c:\\hdf\\coms_mi_le1b_zzz_cn_201504211830.he5";
		String outFile = "c:\\hdf\\coms_mi_le1b_zzz_cn_201504211830.bin";
		String metaPath = "/HDFEOS/GRIDS/IR Image Pixel Value/Data Fields/IR1 band Image Pixel Values";
		/*
		String inFile = "c:\\hdf\\coms_mi_le2_cttp_cn_201301201215.h5";
		String outFile = "c:\\hdf\\coms_mi_le2_cttp_cn_201301201215.bin";
		String metaPath = "/Product/Cloud_Top_Height";
		 */
		H5File file = new H5File(inFile, H5File.READ);
		HObject obj = file.get(metaPath);
		HDF5Converter convert = new HDF5Converter(obj);
		convert.saveToBinary(new File(outFile));
		
	}
}
