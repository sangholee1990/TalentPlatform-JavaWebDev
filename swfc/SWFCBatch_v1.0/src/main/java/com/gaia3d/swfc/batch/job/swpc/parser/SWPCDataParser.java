package com.gaia3d.swfc.batch.job.swpc.parser;

import java.net.URL;

import com.gaia3d.swfc.batch.job.swpc.SWPCDataType;
import com.gaia3d.swfc.batch.util.Database;

public interface SWPCDataParser {
	void parseData(Database database, SWPCDataType dataType, URL url) throws Exception;
}
