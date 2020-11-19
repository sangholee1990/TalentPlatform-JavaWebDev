package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Mag extends SWPCFormatData {
	public Mag() {
		super(7);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int s = Integer.parseInt(data[0], 10);
		double br = Double.parseDouble(data[1]);
		double bt_l = Double.parseDouble(data[2]);
		double bn = Double.parseDouble(data[3]);
		double bt_s = Double.parseDouble(data[4]);
		double lat = Double.parseDouble(data[5]);
		double lon = Double.parseDouble(data[6]);

		pstmt.setInt(++idx, s);
		pstmt.setDouble(++idx, br);
		pstmt.setDouble(++idx, bt_l);
		pstmt.setDouble(++idx, bn);
		pstmt.setDouble(++idx, bt_s);
		pstmt.setDouble(++idx, lat);
		pstmt.setDouble(++idx, lon);
		
		return true;
	}
}