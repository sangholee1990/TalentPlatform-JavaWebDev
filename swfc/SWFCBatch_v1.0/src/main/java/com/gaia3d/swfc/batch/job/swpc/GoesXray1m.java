package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GoesXray1m extends SWPCFormatData {
	public GoesXray1m() {
		super(2);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		double short_flux = Double.parseDouble(data[0]);
		double long_flux = Double.parseDouble(data[1]);

		pstmt.setDouble(++idx, short_flux);
		pstmt.setDouble(++idx, long_flux);

		return true;
	}
}