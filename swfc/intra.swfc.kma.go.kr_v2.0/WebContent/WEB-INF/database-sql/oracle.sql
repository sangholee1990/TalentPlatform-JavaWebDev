--------------------------------------------------------
--  파일이 생성됨 - 수요일-11월-27-2013   
--------------------------------------------------------
DROP TABLE "TB_ACE_EPAM";
DROP TABLE "TB_ACE_MAG";
DROP TABLE "TB_ACE_SIS";
DROP TABLE "TB_ACE_SWEPAM";
DROP TABLE "TB_ANALYSIS_RESULT";
DROP TABLE "TB_DST_INDEX";
DROP TABLE "TB_DST_INDEX_KHU";
DROP TABLE "TB_FLARE_PREDICATION";
DROP TABLE "TB_FLARE_PREDICATION_DETAIL";
DROP TABLE "TB_GOES_MAG_P";
DROP TABLE "TB_GOES_MAG_S";
DROP TABLE "TB_GOES_PARTICLE_P";
DROP TABLE "TB_GOES_PARTICLE_S";
DROP TABLE "TB_GOES_XRAY_1M";
DROP TABLE "TB_GOES_XRAY_5M";
DROP TABLE "TB_IMAGE_META";
DROP TABLE "TB_KP_INDEX";
DROP TABLE "TB_KP_INDEX_KHU";
DROP TABLE "TB_MAGNETOPAUSE_RADIUS";
DROP TABLE "TB_MEASUREMENT";
DROP TABLE "TB_PDS";
DROP TABLE "TB_PROGRAM_LIST";
DROP TABLE "TB_REPORT_LIST";
DROP TABLE "TB_SOLAR_MAXIMUM";
DROP TABLE "TB_SOLAR_PROTON_EVENT";
DROP TABLE "TB_SPACECRAFT_DATA_CODE";
DROP TABLE "TB_SPACECRAFT_INFO";
DROP TABLE "TB_STA_HET";
DROP TABLE "TB_STA_IMPACT";
DROP TABLE "TB_STA_MAG";
DROP TABLE "TB_STA_PLASTIC";
DROP TABLE "TB_STB_HET";
DROP TABLE "TB_STB_IMPACT";
DROP TABLE "TB_STB_MAG";
DROP TABLE "TB_STB_PLASTIC";
DROP TABLE "TB_TEC";
DROP TABLE "TB_USER_LIST";
DROP TABLE "TB_USER_GROUP_CMD_FUNC";
DROP TABLE "TB_CME_FUNC_LIST";
DROP TABLE "TB_USER_GROUP";
DROP SEQUENCE "SEQ_TB_FLARE_PREDIC_DETAIL";
DROP SEQUENCE "SEQ_TB_IMAGE_META";
DROP SEQUENCE "SEQ_TB_PDS";
DROP SEQUENCE "SEQ_TB_PROGRAM_LIST";
DROP SEQUENCE "SEQ_TB_REPORT_LIST";
--------------------------------------------------------

--  DDL for Sequence SEQ_TB_FLARE_PREDIC_DETAIL

--------------------------------------------------------


   CREATE SEQUENCE  "SEQ_TB_FLARE_PREDIC_DETAIL";
/
--------------------------------------------------------

--  DDL for Sequence SEQ_TB_IMAGE_META

--------------------------------------------------------


   CREATE SEQUENCE  "SEQ_TB_IMAGE_META";
/
--------------------------------------------------------

--  DDL for Sequence SEQ_TB_PDS

--------------------------------------------------------


   CREATE SEQUENCE  "SEQ_TB_PDS";
/
--------------------------------------------------------

--  DDL for Sequence SEQ_TB_PROGRAM_LIST

--------------------------------------------------------


   CREATE SEQUENCE  "SEQ_TB_PROGRAM_LIST";
/
--------------------------------------------------------

--  DDL for Sequence SEQ_TB_REPORT_LIST

--------------------------------------------------------


   CREATE SEQUENCE  "SEQ_TB_REPORT_LIST";
/
--------------------------------------------------------

--  DDL for Table TB_ACE_EPAM

--------------------------------------------------------


  CREATE TABLE "TB_ACE_EPAM" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"ELEC_S" NUMBER(*,0), 
	"ELEC_38" NUMBER, 
	"ELEC_175" NUMBER, 
	"PROT_S" NUMBER(*,0), 
	"PROT_47" NUMBER, 
	"PROT_115" NUMBER, 
	"PROT_310" NUMBER, 
	"PROT_795" NUMBER, 
	"PROT_1060" NUMBER, 
	"ANIS_INDEX" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_ACE_EPAM"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."ELEC_S" IS 'Electron Status';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."ELEC_38" IS 'Electron 38-53';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."ELEC_175" IS 'Electron 175-315';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_S" IS 'Proton Status';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_47" IS 'Proton 47-68';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_115" IS 'Proton 115-195';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_310" IS 'Proton 310-580';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_795" IS 'Proton 795-1193';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."PROT_1060" IS 'Proton 1060-1900';
 
   COMMENT ON COLUMN "TB_ACE_EPAM"."ANIS_INDEX" IS 'Anis. Index';
 
   COMMENT ON TABLE "TB_ACE_EPAM"  IS 'ACE Electron Proton and Alpha Monitor';
/
--------------------------------------------------------

--  DDL for Table TB_ACE_MAG

--------------------------------------------------------


  CREATE TABLE "TB_ACE_MAG" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"BX" NUMBER, 
	"BY" NUMBER, 
	"BZ" NUMBER, 
	"BT" NUMBER, 
	"LAT" NUMBER, 
	"LON" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_ACE_MAG"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."BX" IS 'GSM Coordinates - Bx';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."BY" IS 'GSM Coordinates - By';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."BZ" IS 'GSM Coordinates - Bz';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."BT" IS 'GSM Coordinates - Bt';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."LAT" IS 'GSM Coordinates - Lat.';
 
   COMMENT ON COLUMN "TB_ACE_MAG"."LON" IS 'GSM Coordinates - Lon.';
 
   COMMENT ON TABLE "TB_ACE_MAG"  IS 'ACE Magnetometer';
/
--------------------------------------------------------

--  DDL for Table TB_ACE_SIS

--------------------------------------------------------


  CREATE TABLE "TB_ACE_SIS" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"INTEG_10_S" NUMBER(*,0), 
	"INTEG_10" NUMBER, 
	"INTEG_30_S" NUMBER(*,0), 
	"INTEG_30" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_ACE_SIS"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."INTEG_10_S" IS 'Integral Proton Flux >10 Mev Status';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."INTEG_10" IS 'Integral Proton Flux >10 Mev';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."INTEG_30_S" IS 'Integral Proton Flux >30 Mev Status';
 
   COMMENT ON COLUMN "TB_ACE_SIS"."INTEG_30" IS 'Integral Proton Flux >30 Mev';
 
   COMMENT ON TABLE "TB_ACE_SIS"  IS 'ACE Solar Isotope Spectrometer';
/
--------------------------------------------------------

--  DDL for Table TB_ACE_SWEPAM

--------------------------------------------------------


  CREATE TABLE "TB_ACE_SWEPAM" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"PRO_DENS" NUMBER, 
	"BULK_SPD" NUMBER, 
	"ION_TEMP" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_ACE_SWEPAM"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."PRO_DENS" IS 'Proton Density';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."BULK_SPD" IS 'Bulk Speed';
 
   COMMENT ON COLUMN "TB_ACE_SWEPAM"."ION_TEMP" IS 'Ion Temperature';
 
   COMMENT ON TABLE "TB_ACE_SWEPAM"  IS 'ACE Solar Wind Electron Proton Alpha Monitor';
/
--------------------------------------------------------

--  DDL for Table TB_ANALYSIS_RESULT

--------------------------------------------------------


  CREATE TABLE "TB_ANALYSIS_RESULT" 
   (	"ID" VARCHAR2(20 BYTE), 
	"ANALYST" VARCHAR2(20 BYTE), 
	"STATE" CHAR(1 BYTE), 
	"CREATE_TIME" DATE, 
	"LAST_SAVE_TIME" DATE, 
	"MODIFYING" CHAR(1 BYTE), 
	"TARGET1_POS_X" FLOAT(63), 
	"TARGET1_POS_Y" FLOAT(63), 
	"TARGET1_POS_Z" FLOAT(63), 
	"TARGET1_ROLL" CHAR(1 BYTE), 
	"TARGET1_START_SC_CODE" CHAR(10 BYTE), 
	"TARGET1_START_SC_INFO_SEQ" NUMBER(*,0), 
	"TARGET1_START_OBS_TIME" DATE, 
	"TARGET1_END_SC_CODE" CHAR(10 BYTE), 
	"TARGET1_END_SC_INFO_SEQ" NUMBER(*,0), 
	"TARGET1_END_OBS_TIME" DATE, 
	"TARGET2_POS_X" FLOAT(63), 
	"TARGET2_POS_Y" FLOAT(63), 
	"TARGET2_POS_Z" FLOAT(63), 
	"TARGET2_ROLL" CHAR(1 BYTE), 
	"TARGET2_START_SC_CODE" CHAR(10 BYTE), 
	"TARGET2_START_SC_INFO_SEQ" NUMBER(*,0), 
	"TARGET2_START_OBS_TIME" DATE, 
	"TARGET2_END_SC_CODE" CHAR(10 BYTE), 
	"TARGET2_END_SC_INFO_SEQ" NUMBER(*,0), 
	"TARGET2_END_OBS_TIME" DATE, 
	"TARGET1_SPEED_MIN" FLOAT(63), 
	"TARGET1_SPEED_MAX" FLOAT(63), 
	"TARGET1_SPEED_AVG" FLOAT(63), 
	"TARGET1_SPEED_SD" FLOAT(63), 
	"TARGET1_HALF_WIDTH_MIN" FLOAT(63), 
	"TARGET1_HALF_WIDTH_MAX" FLOAT(63), 
	"TARGET1_HALF_WIDTH_AVG" FLOAT(63), 
	"TARGET1_HALF_WIDTH_SD" FLOAT(63), 
	"TARGET2_SPEED_MIN" FLOAT(63), 
	"TARGET2_SPEED_MAX" FLOAT(63), 
	"TARGET2_SPEED_AVG" FLOAT(63), 
	"TARGET2_SPEED_SD" FLOAT(63), 
	"TARGET2_HALF_WIDTH_MIN" FLOAT(63), 
	"TARGET2_HALF_WIDTH_MAX" FLOAT(63), 
	"TARGET2_HALF_WIDTH_AVG" FLOAT(63), 
	"TARGET2_HALF_WIDTH_SD" FLOAT(63), 
	"RSLT_SPEED_MIN" FLOAT(63), 
	"RSLT_SPEED_MAX" FLOAT(63), 
	"RSLT_SPEED_AVG" FLOAT(63), 
	"RSLT_SPEED_SD" FLOAT(63), 
	"RSLT_LON_MIN" FLOAT(63), 
	"RSLT_LON_MAX" FLOAT(63), 
	"RSLT_LON_AVG" FLOAT(63), 
	"RSLT_LON_SD" FLOAT(63), 
	"RSLT_LAT_MIN" FLOAT(63), 
	"RSLT_LAT_MAX" FLOAT(63), 
	"RSLT_LAT_AVG" FLOAT(63), 
	"RSLT_LAT_SD" FLOAT(63), 
	"RSLT_HALF_WIDTH_MIN" FLOAT(63), 
	"RSLT_HALF_WIDTH_MAX" FLOAT(63), 
	"RSLT_HALF_WIDTH_AVG" FLOAT(63), 
	"RSLT_HALF_WIDTH_SD" FLOAT(63), 
	"RSLT_1AU_ARRIVAL_TIME_MIN" DATE, 
	"RSLT_1AU_ARRIVAL_TIME_MAX" DATE, 
	"RSLT_1AU_ARRIVAL_TIME_AVG" DATE, 
	"RSLT_1AU_ARRIVAL_TIME_SD" NUMBER(*,0), 
	"ACE_EPAM_TIME" DATE, 
	"ACE_MAG_TIME" DATE, 
	"ACE_SIS_TIME" DATE, 
	"ACE_SWEPAM_TIME" DATE, 
	"GOES_ELEC_TIME" DATE, 
	"GOES_XRAY_TIME" DATE, 
	"STA_HET_TIME" DATE, 
	"STA_IMPACT_TIME" DATE, 
	"STA_MAG_TIME" DATE, 
	"STA_PLASTIC_TIME" DATE, 
	"STB_HET_TIME" DATE, 
	"STB_IMPACT_TIME" DATE, 
	"STB_MAG_TIME" DATE, 
	"STB_PLASTIC_TIME" DATE, 
	"ANALYSIS_RPT_PATH" VARCHAR2(60 BYTE), 
	"VALID_RPT_PATH" VARCHAR2(60 BYTE), 
	"CTRL_FILE_PATH" VARCHAR2(60 BYTE), 
	"RSLT_21_5RS_ARRIVAL_TIME_MIN" DATE, 
	"RSLT_21_5RS_ARRIVAL_TIME_MAX" DATE, 
	"RSLT_21_5RS_ARRIVAL_TIME_AVG" DATE, 
	"RSLT_21_5RS_ARRIVAL_TIME_SD" NUMBER(*,0)
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_CME_FUNC_LIST

--------------------------------------------------------


  CREATE TABLE "TB_CME_FUNC_LIST" 
   (	"CODE" CHAR(7 BYTE), 
	"NAME" VARCHAR2(100 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_CME_FUNC_LIST"."CODE" IS '기능 코드';
 
   COMMENT ON COLUMN "TB_CME_FUNC_LIST"."NAME" IS '기능 이름';
 
   COMMENT ON TABLE "TB_CME_FUNC_LIST"  IS 'CMD 기능 목록';
/
--------------------------------------------------------

--  DDL for Table TB_DST_INDEX

--------------------------------------------------------


  CREATE TABLE "TB_DST_INDEX" 
   (	"TM" VARCHAR2(20 BYTE), 
	"DST" NUMBER(11,0)
   ) ;
 


   COMMENT ON COLUMN "TB_DST_INDEX"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_DST_INDEX"."DST" IS 'Dst Value';
 
   COMMENT ON TABLE "TB_DST_INDEX"  IS 'Dst Index from kyoto';
/
--------------------------------------------------------

--  DDL for Table TB_DST_INDEX_KHU

--------------------------------------------------------


  CREATE TABLE "TB_DST_INDEX_KHU" 
   (	"TM" VARCHAR2(20 BYTE), 
	"DST" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_DST_INDEX_KHU"."TM" IS 'Time';
 
   COMMENT ON COLUMN "TB_DST_INDEX_KHU"."DST" IS 'Dst Value';
 
   COMMENT ON TABLE "TB_DST_INDEX_KHU"  IS 'Dst Index from KHU';
/
--------------------------------------------------------

--  DDL for Table TB_FLARE_PREDICATION

--------------------------------------------------------


  CREATE TABLE "TB_FLARE_PREDICATION" 
   (	"CREATE_DATE" DATE, 
	"TOTAL_C" NUMBER, 
	"TOTAL_M" NUMBER, 
	"TOTAL_X" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_FLARE_PREDICATION"."CREATE_DATE" IS '생성시간';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION"."TOTAL_C" IS 'Total C';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION"."TOTAL_M" IS 'Total M';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION"."TOTAL_X" IS 'Total X';
 
   COMMENT ON TABLE "TB_FLARE_PREDICATION"  IS 'Flare Predication Table';
/
--------------------------------------------------------

--  DDL for Table TB_FLARE_PREDICATION_DETAIL

--------------------------------------------------------


  CREATE TABLE "TB_FLARE_PREDICATION_DETAIL" 
   (	"ID" NUMBER, 
	"CREATE_DATE" DATE, 
	"CLS" VARCHAR2(20 BYTE), 
	"AR" NUMBER(11,0), 
	"PHASE" VARCHAR2(20 BYTE), 
	"C" NUMBER, 
	"M" NUMBER, 
	"X" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."ID" IS '고유번호';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."CREATE_DATE" IS '생성시간';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."CLS" IS 'Class';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."AR" IS 'AR';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."PHASE" IS 'PHASE';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."C" IS 'C';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."M" IS 'M';
 
   COMMENT ON COLUMN "TB_FLARE_PREDICATION_DETAIL"."X" IS 'X';
 
   COMMENT ON TABLE "TB_FLARE_PREDICATION_DETAIL"  IS 'Flare Predication Detail Table';
/
--------------------------------------------------------

--  DDL for Table TB_GOES_MAG_P

--------------------------------------------------------


  CREATE TABLE "TB_GOES_MAG_P" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"HP" NUMBER, 
	"HE" NUMBER, 
	"HN" NUMBER, 
	"TOTAL_FLD" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_GOES_MAG_P"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."HP" IS 'Hp';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."HE" IS 'He';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."HN" IS 'Hn';
 
   COMMENT ON COLUMN "TB_GOES_MAG_P"."TOTAL_FLD" IS 'Total Field';
 
   COMMENT ON TABLE "TB_GOES_MAG_P"  IS 'GOES MAGNETOMETER Primary';
/
--------------------------------------------------------

--  DDL for Table TB_GOES_MAG_S

--------------------------------------------------------


  CREATE TABLE "TB_GOES_MAG_S" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"HP" NUMBER, 
	"HE" NUMBER, 
	"HN" NUMBER, 
	"TOTAL_FLD" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_GOES_MAG_S"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."HP" IS 'Hp';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."HE" IS 'He';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."HN" IS 'Hn';
 
   COMMENT ON COLUMN "TB_GOES_MAG_S"."TOTAL_FLD" IS 'Total Field';
 
   COMMENT ON TABLE "TB_GOES_MAG_S"  IS 'GOES MAGNETOMETER Secondary';
/
--------------------------------------------------------

--  DDL for Table TB_GOES_PARTICLE_P

--------------------------------------------------------


  CREATE TABLE "TB_GOES_PARTICLE_P" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"P1" NUMBER, 
	"P5" NUMBER, 
	"P10" NUMBER, 
	"P30" NUMBER, 
	"P50" NUMBER, 
	"P100" NUMBER, 
	"E8" NUMBER, 
	"E20" NUMBER, 
	"E40" NUMBER
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_GOES_PARTICLE_S

--------------------------------------------------------


  CREATE TABLE "TB_GOES_PARTICLE_S" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"P1" NUMBER, 
	"P5" NUMBER, 
	"P10" NUMBER, 
	"P30" NUMBER, 
	"P50" NUMBER, 
	"P100" NUMBER, 
	"E8" NUMBER, 
	"E20" NUMBER, 
	"E40" NUMBER
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_GOES_XRAY_1M

--------------------------------------------------------


  CREATE TABLE "TB_GOES_XRAY_1M" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"SHORT_FLUX" NUMBER, 
	"LONG_FLUX" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_GOES_XRAY_1M"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_1M"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_1M"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_1M"."SHORT_FLUX" IS 'Short';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_1M"."LONG_FLUX" IS 'Long';
 
   COMMENT ON TABLE "TB_GOES_XRAY_1M"  IS 'GOES X-Ray Data';
/
--------------------------------------------------------

--  DDL for Table TB_GOES_XRAY_5M

--------------------------------------------------------


  CREATE TABLE "TB_GOES_XRAY_5M" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"SHORT_FLUX" NUMBER, 
	"LONG_FLUX" NUMBER, 
	"RATIO" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."SHORT_FLUX" IS 'Short';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."LONG_FLUX" IS 'Long';
 
   COMMENT ON COLUMN "TB_GOES_XRAY_5M"."RATIO" IS 'Ratio';
 
   COMMENT ON TABLE "TB_GOES_XRAY_5M"  IS 'GOES X-Ray Data';
/
--------------------------------------------------------

--  DDL for Table TB_IMAGE_META

--------------------------------------------------------


  CREATE TABLE "TB_IMAGE_META" 
   (	"ID" NUMBER, 
	"CODE" CHAR(10 BYTE), 
	"CREATEDATE" DATE, 
	"FILEPATH" VARCHAR2(512 BYTE), 
	"X" FLOAT(63), 
	"Y" FLOAT(63), 
	"Z" FLOAT(63), 
	"ROLLINFO" CHAR(1 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_IMAGE_META"."ID" IS '고유번호';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."CODE" IS '데이터 코드';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."CREATEDATE" IS '이미지 시간';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."FILEPATH" IS '파일 경로';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."X" IS 'X좌표(HEEQ)';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."Y" IS 'Y좌표(HEEQ)';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."Z" IS 'Z좌표(HEEQ)';
 
   COMMENT ON COLUMN "TB_IMAGE_META"."ROLLINFO" IS '롤 여부';
 
   COMMENT ON TABLE "TB_IMAGE_META"  IS '이미지 데이터 저장 테이블';
/
--------------------------------------------------------

--  DDL for Table TB_KP_INDEX

--------------------------------------------------------


  CREATE TABLE "TB_KP_INDEX" 
   (	"TM" VARCHAR2(20 BYTE), 
	"KP" NUMBER(11,0)
   ) ;
 


   COMMENT ON COLUMN "TB_KP_INDEX"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_KP_INDEX"."KP" IS 'KP Value';
 
   COMMENT ON TABLE "TB_KP_INDEX"  IS 'Geomagnetic K Indices';
/
--------------------------------------------------------

--  DDL for Table TB_KP_INDEX_KHU

--------------------------------------------------------


  CREATE TABLE "TB_KP_INDEX_KHU" 
   (	"TM" VARCHAR2(20 BYTE), 
	"KP" NUMBER(11,0)
   ) ;
 


   COMMENT ON COLUMN "TB_KP_INDEX_KHU"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_KP_INDEX_KHU"."KP" IS 'KP Value';
 
   COMMENT ON TABLE "TB_KP_INDEX_KHU"  IS 'Geomagnetic K Indices from KHU';
/
--------------------------------------------------------

--  DDL for Table TB_MAGNETOPAUSE_RADIUS

--------------------------------------------------------


  CREATE TABLE "TB_MAGNETOPAUSE_RADIUS" 
   (	"TM" VARCHAR2(20 BYTE), 
	"RADIUS" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_MAGNETOPAUSE_RADIUS"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_MAGNETOPAUSE_RADIUS"."RADIUS" IS 'Radius';
 
   COMMENT ON TABLE "TB_MAGNETOPAUSE_RADIUS"  IS '자기권계면 테이블';
/
--------------------------------------------------------

--  DDL for Table TB_MEASUREMENT

--------------------------------------------------------


  CREATE TABLE "TB_MEASUREMENT" 
   (	"ANALYSIS_ID" VARCHAR2(20 BYTE), 
	"SEQ" NUMBER(*,0), 
	"TIME" DATE, 
	"TARGET1_CENTER_X" FLOAT(63), 
	"TARGET1_CENTER_Y" FLOAT(63), 
	"TARGET1_ANGLE_ONE" FLOAT(63), 
	"TARGET1_ANGLE_ZERO" FLOAT(63), 
	"TARGET1_ANGLE_EDGE" FLOAT(63), 
	"TARGET1_DIST_START" FLOAT(63), 
	"TARGET1_DIST_END" FLOAT(63), 
	"TARGET2_CENTER_X" FLOAT(63), 
	"TARGET2_CENTER_Y" FLOAT(63), 
	"TARGET2_ANGLE_ONE" FLOAT(63), 
	"TARGET2_ANGLE_ZERO" FLOAT(63), 
	"TARGET2_ANGLE_EDGE" FLOAT(63), 
	"TARGET2_DIST_START" FLOAT(63), 
	"TARGET2_DIST_END" FLOAT(63), 
	"SPEED" FLOAT(63), 
	"ARRIVAL_TIME_1AU" DATE, 
	"LON" FLOAT(63), 
	"LAT" FLOAT(63), 
	"HALF_WIDTH" FLOAT(63), 
	"TARGET1_SPEED" FLOAT(63), 
	"TARGET1_HALF_WIDTH" FLOAT(63), 
	"TARGET1_LAT" FLOAT(63), 
	"TARGET1_BOUNDARY_TIME" DATE, 
	"TARGET2_SPEED" FLOAT(63), 
	"TARGET2_HALF_WIDTH" FLOAT(63), 
	"TARGET2_LAT" FLOAT(63), 
	"TARGET2_BOUNDARY_TIME" DATE, 
	"ARRIVAL_TIME_21_5RS" DATE
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_PDS

--------------------------------------------------------


  CREATE TABLE "TB_PDS" 
   (	"ID" NUMBER, 
	"TITLE" VARCHAR2(4000 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"WRITER" VARCHAR2(20 BYTE), 
	"CREATE_DATE" DATE DEFAULT SYSDATE, 
	"HIT" NUMBER DEFAULT 0, 
	"FILENAME" VARCHAR2(255 BYTE), 
	"FILEPATH" VARCHAR2(255 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_PDS"."ID" IS '고유번호';
 
   COMMENT ON COLUMN "TB_PDS"."TITLE" IS '제목';
 
   COMMENT ON COLUMN "TB_PDS"."CONTENT" IS '내용';
 
   COMMENT ON COLUMN "TB_PDS"."WRITER" IS '작성자';
 
   COMMENT ON COLUMN "TB_PDS"."CREATE_DATE" IS '생성시간';
 
   COMMENT ON COLUMN "TB_PDS"."HIT" IS '조회수';
 
   COMMENT ON COLUMN "TB_PDS"."FILENAME" IS '첨부파일이름';
 
   COMMENT ON COLUMN "TB_PDS"."FILEPATH" IS '첨부파일경로';
 
   COMMENT ON TABLE "TB_PDS"  IS '자료실';
/
--------------------------------------------------------

--  DDL for Table TB_PROGRAM_LIST

--------------------------------------------------------


  CREATE TABLE "TB_PROGRAM_LIST" 
   (	"ID" NUMBER, 
	"NAME" VARCHAR2(255 BYTE), 
	"WRITEDATE" DATE DEFAULT SYSDATE, 
	"FILENAME" VARCHAR2(255 BYTE), 
	"FILEPATH" VARCHAR2(255 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_PROGRAM_LIST"."ID" IS '고유번호';
 
   COMMENT ON COLUMN "TB_PROGRAM_LIST"."NAME" IS '항목명';
 
   COMMENT ON COLUMN "TB_PROGRAM_LIST"."WRITEDATE" IS '작성시간';
 
   COMMENT ON COLUMN "TB_PROGRAM_LIST"."FILENAME" IS '첨부파일명';
 
   COMMENT ON COLUMN "TB_PROGRAM_LIST"."FILEPATH" IS '첨부파일경로';
 
   COMMENT ON TABLE "TB_PROGRAM_LIST"  IS 'CME 프로그램';
/
--------------------------------------------------------

--  DDL for Table TB_REPORT_LIST

--------------------------------------------------------


  CREATE TABLE "TB_REPORT_LIST" 
   (	"ID" NUMBER, 
	"TYPE" CHAR(1 CHAR), 
	"TITLE" VARCHAR2(255 BYTE), 
	"CONTENTS" CLOB, 
	"REMARK" VARCHAR2(4000 BYTE), 
	"FILEPATH1" VARCHAR2(255 BYTE), 
	"FILEPATH2" VARCHAR2(255 BYTE), 
	"WRITEDATE" DATE DEFAULT SYSDATE, 
	"SUBMITDATE" DATE, 
	"NOTICE1" CHAR(1 CHAR), 
	"NOTICE2" CHAR(1 CHAR), 
	"NOTICE3" CHAR(1 CHAR), 
	"FILENAME1" VARCHAR2(255 BYTE), 
	"FILENAME2" VARCHAR2(255 BYTE), 
	"PUBLISHDATE" DATE
   ) ;
 


   COMMENT ON COLUMN "TB_REPORT_LIST"."ID" IS '고유번호';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."TYPE" IS '보고 유형';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."TITLE" IS '제목';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."CONTENTS" IS '개요';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."REMARK" IS '특이사항';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."FILEPATH1" IS '상세정보 - 우주기상정보';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."FILEPATH2" IS '상세정보 - 지구자기권계면의 위치';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."WRITEDATE" IS '작성일시';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."SUBMITDATE" IS 'COMIS 전송일시';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."NOTICE1" IS '주의사항 - 기상위성운영';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."NOTICE2" IS '주의사항 - 극항로 항공기상';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."NOTICE3" IS '주의사항 - 전리권기상';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."FILENAME1" IS '우주기상정보 파일명';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."FILENAME2" IS '지구자기권계면 파일명';
 
   COMMENT ON COLUMN "TB_REPORT_LIST"."PUBLISHDATE" IS '발표일';
 
   COMMENT ON TABLE "TB_REPORT_LIST"  IS '예특보 목록';
/
--------------------------------------------------------

--  DDL for Table TB_SOLAR_MAXIMUM

--------------------------------------------------------


  CREATE TABLE "TB_SOLAR_MAXIMUM" 
   (	"TM" VARCHAR2(20 BYTE), 
	"FILEPATH" VARCHAR2(512 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_SOLAR_MAXIMUM"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_SOLAR_MAXIMUM"."FILEPATH" IS '파일경로';
 
   COMMENT ON TABLE "TB_SOLAR_MAXIMUM"  IS 'Solar Maximum';
/
--------------------------------------------------------

--  DDL for Table TB_SOLAR_PROTON_EVENT

--------------------------------------------------------


  CREATE TABLE "TB_SOLAR_PROTON_EVENT" 
   (	"START_DATE" DATE, 
	"STOP_DATE" DATE, 
	"PEAK_DATE" DATE, 
	"GCLS" VARCHAR2(20 BYTE), 
	"POSITION" VARCHAR2(20 BYTE), 
	"PROBAB" NUMBER, 
	"PKFLUX" NUMBER, 
	"ARR_TM" NUMBER, 
	"ARR_DATE" DATE, 
	"SPOT" NUMBER(11,0)
   ) ;
 


   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."START_DATE" IS 'Start Date';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."STOP_DATE" IS 'Stop Date';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."PEAK_DATE" IS 'Peak Date';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."GCLS" IS 'GCLS';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."POSITION" IS 'Position';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."PROBAB" IS 'Probab';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."PKFLUX" IS 'PKFLUX';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."ARR_TM" IS 'Arrival Time';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."ARR_DATE" IS 'Arrival Date';
 
   COMMENT ON COLUMN "TB_SOLAR_PROTON_EVENT"."SPOT" IS 'Spot';
 
   COMMENT ON TABLE "TB_SOLAR_PROTON_EVENT"  IS 'Solar Proton Event';
/
--------------------------------------------------------

--  DDL for Table TB_SPACECRAFT_DATA_CODE

--------------------------------------------------------


  CREATE TABLE "TB_SPACECRAFT_DATA_CODE" 
   (	"CODE" CHAR(10 BYTE), 
	"NAME" VARCHAR2(60 BYTE)
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_SPACECRAFT_INFO

--------------------------------------------------------


  CREATE TABLE "TB_SPACECRAFT_INFO" 
   (	"SC_CODE" CHAR(10 BYTE), 
	"SEQ" NUMBER(*,0), 
	"MODIFIED_DATE" DATE, 
	"APPROX_METER_SUN" FLOAT(63), 
	"FULL_RES" NUMBER(*,0), 
	"ARC_SEC_PIXEL" FLOAT(63), 
	"SUN_PT_X" FLOAT(63), 
	"SUN_PT_Y" FLOAT(63), 
	"SUN_PT_ROLLED_X" FLOAT(63), 
	"SUN_PT_ROLLED_Y" FLOAT(63), 
	"DISK_CENTER_X" FLOAT(63), 
	"DISK_CENTER_Y" FLOAT(63), 
	"DISK_CENTER_ROLLED_X" FLOAT(63), 
	"DISK_CENTER_ROLLED_Y" FLOAT(63), 
	"EDGE_CENTER_X" FLOAT(63), 
	"EDGE_CENTER_Y" FLOAT(63), 
	"EDGE_CENTER_ROLLED_X" FLOAT(63), 
	"EDGE_CENTER_ROLLED_Y" FLOAT(63), 
	"DISK_RADIUS" FLOAT(63), 
	"IMAGE_RADIUS" FLOAT(63)
   ) ;
/
--------------------------------------------------------

--  DDL for Table TB_STA_HET

--------------------------------------------------------


  CREATE TABLE "TB_STA_HET" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"PROTON_13_S" NUMBER(*,0), 
	"PROTON_13" NUMBER, 
	"PROTON_40_S" NUMBER(*,0), 
	"PROTON_40" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STA_HET"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STA_HET"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STA_HET"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STA_HET"."PROTON_13_S" IS '13-21 MeV Status';
 
   COMMENT ON COLUMN "TB_STA_HET"."PROTON_13" IS '13-21 MeV';
 
   COMMENT ON COLUMN "TB_STA_HET"."PROTON_40_S" IS '40-100 MeV Status';
 
   COMMENT ON COLUMN "TB_STA_HET"."PROTON_40" IS '40-100 MeV';
 
   COMMENT ON TABLE "TB_STA_HET"  IS 'STEREO A Satellite - High Energy Telescope';
/
--------------------------------------------------------

--  DDL for Table TB_STA_IMPACT

--------------------------------------------------------


  CREATE TABLE "TB_STA_IMPACT" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"ELEC_S" NUMBER(*,0), 
	"ELEC_36" NUMBER, 
	"ELEC_125" NUMBER, 
	"PROTON_S" NUMBER(*,0), 
	"PROTON_75" NUMBER, 
	"PROTON_137" NUMBER, 
	"PROTON_623" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STA_IMPACT"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."ELEC_S" IS 'Electron Status';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."ELEC_36" IS 'Electron 35-65';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."ELEC_125" IS 'Electron 125-255';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."PROTON_S" IS 'Protons Status';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."PROTON_75" IS 'Protons 75-137';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."PROTON_137" IS 'Protons 137-623';
 
   COMMENT ON COLUMN "TB_STA_IMPACT"."PROTON_623" IS 'Protons 623-2224';
 
   COMMENT ON TABLE "TB_STA_IMPACT"  IS 'STEREO A Satellite - In-situ Measurements of Particles and CME Transients';
/
--------------------------------------------------------

--  DDL for Table TB_STA_MAG

--------------------------------------------------------


  CREATE TABLE "TB_STA_MAG" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"BR" NUMBER, 
	"BT_L" NUMBER, 
	"BN" NUMBER, 
	"BT_S" NUMBER, 
	"LAT" NUMBER, 
	"LON" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STA_MAG"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STA_MAG"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STA_MAG"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STA_MAG"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_STA_MAG"."BR" IS 'RTN Coordinates - BR';
 
   COMMENT ON COLUMN "TB_STA_MAG"."BT_L" IS 'RTN Coordinates - BT';
 
   COMMENT ON COLUMN "TB_STA_MAG"."BN" IS 'RTN Coordinates - BN';
 
   COMMENT ON COLUMN "TB_STA_MAG"."BT_S" IS 'RTN Coordinates - Bt';
 
   COMMENT ON COLUMN "TB_STA_MAG"."LAT" IS 'RTN Coordinates - Lat.';
 
   COMMENT ON COLUMN "TB_STA_MAG"."LON" IS 'RTN Coordinates - Lon.';
 
   COMMENT ON TABLE "TB_STA_MAG"  IS 'STEREO A Satellite - Magnetometer';
/
--------------------------------------------------------

--  DDL for Table TB_STA_PLASTIC

--------------------------------------------------------


  CREATE TABLE "TB_STA_PLASTIC" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"PRO_DENS" NUMBER, 
	"BULK_SPD" NUMBER, 
	"ION_TEMP" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STA_PLASTIC"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."SECOFDAY" IS 'Seonds of the Day';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."PRO_DENS" IS 'Proton Density';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."BULK_SPD" IS 'Bulk Speed';
 
   COMMENT ON COLUMN "TB_STA_PLASTIC"."ION_TEMP" IS 'Ion Temperature';
 
   COMMENT ON TABLE "TB_STA_PLASTIC"  IS 'STEREO A Satellite - Plasma and Suprathermal Ion Composition';
/
--------------------------------------------------------

--  DDL for Table TB_STB_HET

--------------------------------------------------------


  CREATE TABLE "TB_STB_HET" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"PROTON_13_S" NUMBER(*,0), 
	"PROTON_13" NUMBER, 
	"PROTON_40_S" NUMBER(*,0), 
	"PROTON_40" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STB_HET"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STB_HET"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STB_HET"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STB_HET"."PROTON_13_S" IS '13-21 MeV Status';
 
   COMMENT ON COLUMN "TB_STB_HET"."PROTON_13" IS '13-21 MeV';
 
   COMMENT ON COLUMN "TB_STB_HET"."PROTON_40_S" IS '40-100 MeV Status';
 
   COMMENT ON COLUMN "TB_STB_HET"."PROTON_40" IS '40-100 MeV';
 
   COMMENT ON TABLE "TB_STB_HET"  IS 'STEREO B Satellite - High Energy Telescope';
/
--------------------------------------------------------

--  DDL for Table TB_STB_IMPACT

--------------------------------------------------------


  CREATE TABLE "TB_STB_IMPACT" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"ELEC_S" NUMBER(*,0), 
	"ELEC_36" NUMBER, 
	"ELEC_125" NUMBER, 
	"PROTON_S" NUMBER(*,0), 
	"PROTON_75" NUMBER, 
	"PROTON_137" NUMBER, 
	"PROTON_623" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STB_IMPACT"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."MJD" IS 'Modified Julan Day';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."ELEC_S" IS 'Electron Status';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."ELEC_36" IS 'Electron 35-65';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."ELEC_125" IS 'Electron 125-255';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."PROTON_S" IS 'Protons Status';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."PROTON_75" IS 'Protons 75-137';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."PROTON_137" IS 'Protons 137-623';
 
   COMMENT ON COLUMN "TB_STB_IMPACT"."PROTON_623" IS 'Protons 623-2224';
 
   COMMENT ON TABLE "TB_STB_IMPACT"  IS 'STEREO B Satellite - In-situ Measurements of Particles and CME Transients';
/
--------------------------------------------------------

--  DDL for Table TB_STB_MAG

--------------------------------------------------------


  CREATE TABLE "TB_STB_MAG" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"BR" NUMBER, 
	"BT_L" NUMBER, 
	"BN" NUMBER, 
	"BT_S" NUMBER, 
	"LAT" NUMBER, 
	"LON" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STB_MAG"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STB_MAG"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STB_MAG"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STB_MAG"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_STB_MAG"."BR" IS 'RTN Coordinates - BR';
 
   COMMENT ON COLUMN "TB_STB_MAG"."BT_L" IS 'RTN Coordinates - BT';
 
   COMMENT ON COLUMN "TB_STB_MAG"."BN" IS 'RTN Coordinates - BN';
 
   COMMENT ON COLUMN "TB_STB_MAG"."BT_S" IS 'RTN Coordinates - Bt';
 
   COMMENT ON COLUMN "TB_STB_MAG"."LAT" IS 'RTN Coordinates - Lat.';
 
   COMMENT ON COLUMN "TB_STB_MAG"."LON" IS 'RTN Coordinates - Lon.';
 
   COMMENT ON TABLE "TB_STB_MAG"  IS 'STEREO B Satellite - Magnetometer';
/
--------------------------------------------------------

--  DDL for Table TB_STB_PLASTIC

--------------------------------------------------------


  CREATE TABLE "TB_STB_PLASTIC" 
   (	"TM" VARCHAR2(20 BYTE), 
	"MJD" NUMBER(11,0), 
	"SECOFDAY" NUMBER(11,0), 
	"S" NUMBER(*,0), 
	"PRO_DENS" NUMBER, 
	"BULK_SPD" NUMBER, 
	"ION_TEMP" NUMBER
   ) ;
 


   COMMENT ON COLUMN "TB_STB_PLASTIC"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."MJD" IS 'Modified Julian Day';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."SECOFDAY" IS 'Seconds of the Day';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."S" IS 'Status';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."PRO_DENS" IS 'Proton Density';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."BULK_SPD" IS 'Bulk Speed';
 
   COMMENT ON COLUMN "TB_STB_PLASTIC"."ION_TEMP" IS 'Ion Temperature';
 
   COMMENT ON TABLE "TB_STB_PLASTIC"  IS 'STEREO B Satellite - Plasma and Suprathermal Ion Composition';
/
--------------------------------------------------------

--  DDL for Table TB_TEC

--------------------------------------------------------


  CREATE TABLE "TB_TEC" 
   (	"TM" VARCHAR2(20 BYTE), 
	"FILEPATH" VARCHAR2(512 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_TEC"."TM" IS 'Time(UTC)';
 
   COMMENT ON COLUMN "TB_TEC"."FILEPATH" IS '파일경로';
 
   COMMENT ON TABLE "TB_TEC"  IS 'TEC';
/
--------------------------------------------------------

--  DDL for Table TB_USER_GROUP

--------------------------------------------------------


  CREATE TABLE "TB_USER_GROUP" 
   (	"CODE" CHAR(2 BYTE), 
	"NAME" VARCHAR2(16 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_USER_GROUP"."CODE" IS '사용자 그룹 코드';
 
   COMMENT ON COLUMN "TB_USER_GROUP"."NAME" IS '사용자 그룹명';
 
   COMMENT ON TABLE "TB_USER_GROUP"  IS 'CME 그룹 목록';
/
--------------------------------------------------------

--  DDL for Table TB_USER_GROUP_CMD_FUNC

--------------------------------------------------------


  CREATE TABLE "TB_USER_GROUP_CMD_FUNC" 
   (	"GROUP_CODE" CHAR(2 BYTE), 
	"FUNC_CODE" CHAR(7 BYTE), 
	"ACCESS_CODE" CHAR(1 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_USER_GROUP_CMD_FUNC"."GROUP_CODE" IS '그룹 코드';
 
   COMMENT ON COLUMN "TB_USER_GROUP_CMD_FUNC"."FUNC_CODE" IS '기능 코드';
 
   COMMENT ON COLUMN "TB_USER_GROUP_CMD_FUNC"."ACCESS_CODE" IS '접근 코드
Y: 기능 사용 권한 있음
N: 기능 사용 권한 없음';
 
   COMMENT ON TABLE "TB_USER_GROUP_CMD_FUNC"  IS '사용자 그룹별 기능 관리';
/
--------------------------------------------------------

--  DDL for Table TB_USER_LIST

--------------------------------------------------------


  CREATE TABLE "TB_USER_LIST" 
   (	"USERID" VARCHAR2(20 BYTE), 
	"USERPWD" VARCHAR2(255 BYTE), 
	"NAME" VARCHAR2(20 BYTE), 
	"EMAIL" VARCHAR2(255 BYTE), 
	"ROLE" VARCHAR2(255 BYTE), 
	"PHONE" VARCHAR2(255 BYTE), 
	"DEPARTMENT" VARCHAR2(255 BYTE), 
	"POSITION" VARCHAR2(255 BYTE), 
	"GROUP_CODE" CHAR(2 BYTE)
   ) ;
 


   COMMENT ON COLUMN "TB_USER_LIST"."USERID" IS '아이디';
 
   COMMENT ON COLUMN "TB_USER_LIST"."USERPWD" IS '비밀번호';
 
   COMMENT ON COLUMN "TB_USER_LIST"."NAME" IS '이름';
 
   COMMENT ON COLUMN "TB_USER_LIST"."EMAIL" IS '이메일';
 
   COMMENT ON COLUMN "TB_USER_LIST"."ROLE" IS '웹 권한';
 
   COMMENT ON COLUMN "TB_USER_LIST"."PHONE" IS '전화번호';
 
   COMMENT ON COLUMN "TB_USER_LIST"."DEPARTMENT" IS '부서';
 
   COMMENT ON COLUMN "TB_USER_LIST"."POSITION" IS '직위';
 
   COMMENT ON COLUMN "TB_USER_LIST"."GROUP_CODE" IS 'CME 그룹';
 
   COMMENT ON TABLE "TB_USER_LIST"  IS '사용자 목록';
/
--------------------------------------------------------

--  DDL for Index TB_IMAGE_META

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_IMAGE_META" ON "TB_IMAGE_META" ("ID") 
  ;
/
--------------------------------------------------------

--  DDL for Index IDX_TB_ANALYSIS_RESULT_SC

--------------------------------------------------------


  CREATE INDEX "IDX_TB_ANALYSIS_RESULT_SC" ON "TB_ANALYSIS_RESULT" (CASE  WHEN "RSLT_SPEED_AVG"<500000 THEN 'S' WHEN ("RSLT_SPEED_AVG">=500000 AND "RSLT_SPEED_AVG"<1000000) THEN 'C' WHEN ("RSLT_SPEED_AVG">=1000000 AND "RSLT_SPEED_AVG"<2000000) THEN 'O' WHEN ("RSLT_SPEED_AVG">=2000000 AND "RSLT_SPEED_AVG"<3000000) THEN 'R' WHEN "RSLT_SPEED_AVG">=3000000 THEN 'ER' END ) 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_ACE_EPAM_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_ACE_EPAM_PK" ON "TB_ACE_EPAM" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_SOLAR_MAXIMUM_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_SOLAR_MAXIMUM_PK" ON "TB_SOLAR_MAXIMUM" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_MAGNETOPAUSE_RADIUS_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_MAGNETOPAUSE_RADIUS_PK" ON "TB_MAGNETOPAUSE_RADIUS" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_DST_INDEX_KHU_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_DST_INDEX_KHU_PK" ON "TB_DST_INDEX_KHU" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_REPORT_LIST_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_REPORT_LIST_PK" ON "TB_REPORT_LIST" ("ID") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_TEC_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_TEC_PK" ON "TB_TEC" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_SOLAR_PROTON_EVENT_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_SOLAR_PROTON_EVENT_PK" ON "TB_SOLAR_PROTON_EVENT" ("START_DATE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STB_PLASTIC_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STB_PLASTIC_PK" ON "TB_STB_PLASTIC" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index IDX_TB_IMAGE_META_1

--------------------------------------------------------


  CREATE INDEX "IDX_TB_IMAGE_META_1" ON "TB_IMAGE_META" ("CREATEDATE", "CODE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_ACE_MAG_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_ACE_MAG_PK" ON "TB_ACE_MAG" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_PROGRAM_LIST_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_PROGRAM_LIST_PK" ON "TB_PROGRAM_LIST" ("ID") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_PARTICLE_P_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_PARTICLE_P_PK" ON "TB_GOES_PARTICLE_P" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STB_HET_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STB_HET_PK" ON "TB_STB_HET" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STA_IMPACT_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STA_IMPACT_PK" ON "TB_STA_IMPACT" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STA_MAG_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STA_MAG_PK" ON "TB_STA_MAG" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_FLARE_PREDICATION_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_FLARE_PREDICATION_PK" ON "TB_FLARE_PREDICATION" ("CREATE_DATE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STB_IMPACT_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STB_IMPACT_PK" ON "TB_STB_IMPACT" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_USER_GROUP_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_USER_GROUP_PK" ON "TB_USER_GROUP" ("CODE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_USER_GROUP_CMD_FUNC_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_USER_GROUP_CMD_FUNC_PK" ON "TB_USER_GROUP_CMD_FUNC" ("GROUP_CODE", "FUNC_CODE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_KP_INDEX_KHU_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_KP_INDEX_KHU_PK" ON "TB_KP_INDEX_KHU" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_XRAY_5M_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_XRAY_5M_PK" ON "TB_GOES_XRAY_5M" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_KP_INDEX_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_KP_INDEX_PK" ON "TB_KP_INDEX" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STB_MAG_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STB_MAG_PK" ON "TB_STB_MAG" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_FLARE_PREDICATION_DETAIL_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_FLARE_PREDICATION_DETAIL_PK" ON "TB_FLARE_PREDICATION_DETAIL" ("ID") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_ACE_SWEPAM_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_ACE_SWEPAM_PK" ON "TB_ACE_SWEPAM" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STA_HET_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STA_HET_PK" ON "TB_STA_HET" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_STA_PLASTIC_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_STA_PLASTIC_PK" ON "TB_STA_PLASTIC" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_PARTICLE_S_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_PARTICLE_S_PK" ON "TB_GOES_PARTICLE_S" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_XRAY_1M_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_XRAY_1M_PK" ON "TB_GOES_XRAY_1M" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_DST_INDEX

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_DST_INDEX" ON "TB_DST_INDEX" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_MAG_S_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_MAG_S_PK" ON "TB_GOES_MAG_S" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_PDS_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_PDS_PK" ON "TB_PDS" ("ID") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_ACE_SIS_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_ACE_SIS_PK" ON "TB_ACE_SIS" ("TM") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_USER_LIST_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_USER_LIST_PK" ON "TB_USER_LIST" ("USERID") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_SPACECRAFT_DATA_CODE_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_SPACECRAFT_DATA_CODE_PK" ON "TB_SPACECRAFT_DATA_CODE" ("CODE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_CME_FUNC_LIST_PKEY

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_CME_FUNC_LIST_PKEY" ON "TB_CME_FUNC_LIST" ("CODE") 
  ;
/
--------------------------------------------------------

--  DDL for Index TB_GOES_MAG_P_PK

--------------------------------------------------------


  CREATE UNIQUE INDEX "TB_GOES_MAG_P_PK" ON "TB_GOES_MAG_P" ("TM") 
  ;
/
--------------------------------------------------------

--  Constraints for Table TB_SOLAR_PROTON_EVENT

--------------------------------------------------------


  ALTER TABLE "TB_SOLAR_PROTON_EVENT" ADD CONSTRAINT "TB_SOLAR_PROTON_EVENT_PK" PRIMARY KEY ("START_DATE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STA_IMPACT

--------------------------------------------------------


  ALTER TABLE "TB_STA_IMPACT" ADD CONSTRAINT "TB_STA_IMPACT_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_XRAY_1M

--------------------------------------------------------


  ALTER TABLE "TB_GOES_XRAY_1M" ADD CONSTRAINT "TB_GOES_XRAY_1M_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_CME_FUNC_LIST

--------------------------------------------------------


  ALTER TABLE "TB_CME_FUNC_LIST" MODIFY ("CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_CME_FUNC_LIST" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "TB_CME_FUNC_LIST" ADD CONSTRAINT "TB_CME_FUNC_LIST_PK" PRIMARY KEY ("CODE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_KP_INDEX_KHU

--------------------------------------------------------


  ALTER TABLE "TB_KP_INDEX_KHU" ADD CONSTRAINT "TB_KP_INDEX_KHU_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_SPACECRAFT_DATA_CODE

--------------------------------------------------------


  ALTER TABLE "TB_SPACECRAFT_DATA_CODE" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "TB_SPACECRAFT_DATA_CODE" MODIFY ("CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_SPACECRAFT_DATA_CODE" ADD CONSTRAINT "TB_SPACECRAFT_DATA_CODE_PK" PRIMARY KEY ("CODE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STB_PLASTIC

--------------------------------------------------------


  ALTER TABLE "TB_STB_PLASTIC" ADD CONSTRAINT "TB_STB_PLASTIC_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_USER_GROUP

--------------------------------------------------------


  ALTER TABLE "TB_USER_GROUP" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_GROUP" ADD CONSTRAINT "TB_USER_GROUP_PK" PRIMARY KEY ("CODE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_TEC

--------------------------------------------------------


  ALTER TABLE "TB_TEC" MODIFY ("FILEPATH" NOT NULL ENABLE);
 
  ALTER TABLE "TB_TEC" ADD CONSTRAINT "TB_TEC_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STA_MAG

--------------------------------------------------------


  ALTER TABLE "TB_STA_MAG" ADD CONSTRAINT "TB_STA_MAG_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_FLARE_PREDICATION

--------------------------------------------------------


  ALTER TABLE "TB_FLARE_PREDICATION" ADD CONSTRAINT "TB_FLARE_PREDICATION_PK" PRIMARY KEY ("CREATE_DATE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_MAG_S

--------------------------------------------------------


  ALTER TABLE "TB_GOES_MAG_S" ADD CONSTRAINT "TB_GOES_MAG_S_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_ACE_EPAM

--------------------------------------------------------


  ALTER TABLE "TB_ACE_EPAM" ADD CONSTRAINT "TB_ACE_EPAM_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_USER_LIST

--------------------------------------------------------


  ALTER TABLE "TB_USER_LIST" MODIFY ("USERPWD" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_LIST" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_LIST" MODIFY ("ROLE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_LIST" MODIFY ("GROUP_CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_LIST" ADD CONSTRAINT "TB_USER_LIST_PK" PRIMARY KEY ("USERID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_PDS

--------------------------------------------------------


  ALTER TABLE "TB_PDS" MODIFY ("CREATE_DATE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_PDS" MODIFY ("HIT" NOT NULL ENABLE);
 
  ALTER TABLE "TB_PDS" ADD CONSTRAINT "TB_PDS_PK" PRIMARY KEY ("ID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_ACE_SIS

--------------------------------------------------------


  ALTER TABLE "TB_ACE_SIS" ADD CONSTRAINT "TB_ACE_SIS_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_USER_GROUP_CMD_FUNC

--------------------------------------------------------


  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" MODIFY ("GROUP_CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" MODIFY ("FUNC_CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" MODIFY ("ACCESS_CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" ADD CONSTRAINT "TB_USER_GROUP_CMD_FUNC_PK" PRIMARY KEY ("GROUP_CODE", "FUNC_CODE") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STA_PLASTIC

--------------------------------------------------------


  ALTER TABLE "TB_STA_PLASTIC" ADD CONSTRAINT "TB_STA_PLASTIC_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STA_HET

--------------------------------------------------------


  ALTER TABLE "TB_STA_HET" ADD CONSTRAINT "TB_STA_HET_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_DST_INDEX

--------------------------------------------------------


  ALTER TABLE "TB_DST_INDEX" ADD CONSTRAINT "TB_DST_INDEX" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_SOLAR_MAXIMUM

--------------------------------------------------------


  ALTER TABLE "TB_SOLAR_MAXIMUM" MODIFY ("FILEPATH" NOT NULL ENABLE);
 
  ALTER TABLE "TB_SOLAR_MAXIMUM" ADD CONSTRAINT "TB_SOLAR_MAXIMUM_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_IMAGE_META

--------------------------------------------------------


  ALTER TABLE "TB_IMAGE_META" MODIFY ("CODE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_IMAGE_META" MODIFY ("CREATEDATE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_IMAGE_META" MODIFY ("FILEPATH" NOT NULL ENABLE);
 
  ALTER TABLE "TB_IMAGE_META" ADD CONSTRAINT "TB_IMAGE_META" PRIMARY KEY ("ID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_PROGRAM_LIST

--------------------------------------------------------


  ALTER TABLE "TB_PROGRAM_LIST" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "TB_PROGRAM_LIST" MODIFY ("WRITEDATE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_PROGRAM_LIST" ADD CONSTRAINT "TB_PROGRAM_LIST_PK" PRIMARY KEY ("ID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_REPORT_LIST

--------------------------------------------------------


  ALTER TABLE "TB_REPORT_LIST" MODIFY ("TYPE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_REPORT_LIST" MODIFY ("TITLE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_REPORT_LIST" MODIFY ("WRITEDATE" NOT NULL ENABLE);
 
  ALTER TABLE "TB_REPORT_LIST" ADD CONSTRAINT "TB_REPORT_LIST_PK" PRIMARY KEY ("ID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_PARTICLE_S

--------------------------------------------------------


  ALTER TABLE "TB_GOES_PARTICLE_S" ADD CONSTRAINT "TB_GOES_PARTICLE_S_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STB_MAG

--------------------------------------------------------


  ALTER TABLE "TB_STB_MAG" ADD CONSTRAINT "TB_STB_MAG_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_FLARE_PREDICATION_DETAIL

--------------------------------------------------------


  ALTER TABLE "TB_FLARE_PREDICATION_DETAIL" ADD CONSTRAINT "TB_FLARE_PREDICATION_DETAIL_PK" PRIMARY KEY ("ID") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_MAG_P

--------------------------------------------------------


  ALTER TABLE "TB_GOES_MAG_P" ADD CONSTRAINT "TB_GOES_MAG_P_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_XRAY_5M

--------------------------------------------------------


  ALTER TABLE "TB_GOES_XRAY_5M" ADD CONSTRAINT "TB_GOES_XRAY_5M_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STB_IMPACT

--------------------------------------------------------


  ALTER TABLE "TB_STB_IMPACT" ADD CONSTRAINT "TB_STB_IMPACT_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_ACE_SWEPAM

--------------------------------------------------------


  ALTER TABLE "TB_ACE_SWEPAM" ADD CONSTRAINT "TB_ACE_SWEPAM_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_STB_HET

--------------------------------------------------------


  ALTER TABLE "TB_STB_HET" ADD CONSTRAINT "TB_STB_HET_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_MAGNETOPAUSE_RADIUS

--------------------------------------------------------


  ALTER TABLE "TB_MAGNETOPAUSE_RADIUS" ADD CONSTRAINT "TB_MAGNETOPAUSE_RADIUS_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_KP_INDEX

--------------------------------------------------------


  ALTER TABLE "TB_KP_INDEX" ADD CONSTRAINT "TB_KP_INDEX_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_DST_INDEX_KHU

--------------------------------------------------------


  ALTER TABLE "TB_DST_INDEX_KHU" ADD CONSTRAINT "TB_DST_INDEX_KHU_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_GOES_PARTICLE_P

--------------------------------------------------------


  ALTER TABLE "TB_GOES_PARTICLE_P" ADD CONSTRAINT "TB_GOES_PARTICLE_P_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Constraints for Table TB_ACE_MAG

--------------------------------------------------------


  ALTER TABLE "TB_ACE_MAG" ADD CONSTRAINT "TB_ACE_MAG_PK" PRIMARY KEY ("TM") ENABLE;
/
--------------------------------------------------------

--  Ref Constraints for Table TB_USER_GROUP_CMD_FUNC

--------------------------------------------------------


  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" ADD CONSTRAINT "TB_USER_GROUP_CMD_FUNC_TB_FK1" FOREIGN KEY ("FUNC_CODE")
	  REFERENCES "TB_CME_FUNC_LIST" ("CODE") ENABLE;
 
  ALTER TABLE "TB_USER_GROUP_CMD_FUNC" ADD CONSTRAINT "TB_USER_GROUP_CMD_FUNC_US_FK1" FOREIGN KEY ("GROUP_CODE")
	  REFERENCES "TB_USER_GROUP" ("CODE") ENABLE;
/
--------------------------------------------------------

--  Ref Constraints for Table TB_USER_LIST

--------------------------------------------------------


  ALTER TABLE "TB_USER_LIST" ADD CONSTRAINT "TB_USER_LIST_USER_GROUP_FK" FOREIGN KEY ("GROUP_CODE")
	  REFERENCES "TB_USER_GROUP" ("CODE") ENABLE;
/
--------------------------------------------------------

--  DDL for Trigger TR_TB_FLARE_PREDICATION_DETAIL

--------------------------------------------------------


  CREATE OR REPLACE TRIGGER "TR_TB_FLARE_PREDICATION_DETAIL" BEFORE INSERT ON TB_FLARE_PREDICATION_DETAIL FOR EACH ROW
BEGIN
	SELECT SEQ_TB_FLARE_PREDIC_DETAIL.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/
ALTER TRIGGER "TR_TB_FLARE_PREDICATION_DETAIL" ENABLE;
/
--------------------------------------------------------

--  DDL for Trigger TR_TB_IMAGE_META

--------------------------------------------------------


  CREATE OR REPLACE TRIGGER "TR_TB_IMAGE_META" BEFORE INSERT ON TB_IMAGE_META FOR EACH ROW
BEGIN
	SELECT SEQ_TB_IMAGE_META.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/
ALTER TRIGGER "TR_TB_IMAGE_META" ENABLE;
/
--------------------------------------------------------

--  DDL for Trigger TR_TB_PDS

--------------------------------------------------------


  CREATE OR REPLACE TRIGGER "TR_TB_PDS" BEFORE INSERT ON TB_PDS FOR EACH ROW
BEGIN
	SELECT SEQ_TB_PDS.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
   
/
ALTER TRIGGER "TR_TB_PDS" ENABLE;
/
--------------------------------------------------------

--  DDL for Trigger TR_TB_PROGRAM_LIST

--------------------------------------------------------


  CREATE OR REPLACE TRIGGER "TR_TB_PROGRAM_LIST" BEFORE INSERT ON TB_PROGRAM_LIST FOR EACH ROW
BEGIN
	SELECT SEQ_TB_PROGRAM_LIST.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/
ALTER TRIGGER "TR_TB_PROGRAM_LIST" ENABLE;
/
--------------------------------------------------------

--  DDL for Trigger TR_TB_REPORT_LIST

--------------------------------------------------------


  CREATE OR REPLACE TRIGGER "TR_TB_REPORT_LIST" BEFORE INSERT ON TB_REPORT_LIST FOR EACH ROW
BEGIN
	SELECT SEQ_TB_REPORT_LIST.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/
ALTER TRIGGER "TR_TB_REPORT_LIST" ENABLE;
/



--------------------------------------------------------
--  DDL for Table TB_FORECAST_REPORT
--------------------------------------------------------
  CREATE TABLE "SWPC"."TB_FORECAST_REPORT" 
   (	"ID" NUMBER PRIMARY KEY, 
	"TYPE" VARCHAR2(100 BYTE) NOT NULL, 
	"TITLE" VARCHAR2(255 BYTE) NOT NULL, 
	"CONTENTS" VARCHAR2(4000 BYTE), 
	"REMARK" VARCHAR2(4000 BYTE), 
	"WRITEDATE" DATE DEFAULT SYSDATE NOT NULL, 
	"SUBMITDATE" DATE, 
	"PUBLISHDATE" DATE NOT NULL, 
	"PUBLISHSEQ" NUMBER DEFAULT 0 NOT NULL, 
	"WRITER" VARCHAR2(50 BYTE), 
	"NOT1DESC" VARCHAR2(255 BYTE), 
	"NOT1TYPE" VARCHAR2(100 BYTE), 
	"NOT1PUBLISH" VARCHAR2(100 BYTE), 
	"NOT1FINISH" VARCHAR2(100 BYTE), 
	"NOT1TARGET" VARCHAR2(100 BYTE),
	"NOT1PROBABILITY1" NUMBER, 
	"NOT1PROBABILITY2" NUMBER, 
	"NOT1MAXVALUE1" NUMBER, 
	"NOT1MAXVALUE2" NUMBER, 
	"NOT1MAXVALUE3" NUMBER, 
	
	"NOT2DESC" VARCHAR2(255 BYTE), 
	"NOT2TYPE" VARCHAR2(100 BYTE), 
	"NOT2PUBLISH" VARCHAR2(100 BYTE), 
	"NOT2FINISH" VARCHAR2(100 BYTE), 
	"NOT2TARGET" VARCHAR2(100 BYTE), 
	"NOT2PROBABILITY1" NUMBER, 
	"NOT2PROBABILITY2" NUMBER, 
	"NOT2MAXVALUE1" NUMBER, 
	"NOT2MAXVALUE2" NUMBER, 
	"NOT2MAXVALUE3" NUMBER, 

	"NOT3DESC" VARCHAR2(255 BYTE), 
	"NOT3TYPE" VARCHAR2(100 BYTE), 
	"NOT3PUBLISH" VARCHAR2(100 BYTE), 
	"NOT3FINISH" VARCHAR2(100 BYTE), 
	"NOT3TARGET" VARCHAR2(100 BYTE), 
	"NOT3PROBABILITY1" NUMBER, 
	"NOT3PROBABILITY2" NUMBER,
	"NOT3MAXVALUE1" NUMBER, 
	"NOT3MAXVALUE2" NUMBER, 
	"NOT3MAXVALUE3" NUMBER, 

	"FILENAME1" VARCHAR2(255 BYTE), 
	"FILEPATH1" VARCHAR2(255 BYTE), 
	"FILETITLE1" VARCHAR2(255 BYTE),
	"FILENAME2" VARCHAR2(255 BYTE),
	"FILEPATH2" VARCHAR2(255 BYTE),
	"FILETITLE2" VARCHAR2(255 BYTE),
	"XRAY" NUMBER, 
	"PROTON" NUMBER, 
	"KP" NUMBER, 
	"MP" NUMBER
   );

   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."ID" IS '고유번호';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."TYPE" IS '보고 유형';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."TITLE" IS '제목';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."CONTENTS" IS '개요';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."REMARK" IS '특이사항';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."WRITEDATE" IS '작성일시';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."SUBMITDATE" IS 'COMIS 전송일시';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."PUBLISHDATE" IS '발표일';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILENAME1" IS '첨부파일명';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILEPATH1" IS '저장 경로';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILETITLE1" IS '파일 체목';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILENAME2" IS '첨부파일명';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILEPATH2" IS '저장 경로';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."FILETITLE2" IS '파일 체목';
   
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1DESC" IS '기상위성운영 - 주의사항';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1TYPE" IS '기상위성운영 - 특보종류';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1PUBLISH" IS '기상위성운영 - 특보발표시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1FINISH" IS '기상위성운영 - 특보종료시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1TARGET" IS '기상위성운영 - 특보대상';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1PROBABILITY1" IS '기상위성운영 - 내일 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1PROBABILITY2" IS '기상위성운영 - 모레 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1MAXVALUE1" IS '기상위성운영 - 오늘 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1MAXVALUE2" IS '기상위성운영 - 어제 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT1MAXVALUE3" IS '기상위성운영 - 그저께 최대값';

   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2DESC" IS '극항로 항공기상 - 주의사항';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2TYPE" IS '극항로 항공기상 - 특보종류';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2PUBLISH" IS '극항로 항공기상 - 특보발표시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2FINISH" IS '극항로 항공기상 - 특보종료시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2TARGET" IS '극항로 항공기상 - 특보대상';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2PROBABILITY1" IS '극항로 항공기상 - 내일 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2PROBABILITY2" IS '극항로 항공기상 - 모레 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2MAXVALUE1" IS '극항로 항공기상 - 오늘 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2MAXVALUE2" IS '극항로 항공기상 - 어제 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT2MAXVALUE3" IS '극항로 항공기상 - 그저께 최대값';

   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3DESC" IS '주의사항 - 전리권기상';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3TYPE" IS '전리권기상 - 특보종류';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3PUBLISH" IS '전리권기상 - 특보발표시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3FINISH" IS '전리권기상 - 특보종료시각';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3TARGET" IS '전리권기상 - 특보대상';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3PROBABILITY1" IS '전리권기상 - 내일 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3PROBABILITY2" IS '전리권기상 - 모레 예보확률';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3MAXVALUE1" IS '전리권기상 - 오늘 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3MAXVALUE2" IS '전리권기상 - 어제 최대값';
   COMMENT ON COLUMN "SWPC"."TB_FORECAST_REPORT"."NOT3MAXVALUE3" IS '전리권기상 - 그저께 최대값';
   COMMENT ON TABLE "SWPC"."TB_FORECAST_REPORT"  IS '예특보 목록';


  CREATE OR REPLACE TRIGGER "SWPC"."TR_TB_FORECAST_REPORT" BEFORE INSERT ON TB_FORECAST_REPORT FOR EACH ROW
BEGIN
	SELECT SEQ_TB_FORECAST_REPORT.NEXTVAL INTO :NEW.ID FROM DUAL;
END;