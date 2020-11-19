package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GoesMag extends SWPCFormatData {
	public GoesMag() {
		super(4);
	}

	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		double hp = Double.parseDouble(data[0]);
		double he = Double.parseDouble(data[1]);
		double hn = Double.parseDouble(data[2]);
		double total_fld = Double.parseDouble(data[3]);

		pstmt.setDouble(++idx, hp);
		pstmt.setDouble(++idx, he);
		pstmt.setDouble(++idx, hn);
		pstmt.setDouble(++idx, total_fld);
		
		return true;
	}
}