package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Het extends SWPCFormatData {
	public Het() {
		super(4);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int proton_13_s = Integer.parseInt(data[0], 10);
		double proton_13 = Double.parseDouble(data[1]);
		int proton_40_s = Integer.parseInt(data[2], 10);
		double proton_40 = Double.parseDouble(data[3]);

		pstmt.setInt(++idx, proton_13_s);
		pstmt.setDouble(++idx, proton_13);
		pstmt.setInt(++idx, proton_40_s);
		pstmt.setDouble(++idx, proton_40);
		
		return true;
	}
}