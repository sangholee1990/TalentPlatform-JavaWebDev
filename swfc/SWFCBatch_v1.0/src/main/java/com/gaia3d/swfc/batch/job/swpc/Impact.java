package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Impact extends SWPCFormatData {
	public Impact() {
		super(7);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int elec_s = Integer.parseInt(data[0], 10);
		double elec_36 = Double.parseDouble(data[1]);
		double elec_125 = Double.parseDouble(data[2]);
		int proton_s = Integer.parseInt(data[3], 10);
		double proton_75 = Double.parseDouble(data[4]);
		double proton_137 = Double.parseDouble(data[5]);
		double proton_623 = Double.parseDouble(data[6]);

		pstmt.setInt(++idx, elec_s);
		pstmt.setDouble(++idx, elec_36);
		pstmt.setDouble(++idx, elec_125);
		pstmt.setInt(++idx, proton_s);
		pstmt.setDouble(++idx, proton_75);
		pstmt.setDouble(++idx, proton_137);
		pstmt.setDouble(++idx, proton_623);
		
		return true;
	}
}