package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GoesParticle extends SWPCFormatData {
	public GoesParticle() {
		super(9);
	}

	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		double p1 = Double.parseDouble(data[0]);
		double p5 = Double.parseDouble(data[1]);
		double p10 = Double.parseDouble(data[2]);
		double p30 = Double.parseDouble(data[3]);
		double p50 = Double.parseDouble(data[4]);
		double p100 = Double.parseDouble(data[5]);
		double e8 = Double.parseDouble(data[6]);
		double e20 = Double.parseDouble(data[7]);
		double e40 = Double.parseDouble(data[8]);
		
		pstmt.setDouble(++idx, p1);
		pstmt.setDouble(++idx, p5);
		pstmt.setDouble(++idx, p10);
		pstmt.setDouble(++idx, p30);
		pstmt.setDouble(++idx, p50);
		pstmt.setDouble(++idx, p100);
		pstmt.setDouble(++idx, e8);
		pstmt.setDouble(++idx, e20);
		pstmt.setDouble(++idx, e40);
		
		return true;
	}
}