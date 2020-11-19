package com.gaia3d.swfc.batch.job.swpc;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.gaia3d.swfc.batch.job.config.SWPCDataConfig;
import com.gaia3d.swfc.batch.job.swpc.parser.SWPCDataParser;
import com.gaia3d.swfc.batch.util.Database;
import com.google.common.collect.Multimap;

public class SWPCDataLoader {
	
	static final Logger logger = LogManager.getLogger(SWPCDataLoader.class.getName());

	Database db;
	public SWPCDataLoader(Database db) {
		this.db = db;
	}
	
	public void load(SWPCDataType dataType, URL url) {
		if(logger.isInfoEnabled()) {
			logger.info("Retrieving data[" + dataType + "] from " + url);
		}
		
		try {
			SWPCDataParser parser = dataType.getDataParser();
			parser.parseData(db, dataType, url);
		} catch (Exception e) {
			logger.error(String.format("Parsing data[%s]", dataType), e);
		}
	}
	
	public void load(SWPCDataConfig config) {
		Multimap<SWPCDataType, URL> data = config.getData();
		for (SWPCDataType dataType : data.keySet()) {
			List<Exception> exceptions = new ArrayList<Exception>();
			boolean success = false;
			for(URL url : data.get(dataType)) {
				if(logger.isInfoEnabled()) {
					logger.info("Retrieving data[" + dataType + "] from " + url);
				}
				
				try {
					SWPCDataParser parser = dataType.getDataParser();
					parser.parseData(db, dataType, url);
					success = true;
					break;
				} catch (Exception e) {
					exceptions.add(e);
				}
			}
			if(success == false) {
				for(Exception e : exceptions) {
					logger.error(String.format("Parsing data[%s]", dataType), e);
				}
			}
		}
	}
}
