package com.gaia3d.swfc.batch.job.swpc;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.gaia3d.swfc.batch.job.swpc.parser.AKFormatDataParser;
import com.gaia3d.swfc.batch.job.swpc.parser.SWPCDataParser;
import com.gaia3d.swfc.batch.job.swpc.parser.SWPCFormatDataParser;
import com.google.common.base.Function;
import com.google.common.base.Joiner;
import com.google.common.base.Splitter;
import com.google.common.collect.Iterables;

public enum SWPCDataType {
	STA_PLASTIC(SWPCFormatDataParser.class, "TB_STA_PLASTIC", "TM, MJD, SECOFDAY, S, PRO_DENS, BULK_SPD, ION_TEMP"),
	STB_PLASTIC(SWPCFormatDataParser.class, "TB_STB_PLASTIC", "TM, MJD, SECOFDAY, S, PRO_DENS, BULK_SPD, ION_TEMP"),
	STA_MAG(SWPCFormatDataParser.class, "TB_STA_MAG", "TM, MJD, SECOFDAY, S, BR, BT_L, BN, BT_S, LAT, LON"),
	STB_MAG(SWPCFormatDataParser.class, "TB_STB_MAG", "TM, MJD, SECOFDAY, S, BR, BT_L, BN, BT_S, LAT, LON"),
	STA_IMPACT(SWPCFormatDataParser.class, "TB_STA_IMPACT", "TM, MJD, SECOFDAY, ELEC_S, ELEC_36, ELEC_125, PROTON_S, PROTON_75, PROTON_137, PROTON_623"),
	STB_IMPACT(SWPCFormatDataParser.class, "TB_STB_IMPACT", "TM, MJD, SECOFDAY, ELEC_S, ELEC_36, ELEC_125, PROTON_S, PROTON_75, PROTON_137, PROTON_623"),
	STA_HET(SWPCFormatDataParser.class, "TB_STA_HET", "TM, MJD, SECOFDAY, PROTON_13_S, PROTON_13, PROTON_40_S, PROTON_40"),
	STB_HET(SWPCFormatDataParser.class, "TB_STB_HET", "TM, MJD, SECOFDAY, PROTON_13_S, PROTON_13, PROTON_40_S, PROTON_40"),
	
	ACE_EPAM(SWPCFormatDataParser.class, "TB_ACE_EPAM", "TM, MJD, SECOFDAY, ELEC_S, ELEC_38, ELEC_175, PROT_S, PROT_47, PROT_115, PROT_310, PROT_795, PROT_1060, ANIS_INDEX"),
	ACE_SWEPAM(SWPCFormatDataParser.class, "TB_ACE_SWEPAM", "TM, MJD, SECOFDAY, S, PRO_DENS, BULK_SPD, ION_TEMP"),
	ACE_SIS(SWPCFormatDataParser.class, "TB_ACE_SIS", "TM, MJD, SECOFDAY, INTEG_10_S, INTEG_10, INTEG_30_S, INTEG_30"),
	ACE_MAG(SWPCFormatDataParser.class, "TB_ACE_MAG", "TM, MJD, SECOFDAY, S, BX, BY, BZ, BT, LAT, LON"),
	
	GOES_XRAY_1M(SWPCFormatDataParser.class, "TB_GOES_XRAY_1M", "TM, MJD, SECOFDAY, SHORT_FLUX, LONG_FLUX"),
	GOES_XRAY_5M(SWPCFormatDataParser.class, "TB_GOES_XRAY_5M", "TM, MJD, SECOFDAY, SHORT_FLUX, LONG_FLUX, RATIO"),
	
	GOES_PARTICLE_P(SWPCFormatDataParser.class, "TB_GOES_PARTICLE_P", "TM, MJD, SECOFDAY, P1, P5, P10, P30, P50, P100, E8, E20, E40"),
	GOES_PARTICLE_S(SWPCFormatDataParser.class, "TB_GOES_PARTICLE_S", "TM, MJD, SECOFDAY, P1, P5, P10, P30, P50, P100, E8, E20, E40"),
	
	GOES_MAG_P(SWPCFormatDataParser.class, "TB_GOES_MAG_P", "TM, MJD, SECOFDAY, HP, HE, HN, TOTAL_FLD"),
	GOES_MAG_S(SWPCFormatDataParser.class, "TB_GOES_MAG_S", "TM, MJD, SECOFDAY, HP, HE, HN, TOTAL_FLD"),
	
	KP_INDEX(AKFormatDataParser.class, "TB_KP_INDEX", "TM, KP");

	static final Logger logger = LogManager.getLogger(SWPCDataType.class.getName());
	
	final private String sql;
	final private Class<? extends SWPCDataParser> parserClazz;
	
	SWPCDataType(Class<? extends SWPCDataParser> parserClazz, String tableName, String column) {
		this.parserClazz = parserClazz;
		
		//Escape column name;
		Iterable<String> columns =  Iterables.transform(Splitter.on(",").trimResults().split(column), new Function<String,String> () {
			@Override
			public String apply(String arg0) {
				return "\"" + arg0 + "\"";
			}
		});
		
		String sourceSql = "SELECT " + 
			Joiner.on(",").join(Iterables.transform(columns, new Function<String, String>() {
				@Override
				public String apply(String columnName) {
					return "? " + columnName;
				}
			})) + " FROM DUAL";
		
		
		String updateSql = "UPDATE SET " + 
			Joiner.on(",").join(Iterables.transform(Iterables.skip(columns, 1), new Function<String, String>() {
				@Override
				public String apply(String columnName) {
					return "DST." + columnName + "=" + "SRC." + columnName;
				}
			}));
		
		String insertSql = "INSERT (" + 
			Joiner.on(",").join(Iterables.transform(columns, new Function<String, String>() {
				@Override
				public String apply(String columnName) {
					return "DST." + columnName;
				}
			})) + ") VALUES (" + 
			Joiner.on(",").join(Iterables.transform(columns, new Function<String, String>() {
				@Override
				public String apply(String columnName) {
					return "SRC." + columnName;
				}
			})) + ")";
		
		this.sql = "MERGE INTO " + tableName + " DST USING (" + sourceSql + ") SRC ON (DST.TM=SRC.TM) WHEN MATCHED THEN " + updateSql + " WHEN NOT MATCHED THEN " + insertSql;
	}
	
	public String getSql() {
		if(logger.isDebugEnabled())
			logger.debug(sql);
		return this.sql;
	}
	
	public SWPCDataParser getDataParser() throws InstantiationException, IllegalAccessException {
		return parserClazz.newInstance();
	}
}
