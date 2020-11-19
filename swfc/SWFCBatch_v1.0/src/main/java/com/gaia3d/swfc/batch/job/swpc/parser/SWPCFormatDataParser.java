package com.gaia3d.swfc.batch.job.swpc.parser;

import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.gaia3d.swfc.batch.job.swpc.AceEpam;
import com.gaia3d.swfc.batch.job.swpc.AceMag;
import com.gaia3d.swfc.batch.job.swpc.AceSWEpam;
import com.gaia3d.swfc.batch.job.swpc.AceSis;
import com.gaia3d.swfc.batch.job.swpc.GoesMag;
import com.gaia3d.swfc.batch.job.swpc.GoesParticle;
import com.gaia3d.swfc.batch.job.swpc.GoesXray1m;
import com.gaia3d.swfc.batch.job.swpc.GoesXray5m;
import com.gaia3d.swfc.batch.job.swpc.Het;
import com.gaia3d.swfc.batch.job.swpc.Impact;
import com.gaia3d.swfc.batch.job.swpc.Mag;
import com.gaia3d.swfc.batch.job.swpc.Plastic;
import com.gaia3d.swfc.batch.job.swpc.SWPCDataType;
import com.gaia3d.swfc.batch.job.swpc.SWPCFormatData;
import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class SWPCFormatDataParser implements SWPCDataParser {

	static final Logger logger = LogManager.getLogger(SWPCFormatDataParser.class.getName());

	private SWPCFormatData createDataInstance(SWPCDataType dataType) {
		switch (dataType) {
		case STA_PLASTIC:
		case STB_PLASTIC:
			return new Plastic();
		case STA_MAG:
		case STB_MAG:
			return new Mag();
		case STA_IMPACT:
		case STB_IMPACT:
			return new Impact();
		case STA_HET:
		case STB_HET:
			return new Het();

		case ACE_EPAM:
			return new AceEpam();
		case ACE_SWEPAM:
			return new AceSWEpam();
		case ACE_SIS:
			return new AceSis();
		case ACE_MAG:
			return new AceMag();
		case GOES_XRAY_1M:
			return new GoesXray1m();
		case GOES_XRAY_5M:
			return new GoesXray5m();

		case GOES_PARTICLE_P:
		case GOES_PARTICLE_S:
			return new GoesParticle();

		case GOES_MAG_P:
		case GOES_MAG_S:
			return new GoesMag();
		default:
			throw new IllegalArgumentException("Not Implemented Data Type!");
		}
	}

	@Override
	public void parseData(Database database, final SWPCDataType dataType, URL url) throws Exception {
		final SWPCFormatDataParser parser = this;
		final PreparedStatement pstmt = database.preparedStatement(dataType.getSql());
		try {
			final String filename = FilenameUtils.getName(url.getFile());
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
				StringBuilder builder = new StringBuilder();

				@Override
				public Boolean getResult() {
					try {
						pstmt.executeBatch();
					} catch (SQLException e) {
						logger.error(String.format("[%s]Commit data from %s", dataType, filename), e);
						return false;
					}
					return true;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					if (line.startsWith(":") || line.startsWith("#")) {
						return true;
					}
					try {
						builder.append(line);
						SWPCFormatData data = parser.createDataInstance(dataType);
						data.parseData(line);
						pstmt.clearParameters();
						if(data.setParameter(pstmt))
							pstmt.addBatch();
					} catch (Exception e) {
						logger.warn(String.format("[%s]Parsing line from %s : %s", dataType, filename, line), e);
					}
					return true;
				}
			});
		} finally {
			Utils.Close(pstmt);
		}
	}
}
