package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.google.common.base.Preconditions;

public abstract class SWPCFormatData {
	private final  int timestampDataLength = 6;
	private int dataLength;
	
	public SWPCFormatData(int dataLength) {
		this.dataLength = dataLength;
	}
	
	private String year;
	private String month;
	private String day;
	private String time;
	private int mjd;
	private int secofday;

	private String[] data;

	public String getTm() {
		return this.year + this.month + this.day + this.time + "00";
	}

	public int getMjd() {
		return this.mjd;
	}

	public int getSecofday() {
		return this.secofday;
	}

	public void parseData(String line) {
		String[] values = line.split("\\s+");
		Preconditions.checkArgument(values.length == timestampDataLength + dataLength, "invalid data length! expected %s but %s", dataLength, values.length);

		year = values[0];
		month = values[1];
		day = values[2];
		time = values[3];
		mjd = Integer.parseInt(values[4]);
		secofday = Integer.parseInt(values[4]);
		
		this.data = new String[dataLength];
		System.arraycopy(values, timestampDataLength, this.data, 0, dataLength);
	}
	
	public boolean setParameter(PreparedStatement pstmt) throws SQLException {
		int idx = 0;
		pstmt.setString(++idx, getTm());
		pstmt.setInt(++idx, getMjd());
		pstmt.setInt(++idx, getSecofday());
		return setDataParameter(pstmt, idx, data);
	}
	
	public abstract boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException;
};