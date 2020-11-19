package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GoesXray5m extends SWPCFormatData {
	public GoesXray5m() {
		super(3);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		double short_flux = Double.parseDouble(data[0]);
		double long_flux = Double.parseDouble(data[1]);
		double ratio = Double.parseDouble(data[2]);
		
		pstmt.setDouble(++idx, short_flux);
		pstmt.setDouble(++idx, long_flux);
		pstmt.setDouble(++idx, ratio);

		return true;
	}
}