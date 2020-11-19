package com.gaia3d.swfc.batch.job.swpc;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AceEpam extends SWPCFormatData {
	public AceEpam() {
		super(10);
	}
	
	@Override
	public boolean setDataParameter(PreparedStatement pstmt, int idx, String[] data) throws SQLException {
		int ELEC_S = Integer.parseInt(data[0], 10);
		double ELEC_38 = Double.parseDouble(data[1]);
		double ELEC_175 = Double.parseDouble(data[2]);
		int PROT_S = Integer.parseInt(data[3], 10);
		double PROT_47 = Double.parseDouble(data[4]);
		double PROT_115 = Double.parseDouble(data[5]);
		double PROT_310 = Double.parseDouble(data[6]);
		double PROT_795 = Double.parseDouble(data[7]);
		double PROT_1060 = Double.parseDouble(data[8]);
		double ANIS_INDEX = Double.parseDouble(data[9]);

		pstmt.setInt(++idx, ELEC_S);
		pstmt.setDouble(++idx, ELEC_38);
		pstmt.setDouble(++idx, ELEC_175);
		pstmt.setInt(++idx, PROT_S);
		pstmt.setDouble(++idx, PROT_47);
		pstmt.setDouble(++idx, PROT_115);
		pstmt.setDouble(++idx, PROT_310);
		pstmt.setDouble(++idx, PROT_795);
		pstmt.setDouble(++idx, PROT_1060);
		pstmt.setDouble(++idx, ANIS_INDEX);
		
		return true;
	}
}