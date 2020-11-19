package com.gaia3d.swfc.batch.job;

import java.net.URL;
import java.util.Calendar;

import org.apache.commons.configuration.XMLConfiguration;

import com.gaia3d.swfc.batch.job.config.SWPCDataConfig;
import com.gaia3d.swfc.batch.job.swpc.SWPCDataLoader;
import com.gaia3d.swfc.batch.job.swpc.SWPCDataType;
import com.gaia3d.swfc.batch.util.Database;
import com.google.common.collect.Multimap;

public class SWPC extends DatabaseBatchJob {
	
	final String configFile;
	public SWPC(String config) {
		this.configFile = config;
	}
	
	@Override
	protected void doJob(final Database db, final Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);
		
		SWPCDataLoader loader = new SWPCDataLoader(db);
		
		String[] http = config.getStringArray("source.swpc_list[@http]");
		
		SWPCDataConfig conf = new SWPCDataConfig();
		
		if(http.length == 0) {
			conf.loadConfig(config.configurationAt("source.swpc_list"));
			if(logger.isDebugEnabled())
				logger.debug(conf);
			loader.load(conf);
		} else {
			conf.loadFromHttp(http);
			if(logger.isDebugEnabled())
				logger.debug(conf);
			
			Multimap<SWPCDataType, URL> data = conf.getData();
			for (SWPCDataType dataType : data.keySet()) {
				for(URL url : data.get(dataType)) {
					if(logger.isInfoEnabled()) {
						logger.info("Retrieving data[" + dataType + "] from " + url);
					}
					loader.load(dataType, url);
				}
			}

		}
	}
}
