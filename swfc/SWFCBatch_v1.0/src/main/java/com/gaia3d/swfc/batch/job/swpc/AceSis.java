package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AceSis extends SWPCFormatData {
	public AceSis() {
		super(4);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int integ_10_s = Integer.parseInt(data[0], 10);
		double integ_10 = Double.parseDouble(data[1]);
		int integ_30_s = Integer.parseInt(data[2], 10);
		double integ_30 = Double.parseDouble(data[3]);

		pstmt.setInt(++idx, integ_10_s);
		pstmt.setDouble(++idx, integ_10);
		pstmt.setInt(++idx, integ_30_s);
		pstmt.setDouble(++idx, integ_30);
		
		return true;
	}
}