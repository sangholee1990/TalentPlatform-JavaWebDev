package com.gaia3d.swfc.batch;

import java.util.Arrays;
import java.util.Calendar;
import java.util.TimeZone;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.lang.NotImplementedException;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Appender;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Level;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.RollingFileAppender;

import com.gaia3d.swfc.batch.job.KhuDstIndex;
import com.gaia3d.swfc.batch.job.KhuFlarePredication;
import com.gaia3d.swfc.batch.job.KhuKpIndex;
import com.gaia3d.swfc.batch.job.KhuSolarProtonEvent;
import com.gaia3d.swfc.batch.job.KyotoDstIndex;
import com.gaia3d.swfc.batch.job.MagnetopauseRaidus;
import com.gaia3d.swfc.batch.job.MultiBatchJob;
import com.gaia3d.swfc.batch.job.SWPC;
import com.gaia3d.swfc.batch.job.SdoImage;
import com.gaia3d.swfc.batch.job.SohoImage;
import com.gaia3d.swfc.batch.job.SolarMaximum;
import com.gaia3d.swfc.batch.job.StereoImage;
import com.gaia3d.swfc.batch.job.TEC;
import com.google.common.collect.Iterables;

/** Class comment. */
public class App {
	static final Logger logger = LogManager.getLogger(App.class.getName());

	/** Batch Type Enum */
	enum BatchType {
		SDO_IMAGE("conf/sdo_image.xml"), 
		STEREO_IMAGE("conf/stereo_image.xml"), 
		SOHO_IMAGE("conf/soho_image.xml"), 
		
		SWPC("conf/swpc.xml"), 
		MAGPAUSE_RADIUS("conf/magnetopause_raidus.xml"),
		
		KYOTO_DST("conf/kyoto_dst.xml"),
		
		KHU_DST("conf/khu_dst.xml"), 
		KHU_SPE("conf/khu_spe.xml"),
		KHU_FLARE("conf/khu_flare.xml"),
		KHU_KP("conf/khu_kp.xml"),
		
		TEC("conf/tec.xml"),
		SOLAR_MAXIMUM("conf/solar_maximum.xml");
		
		final private String configFile; 
		BatchType(String configFile) {
			this.configFile = configFile;
		}
		
		public String getConfigFile() {
			return this.configFile;
		}
	}

	enum LogLevel {
		debug, info, warn, error, off
	}

	private static Appender createRollingFileAppender(String name, String file) {
		RollingFileAppender appender = new RollingFileAppender();
		appender.setName("name");
		appender.setAppend(true);
		appender.setMaxBackupIndex(10);
		appender.setLayout(new PatternLayout("[%d{yyyy-MM-dd HH:mm:ss.SSS}] %-5p - %m%n"));
		appender.setFile(file);
		appender.activateOptions();
		return appender;
	}

	private static Appender createConsoleAppender() {
		ConsoleAppender appender = new ConsoleAppender();
		appender.setName("ConsoleAppender");
		// appender.setLayout(new PatternLayout("%-5p - %m%n"));
		appender.setLayout(new PatternLayout("[%d{yyyy-MM-dd HH:mm:ss.SSS}] %-5p - %m%n"));
		appender.activateOptions();
		return appender;
	}

	/** main */
	public static void main(String[] args) {
		logger.addAppender(createRollingFileAppender("defaultLogger", String.format("logs/error.log")));
		logger.setLevel(Level.ERROR);
		
		Logger rootLogger = Logger.getRootLogger();

		args = new String[] { "-tSWPC", "-console"};
		// DOMConfigurator.configure("conf/log4j.xml");

		Options options = new Options();
		options.addOption(new Option("t", "type", true, "Batch type " + Iterables.toString(Arrays.asList(BatchType.values()))));
		options.addOption(new Option("c", "config", true, "Config file"));
		options.addOption(new Option("console", false, "Logging to console"));
		options.addOption(new Option("l", "logLevel", true, "Set loglevel (warn) " + Iterables.toString(Arrays.asList(LogLevel.values()))));

		CommandLineParser parser = new GnuParser();
		CommandLine cmd = null;
		try {
			String cmdSyntax = "java -jar SWFCBatch.jar";
			cmd = parser.parse(options, args);

			if (cmd.hasOption("console")) {
				rootLogger.addAppender(createConsoleAppender());
			}

			try {
				switch (LogLevel.valueOf(cmd.getOptionValue("l", "info"))) {
				case debug:
					rootLogger.setLevel(Level.DEBUG);
					break;

				case error:
					rootLogger.setLevel(Level.ERROR);
					break;

				case info:
					rootLogger.setLevel(Level.INFO);
					break;

				case off:
					rootLogger.setLevel(Level.OFF);
					break;

				case warn:
					rootLogger.setLevel(Level.WARN);
				}
			} catch (Exception ex) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp(cmdSyntax, "Invalid logLevel", options, "", true);
				return;
			}

			if (!cmd.hasOption("t")) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp(cmdSyntax, "Invalid batch type", options, "", true);
				return;
			}
			
			try {
				BatchType.valueOf(cmd.getOptionValue("type"));
			} catch (Exception ex) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp(cmdSyntax, "Invalid batch type", options, "", true);
				return;
			}
		} catch (Exception ex) {
			rootLogger.addAppender(createConsoleAppender());
			logger.error(ex.getMessage());
		}

		if (cmd != null) {
			TimeZone utc = TimeZone.getTimeZone("UTC");
			Calendar calenar = Calendar.getInstance(utc);
			logger.info("ScheduledDate : " + calenar.getTime().toString());
			
			try {
				MultiBatchJob batch = new MultiBatchJob();
				BatchType batchType = BatchType.valueOf(cmd.getOptionValue("t"));
				String configFile = cmd.getOptionValue("c");
				if(StringUtils.isBlank(configFile))
					configFile = batchType.getConfigFile();
				
				switch (batchType) {
				case SDO_IMAGE:
					batch.addJob(new SdoImage(configFile));
					break;
					
				case STEREO_IMAGE:
					batch.addJob(new StereoImage(configFile));
					break;

				case SWPC:
					batch.addJob(new SWPC(configFile));
					
					break;

				case SOHO_IMAGE:
					batch.addJob(new SohoImage(configFile));
					break;

				case MAGPAUSE_RADIUS:
					batch.addJob(new MagnetopauseRaidus(configFile));
					break;
					
				case KYOTO_DST:
					batch.addJob(new KyotoDstIndex(configFile));
					break;
					
				case KHU_DST:
					batch.addJob(new KhuDstIndex(configFile));
					break;
				case KHU_KP:
					batch.addJob(new KhuKpIndex(configFile));
					break;
				case KHU_SPE:
					batch.addJob(new KhuSolarProtonEvent(configFile));
					break;
				case KHU_FLARE:
					batch.addJob(new KhuFlarePredication(configFile));
					break;

				case TEC:
					batch.addJob(new TEC(configFile));
					break;
					
				case SOLAR_MAXIMUM:
					batch.addJob(new SolarMaximum(configFile));
					break;
					
				default:
					throw new NotImplementedException("Not implemented batch type : " + batchType.name());
				}

				rootLogger.addAppender(createRollingFileAppender("RollingFileAppender", String.format("logs/%s.log", batchType.toString())));
				
				batch.run(calenar);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
		}
	}
}
