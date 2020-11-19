package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.util.Calendar;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.gaia3d.swfc.batch.util.Database;
import com.google.common.base.Stopwatch;

/**
 * Abstract batch job class for database
 * 
 */
public abstract class DatabaseBatchJob implements IBatchJob{
	static final Logger logger = LogManager.getLogger(DatabaseBatchJob.class.getName());
	
	private Database db = new Database();
	/** 
	 * Load batch configuration file
	 * @param configFile configuration file path
	 */
	protected XMLConfiguration loadConfigFile(String configFile) throws FileNotFoundException, ConfigurationException {
		File file = new File(configFile);
		if (logger.isDebugEnabled())
			logger.debug("Load batch configuration file : " + file.getPath());

		if (!file.exists()) {
			throw new FileNotFoundException(file.getPath());
		}

		XMLConfiguration config = new XMLConfiguration(file);
		
		if (logger.isDebugEnabled())
			logger.debug("Load batch configuration file is complete.");
		
		return config;
	}
	
	/** 
	 * Initialize database connection
	 * load database properties from conf/database.xml
	 */

	private void initDatabase() throws SQLException, FileNotFoundException, ConfigurationException {
		File file = new File("conf/database.xml");

		if (logger.isDebugEnabled())
			logger.debug("Load database configuration file : " + file.getPath());

		if (!file.exists()) {
			throw new FileNotFoundException(file.getPath());
		}
		
		XMLConfiguration config = new XMLConfiguration(file);
		db.connect(config.getString("database.url"), config.getString("database.username"), config.getString("database.password"));
		
		if (logger.isDebugEnabled())
			logger.debug("Load database configuration file is complete.");
	}
	
	public void run(final Calendar calenar) {
		Stopwatch stopwatch = Stopwatch.createStarted();
		if(logger.isInfoEnabled())
			logger.info(this.getClass().getSimpleName() + " job is started.");
		try {
			initDatabase();
			doJob(db, calenar);
		} catch(Exception ex) {
			logger.error(ex);
		} finally {
			db.close();
			db = null;
		}
		
		if(logger.isInfoEnabled())
			logger.info(this.getClass().getSimpleName() + " job is complete.(" + stopwatch.toString() + ")");
	}
	
	/** 
	 * Execute batch
	 * @param db Database instance
	 */
	protected abstract void doJob (final Database db, final Calendar calendar) throws Exception;
}
