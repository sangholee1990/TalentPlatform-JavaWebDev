package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AceMag extends SWPCFormatData {
	public AceMag() {
		super(7);
	}

	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int s = Integer.parseInt(data[0], 10);
		double bx = Double.parseDouble(data[1]);
		double by = Double.parseDouble(data[2]);
		double bz = Double.parseDouble(data[3]);
		double bt = Double.parseDouble(data[4]);
		double lat = Double.parseDouble(data[5]);
		double lon = Double.parseDouble(data[6]);

		pstmt.setInt(++idx, s);
		pstmt.setDouble(++idx, bx);
		pstmt.setDouble(++idx, by);
		pstmt.setDouble(++idx, bz);
		pstmt.setDouble(++idx, bt);
		pstmt.setDouble(++idx, lat);
		pstmt.setDouble(++idx, lon);
		
		return true;
	}
}