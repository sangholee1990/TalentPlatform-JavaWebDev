package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Plastic extends SWPCFormatData {
	public Plastic() {
		super(4);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int s = Integer.parseInt(data[0], 10);
		double pro_dens = Double.parseDouble(data[1]);
		double bulk_spd = Double.parseDouble(data[2]);
		double ion_temp = Double.parseDouble(data[3]);

		pstmt.setInt(++idx, s);
		pstmt.setDouble(++idx, pro_dens);
		pstmt.setDouble(++idx, bulk_spd);
		pstmt.setDouble(++idx, ion_temp);
		
		return true;
	}
}