package com.gaia3d.web.dto;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import com.gaia3d.web.controller.ReportController.ForecastReportType;


public class ForecastReportDTO implements Serializable {
	
	private static final long serialVersionUID = -6528317959001074331L;

	private Integer rpt_seq_n;

	@NotNull
	private ForecastReportType rpt_type;
	
	@NotBlank
	private String title;
	
	private String contents;
	private String rmk1;
	private String rmk2;
	
	private String info1;
	private String info2;
	private String info3;
	private String info4;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date write_dt;
	
	private String writer;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date publish_dt;
	private int publish_seq_n;

	private Date submit_dt;
	
	private String file_nm1;
	private String file_path1;
	private String file_title1;
	
	private String file_nm2;
	private String file_path2;
	private String file_title2;
	
	private String file_nm3;
	private String file_path3;
	private String file_title3;
	
	
	private String[] not1_desc;
	private String not1_type;
	private String not1_publish;
	private String not1_finish;
	private String not1_tar;
	private Double not1_probability1;
	private Double not1_probability2;
	private Double not1_max_val1;
	private Double not1_max_val2;
	private Double not1_max_val3;
	
	private String[] not2_desc;
	private String not2_type;
	private String not2_publish;
	private String not2_finish;
	private String not2_tar;
	private Double not2_probability1;
	private Double not2_probability2;
	private Double not2_max_val1;
	private Double not2_max_val2;
	private Double not2_max_val3;
	
	private String[] not3_desc;
	private String not3_type;
	private String not3_publish;
	private String not3_finish;
	private String not3_tar;
	private Double not3_probability1;
	private Double not3_probability2;
	private Double not3_max_val1;
	private Double not3_max_val2;
	private Double not3_max_val3;
	
	private Double xray;
	private Double proton;
	private Double kp;
	private Double mp;
	
	private String xray_tm;
	private String proton_tm;
	private String kp_tm;
	private String mp_tm;
	
	//신/구 통보문 Type O : 구통보문, N : 신통보문
	private String rpt_kind;
	
	private String rpt_file_path;
	private String rpt_file_nm;
	private String rpt_file_org_nm;
	private String wrn_flag;
	private String user_seq_n;
	private String user_nm;
	
	
	public String getUser_seq_n() {
		return user_seq_n;
	}
	public void setUser_seq_n(String user_seq_n) {
		this.user_seq_n = user_seq_n;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public Integer getRpt_seq_n() {
		return rpt_seq_n;
	}
	public void setRpt_seq_n(Integer rpt_seq_n) {
		this.rpt_seq_n = rpt_seq_n;
	}
	public ForecastReportType getRpt_type() {
		return rpt_type;
	}
	public void setRpt_type(ForecastReportType rpt_type) {
		this.rpt_type = rpt_type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getRmk1() {
		return rmk1;
	}
	public void setRmk1(String rmk1) {
		this.rmk1 = rmk1;
	}
	public String getRmk2() {
		return rmk2;
	}
	public void setRmk2(String rmk2) {
		this.rmk2 = rmk2;
	}
	public String getInfo1() {
		return info1;
	}
	public void setInfo1(String info1) {
		this.info1 = info1;
	}
	public String getInfo2() {
		return info2;
	}
	public void setInfo2(String info2) {
		this.info2 = info2;
	}
	public String getInfo3() {
		return info3;
	}
	public void setInfo3(String info3) {
		this.info3 = info3;
	}
	public String getInfo4() {
		return info4;
	}
	public void setInfo4(String info4) {
		this.info4 = info4;
	}
	public Date getWrite_dt() {
		return write_dt;
	}
	public void setWrite_dt(Date write_dt) {
		this.write_dt = write_dt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getPublish_dt() {
		return publish_dt;
	}
	public void setPublish_dt(Date publish_dt) {
		this.publish_dt = publish_dt;
	}
	public int getPublish_seq_n() {
		return publish_seq_n;
	}
	public void setPublish_seq_n(int publish_seq_n) {
		this.publish_seq_n = publish_seq_n;
	}
	public Date getSubmit_dt() {
		return submit_dt;
	}
	public void setSubmit_dt(Date submit_dt) {
		this.submit_dt = submit_dt;
	}
	public String getFile_nm1() {
		return file_nm1;
	}
	public void setFile_nm1(String file_nm1) {
		this.file_nm1 = file_nm1;
	}
	public String getFile_path1() {
		return file_path1;
	}
	public void setFile_path1(String file_path1) {
		this.file_path1 = file_path1;
	}
	public String getFile_title1() {
		return file_title1;
	}
	public void setFile_title1(String file_title1) {
		this.file_title1 = file_title1;
	}
	public String getFile_nm2() {
		return file_nm2;
	}
	public void setFile_nm2(String file_nm2) {
		this.file_nm2 = file_nm2;
	}
	public String getFile_path2() {
		return file_path2;
	}
	public void setFile_path2(String file_path2) {
		this.file_path2 = file_path2;
	}
	public String getFile_title2() {
		return file_title2;
	}
	public void setFile_title2(String file_title2) {
		this.file_title2 = file_title2;
	}
	public String getFile_nm3() {
		return file_nm3;
	}
	public void setFile_nm3(String file_nm3) {
		this.file_nm3 = file_nm3;
	}
	public String getFile_path3() {
		return file_path3;
	}
	public void setFile_path3(String file_path3) {
		this.file_path3 = file_path3;
	}
	public String getFile_title3() {
		return file_title3;
	}
	public void setFile_title3(String file_title3) {
		this.file_title3 = file_title3;
	}
	public String[] getNot1_desc() {
		return not1_desc;
	}
	public void setNot1_desc(String[] not1_desc) {
		this.not1_desc = not1_desc;
	}
	public String getNot1_type() {
		return not1_type;
	}
	public void setNot1_type(String not1_type) {
		this.not1_type = not1_type;
	}
	public String getNot1_publish() {
		return not1_publish;
	}
	public void setNot1_publish(String not1_publish) {
		this.not1_publish = not1_publish;
	}
	public String getNot1_finish() {
		return not1_finish;
	}
	public void setNot1_finish(String not1_finish) {
		this.not1_finish = not1_finish;
	}
	public String getNot1_tar() {
		return not1_tar;
	}
	public void setNot1_tar(String not1_tar) {
		this.not1_tar = not1_tar;
	}
	public Double getNot1_probability1() {
		return not1_probability1!= null?not1_probability1:0;
	}
	public void setNot1_probability1(Double not1_probability1) {
		this.not1_probability1 = not1_probability1;
	}
	public Double getNot1_probability2() {
		return not1_probability2!= null?not1_probability2:0;
	}
	public void setNot1_probability2(Double not1_probability2) {
		this.not1_probability2 = not1_probability2;
	}
	public Double getNot1_max_val1() {
		return not1_max_val1;
	}
	public void setNot1_max_val1(Double not1_max_val1) {
		this.not1_max_val1 = not1_max_val1;
	}
	public Double getNot1_max_val2() {
		return not1_max_val2;
	}
	public void setNot1_max_val2(Double not1_max_val2) {
		this.not1_max_val2 = not1_max_val2;
	}
	public Double getNot1_max_val3() {
		return not1_max_val3;
	}
	public void setNot1_max_val3(Double not1_max_val3) {
		this.not1_max_val3 = not1_max_val3;
	}
	public String[] getNot2_desc() {
		return not2_desc;
	}
	public void setNot2_desc(String[] not2_desc) {
		this.not2_desc = not2_desc;
	}
	public String getNot2_type() {
		return not2_type;
	}
	public void setNot2_type(String not2_type) {
		this.not2_type = not2_type;
	}
	public String getNot2_publish() {
		return not2_publish;
	}
	public void setNot2_publish(String not2_publish) {
		this.not2_publish = not2_publish;
	}
	public String getNot2_finish() {
		return not2_finish;
	}
	public void setNot2_finish(String not2_finish) {
		this.not2_finish = not2_finish;
	}
	public String getNot2_tar() {
		return not2_tar;
	}
	public void setNot2_tar(String not2_tar) {
		this.not2_tar = not2_tar;
	}
	public Double getNot2_probability1() {
		return not2_probability1!= null?not2_probability1:0;
	}
	public void setNot2_probability1(Double not2_probability1) {
		this.not2_probability1 = not2_probability1;
	}
	public Double getNot2_probability2() {
		return not2_probability2!= null?not2_probability2:0;
	}
	public void setNot2_probability2(Double not2_probability2) {
		this.not2_probability2 = not2_probability2;
	}
	public Double getNot2_max_val1() {
		return not2_max_val1;
	}
	public void setNot2_max_val1(Double not2_max_val1) {
		this.not2_max_val1 = not2_max_val1;
	}
	public Double getNot2_max_val2() {
		return not2_max_val2;
	}
	public void setNot2_max_val2(Double not2_max_val2) {
		this.not2_max_val2 = not2_max_val2;
	}
	public Double getNot2_max_val3() {
		return not2_max_val3;
	}
	public void setNot2_max_val3(Double not2_max_val3) {
		this.not2_max_val3 = not2_max_val3;
	}
	public String[] getNot3_desc() {
		return not3_desc;
	}
	public void setNot3_desc(String[] not3_desc) {
		this.not3_desc = not3_desc;
	}
	public String getNot3_type() {
		return not3_type;
	}
	public void setNot3_type(String not3_type) {
		this.not3_type = not3_type;
	}
	public String getNot3_publish() {
		return not3_publish;
	}
	public void setNot3_publish(String not3_publish) {
		this.not3_publish = not3_publish;
	}
	public String getNot3_finish() {
		return not3_finish;
	}
	public void setNot3_finish(String not3_finish) {
		this.not3_finish = not3_finish;
	}
	public String getNot3_tar() {
		return not3_tar;
	}
	public void setNot3_tar(String not3_tar) {
		this.not3_tar = not3_tar;
	}
	public Double getNot3_probability1() {
		return not3_probability1!= null?not3_probability1:0;
	}
	public void setNot3_probability1(Double not3_probability1) {
		this.not3_probability1 = not3_probability1;
	}
	public Double getNot3_probability2() {
		return not3_probability2!= null?not3_probability2:0;
	}
	public void setNot3_probability2(Double not3_probability2) {
		this.not3_probability2 = not3_probability2;
	}
	public Double getNot3_max_val1() {
		return not3_max_val1;
	}
	public void setNot3_max_val1(Double not3_max_val1) {
		this.not3_max_val1 = not3_max_val1;
	}
	public Double getNot3_max_val2() {
		return not3_max_val2;
	}
	public void setNot3_max_val2(Double not3_max_val2) {
		this.not3_max_val2 = not3_max_val2;
	}
	public Double getNot3_max_val3() {
		return not3_max_val3;
	}
	public void setNot3_max_val3(Double not3_max_val3) {
		this.not3_max_val3 = not3_max_val3;
	}
	public Double getXray() {
		return xray != null?xray:0;
	}
	public void setXray(Double xray) {
		this.xray = xray;
	}
	public Double getProton() {return proton!= null?proton:0;}
	public void setProton(Double proton) {
		this.proton = proton;
	}
	public Double getKp() {
		return kp!= null?kp:0;
	}
	public void setKp(Double kp) {
		this.kp = kp;
	}
	public Double getMp() {
		return mp!= null?mp:0;
	}
	public void setMp(Double mp) {
		this.mp = mp;
	}
	public String getXray_tm() {
		return xray_tm;
	}
	public void setXray_tm(String xray_tm) {
		this.xray_tm = xray_tm;
	}
	public String getProton_tm() {
		return proton_tm;
	}
	public void setProton_tm(String proton_tm) {
		this.proton_tm = proton_tm;
	}
	public String getKp_tm() {
		return kp_tm;
	}
	public void setKp_tm(String kp_tm) {
		this.kp_tm = kp_tm;
	}
	public String getMp_tm() {
		return mp_tm;
	}
	public void setMp_tm(String mp_tm) {
		this.mp_tm = mp_tm;
	}
	public String getRpt_kind() {
		return rpt_kind;
	}
	public void setRpt_kind(String rpt_kind) {
		this.rpt_kind = rpt_kind;
	}
	public String getXrayGrade() {
		return ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.XRAY, getXray());
	}
	public String getProtonGrade() {
		return ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.PROTON, getProton());
	}
	public String getKpGrade() {
		return ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.KP, getKp());
	}
	public String getMpGrade() {
		return ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.MP, getMp());
	}
	public String getRpt_file_path() {
		return rpt_file_path;
	}
	public void setRpt_file_path(String rpt_file_path) {
		this.rpt_file_path = rpt_file_path;
	}
	public String getRpt_file_nm() {
		return rpt_file_nm;
	}
	public void setRpt_file_nm(String rpt_file_nm) {
		this.rpt_file_nm = rpt_file_nm;
	}
	
	public String getRpt_file_org_nm() {
		return rpt_file_org_nm;
	}
	public void setRpt_file_org_nm(String rpt_file_org_nm) {
		this.rpt_file_org_nm = rpt_file_org_nm;
	}
	public String getWrn_flag() {
		return wrn_flag;
	}
	public void setWrn_flag(String wrn_flag) {
		this.wrn_flag = wrn_flag;
	}
	@Override
	public String toString() {
		return "ForecastReportDTO [rpt_seq_n=" + rpt_seq_n + ", rpt_type="
				+ rpt_type + ", title=" + title + ", contents=" + contents
				+ ", rmk1=" + rmk1 + ", rmk2=" + rmk2 + ", info1=" + info1
				+ ", info2=" + info2 + ", info3=" + info3 + ", info4=" + info4
				+ ", write_dt=" + write_dt + ", writer=" + writer
				+ ", publish_dt=" + publish_dt + ", publish_seq_n="
				+ publish_seq_n + ", submit_dt=" + submit_dt + ", file_nm1="
				+ file_nm1 + ", file_path1=" + file_path1 + ", file_title1="
				+ file_title1 + ", file_nm2=" + file_nm2 + ", file_path2="
				+ file_path2 + ", file_title2=" + file_title2 + ", file_nm3="
				+ file_nm3 + ", file_path3=" + file_path3 + ", file_title3="
				+ file_title3 + ", not1_desc=" + Arrays.toString(not1_desc)
				+ ", not1_type=" + not1_type + ", not1_publish=" + not1_publish
				+ ", not1_finish=" + not1_finish + ", not1_tar=" + not1_tar
				+ ", not1_probability1=" + not1_probability1
				+ ", not1_probability2=" + not1_probability2
				+ ", not1_max_val1=" + not1_max_val1 + ", not1_max_val2="
				+ not1_max_val2 + ", not1_max_val3=" + not1_max_val3
				+ ", not2_desc=" + Arrays.toString(not2_desc) + ", not2_type="
				+ not2_type + ", not2_publish=" + not2_publish
				+ ", not2_finish=" + not2_finish + ", not2_tar=" + not2_tar
				+ ", not2_probability1=" + not2_probability1
				+ ", not2_probability2=" + not2_probability2
				+ ", not2_max_val1=" + not2_max_val1 + ", not2_max_val2="
				+ not2_max_val2 + ", not2_max_val3=" + not2_max_val3
				+ ", not3_desc=" + Arrays.toString(not3_desc) + ", not3_type="
				+ not3_type + ", not3_publish=" + not3_publish
				+ ", not3_finish=" + not3_finish + ", not3_tar=" + not3_tar
				+ ", not3_probability1=" + not3_probability1
				+ ", not3_probability2=" + not3_probability2
				+ ", not3_max_val1=" + not3_max_val1 + ", not3_max_val2="
				+ not3_max_val2 + ", not3_max_val3=" + not3_max_val3
				+ ", xray=" + xray + ", proton=" + proton + ", kp=" + kp
				+ ", mp=" + mp + ", xray_tm=" + xray_tm + ", proton_tm="
				+ proton_tm + ", kp_tm=" + kp_tm + ", mp_tm=" + mp_tm
				+ ", rpt_kind=" + rpt_kind + ", rpt_file_path=" + rpt_file_path
				+ ", rpt_file_nm=" + rpt_file_nm + ", wrn_flag=" + wrn_flag + "]";
	}
}
