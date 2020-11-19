package com.gaia3d.swfc.batch.util;



public class CXFormJNI {
	public enum Sys
	{
		GEI,
		J2000,
		GEO,
		MAG,
		GSE,
		GSM,
		SM,
		GSEQ,
		HEE,
		HAE,
		HEEQ
	}
	
	static native double[] cxform(int year, int month, int day, int hour, int minute, int second, double in[], String inSys, String outSys);
	
	static {
		System.loadLibrary("cxform_jni");
	}
	
	public static double[] cxform(int year, int month, int day, int hour, int minute, int second, double in[], Sys inSys, Sys outSys) {
		return CXFormJNI.cxform(year, month, day, hour, minute, second, in, inSys.toString(), outSys.toString());
	}
}
