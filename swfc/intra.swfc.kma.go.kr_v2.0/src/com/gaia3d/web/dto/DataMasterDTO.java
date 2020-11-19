package com.gaia3d.web.dto;

import java.io.Serializable;

public class DataMasterDTO implements Serializable {
	
	private static final long serialVersionUID = 875674309331616328L;

	private static final String SPLITE_WORD = ",";

	private Integer clt_dta_mstr_seq_n;       //수집자료마스터일련번호
	private Integer coverage_seq_n    ;       //범위일련번호
	private String coverage_kor_nm;       //범위 정보
	
	private Integer clt_tar_seq_n     ;       //수집대상일련번호
	private String clt_tar_kor_nm         ;  //수집대상한글명
	
	private Integer clt_tar_grp_seq_n ;       //수집대상그룹일련번호
	private String clt_tar_grp_kor_nm     ;  //수집대상그룹명
	
	private Integer metadataseqn        ;      //Metadata일련번호
	private String metadataStandardName ; 		// Metadata 명

	private Integer dmn_seq_n           ;      //도메인일련번호
	private String dmn_kor_nm     ;  			//도메인명
	
	private Integer dmn_layer_seq_n     ;      //도메인레이어일련번호
	private String dmn_layer_kor_nm     ;  		//도메인레이어명

	private Integer dta_knd_inside_seq_n;      //자료종류내부일련번호
	private String dta_knd_inside_kor_nm     ;  		//자료종류내부명

	private Integer dta_knd_seq_n       ;      //자료종류일련번호
	private String dta_knd_kor_nm     ;  		//자료종류내부명

	private Integer dmn_sub_seq_n       ;      //도메인서브일련번호
	private String dmn_sub_kor_nm     ;  			//도메인서브명
	
	private String clt_dta_sv_tp_cd    ;      //수집자료저장형식코드
	private String[] clt_dta_sv_tp_cds ; 		// 수집자료 저장형식 
	
	private String kep_dir             ;      //보관디렉토리
	private String clt_dta_tp_cd       ;      //수집자료형식코드
	private String algo_nm             ;      //알고리즘명
	private String algo_ver            ;      //알고리즘버전	
	
	private String use_f_cd        ;          //사용여부코드
	private String del_f_cd        ;          //삭제여부코드
	private Integer rg_k_seq_n      ;          //등록자일련번호
	private String rg_d            ;          //등록일자
	private String rg_tm           ;          //등록시간
	private String rg_ip           ;          //등록자아이피
	private Integer mdf_k_seq_n     ;          //수정자일련번호
	private String mdf_d           ;          //수정일자
	private String mdf_tm          ;          //수정시간
	private String mdf_ip          ;          //수정자아이피
	private String mstr_nm          ;          //마스터명
	private String prog_path        ;        //프로그램경로
	private String prog_file_nm       ;     //프로그램파일명
	private String clt_dta_lst_dtm    ;     //마지막 수집 프로그램명
	private String frct_mdl_svr_ip    ;     //알고리즘 서버 아이피
	
	
	/*
	 * API 관련 메서드
	 */
	private String clt_tar_cd;
	private String coverage_cd;
	private String dta_knd_cd;
	private String clt_tar_sensor_cd;

	/*
	 * 수집자료저장형식코드 다중선택 위한 코드 
	 */
	public String[] getClt_dta_sv_tp_cds() {
		return clt_dta_sv_tp_cds;
	}
	public void setClt_dta_sv_tp_cds(String[] clt_dta_sv_tp_cds) {
		for (String code : clt_dta_sv_tp_cds) {

			if ( this.clt_dta_sv_tp_cd  != null) {
				this.clt_dta_sv_tp_cd += SPLITE_WORD + code;
			}else{
				this.clt_dta_sv_tp_cd = code;
			}

		}
		this.clt_dta_sv_tp_cds = clt_dta_sv_tp_cds;
	}
	
	public String getFrct_mdl_svr_ip() {
		return frct_mdl_svr_ip;
	}
	public void setFrct_mdl_svr_ip(String frct_mdl_svr_ip) {
		this.frct_mdl_svr_ip = frct_mdl_svr_ip;
	}
	public String getClt_dta_sv_tp_cd() {
		return clt_dta_sv_tp_cd;
	}
	public void setClt_dta_sv_tp_cd(String clt_dta_sv_tp_cd) {
		this.clt_dta_sv_tp_cds = clt_dta_sv_tp_cd.split(SPLITE_WORD);
		this.clt_dta_sv_tp_cd = clt_dta_sv_tp_cd;
	}
	
	public String getClt_dta_lst_dtm() {
		return clt_dta_lst_dtm;
	}
	
	public void setClt_dta_lst_dtm(String clt_dta_lst_dtm) {
		this.clt_dta_lst_dtm = clt_dta_lst_dtm;
	}
	/**
	 * make getter setter
	 */
	public Integer getClt_dta_mstr_seq_n() {
		return clt_dta_mstr_seq_n;
	}
	public void setClt_dta_mstr_seq_n(Integer clt_dta_mstr_seq_n) {
		this.clt_dta_mstr_seq_n = clt_dta_mstr_seq_n;
	}
	public Integer getCoverage_seq_n() {
		return coverage_seq_n;
	}
	public void setCoverage_seq_n(Integer coverage_seq_n) {
		this.coverage_seq_n = coverage_seq_n;
	}
	public String getCoverage_kor_nm() {
		return coverage_kor_nm;
	}
	public void setCoverage_kor_nm(String coverage_kor_nm) {
		this.coverage_kor_nm = coverage_kor_nm;
	}
	public Integer getClt_tar_seq_n() {
		return clt_tar_seq_n;
	}
	public void setClt_tar_seq_n(Integer clt_tar_seq_n) {
		this.clt_tar_seq_n = clt_tar_seq_n;
	}
	public String getClt_tar_kor_nm() {
		return clt_tar_kor_nm;
	}
	public void setClt_tar_kor_nm(String clt_tar_kor_nm) {
		this.clt_tar_kor_nm = clt_tar_kor_nm;
	}
	public Integer getClt_tar_grp_seq_n() {
		return clt_tar_grp_seq_n;
	}
	public void setClt_tar_grp_seq_n(Integer clt_tar_grp_seq_n) {
		this.clt_tar_grp_seq_n = clt_tar_grp_seq_n;
	}
	public String getClt_tar_grp_kor_nm() {
		return clt_tar_grp_kor_nm;
	}
	public void setClt_tar_grp_kor_nm(String clt_tar_grp_kor_nm) {
		this.clt_tar_grp_kor_nm = clt_tar_grp_kor_nm;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public String getMetadataStandardName() {
		return metadataStandardName;
	}
	public void setMetadataStandardName(String metadataStandardName) {
		this.metadataStandardName = metadataStandardName;
	}
	public Integer getDmn_seq_n() {
		return dmn_seq_n;
	}
	public void setDmn_seq_n(Integer dmn_seq_n) {
		this.dmn_seq_n = dmn_seq_n;
	}
	public String getDmn_kor_nm() {
		return dmn_kor_nm;
	}
	public void setDmn_kor_nm(String dmn_kor_nm) {
		this.dmn_kor_nm = dmn_kor_nm;
	}
	public Integer getDmn_layer_seq_n() {
		return dmn_layer_seq_n;
	}
	public void setDmn_layer_seq_n(Integer dmn_layer_seq_n) {
		this.dmn_layer_seq_n = dmn_layer_seq_n;
	}
	public String getDmn_layer_kor_nm() {
		return dmn_layer_kor_nm;
	}
	public void setDmn_layer_kor_nm(String dmn_layer_kor_nm) {
		this.dmn_layer_kor_nm = dmn_layer_kor_nm;
	}
	public Integer getDta_knd_inside_seq_n() {
		return dta_knd_inside_seq_n;
	}
	public void setDta_knd_inside_seq_n(Integer dta_knd_inside_seq_n) {
		this.dta_knd_inside_seq_n = dta_knd_inside_seq_n;
	}
	public String getDta_knd_inside_kor_nm() {
		return dta_knd_inside_kor_nm;
	}
	public void setDta_knd_inside_kor_nm(String dta_knd_inside_kor_nm) {
		this.dta_knd_inside_kor_nm = dta_knd_inside_kor_nm;
	}
	public Integer getDta_knd_seq_n() {
		return dta_knd_seq_n;
	}
	public void setDta_knd_seq_n(Integer dta_knd_seq_n) {
		this.dta_knd_seq_n = dta_knd_seq_n;
	}
	public String getDta_knd_kor_nm() {
		return dta_knd_kor_nm;
	}
	public void setDta_knd_kor_nm(String dta_knd_kor_nm) {
		this.dta_knd_kor_nm = dta_knd_kor_nm;
	}
	public Integer getDmn_sub_seq_n() {
		return dmn_sub_seq_n;
	}
	public void setDmn_sub_seq_n(Integer dmn_sub_seq_n) {
		this.dmn_sub_seq_n = dmn_sub_seq_n;
	}
	public String getDmn_sub_kor_nm() {
		return dmn_sub_kor_nm;
	}
	public void setDmn_sub_kor_nm(String dmn_sub_kor_nm) {
		this.dmn_sub_kor_nm = dmn_sub_kor_nm;
	}
	public String getKep_dir() {
		return kep_dir;
	}
	public void setKep_dir(String kep_dir) {
		this.kep_dir = kep_dir;
	}
	public String getClt_dta_tp_cd() {
		return clt_dta_tp_cd;
	}
	public void setClt_dta_tp_cd(String clt_dta_tp_cd) {
		this.clt_dta_tp_cd = clt_dta_tp_cd;
	}
	public String getAlgo_nm() {
		return algo_nm;
	}
	public void setAlgo_nm(String algo_nm) {
		this.algo_nm = algo_nm;
	}
	public String getAlgo_ver() {
		return algo_ver;
	}
	public void setAlgo_ver(String algo_ver) {
		this.algo_ver = algo_ver;
	}
	public String getUse_f_cd() {
		return use_f_cd;
	}
	public void setUse_f_cd(String use_f_cd) {
		this.use_f_cd = use_f_cd;
	}
	public String getDel_f_cd() {
		return del_f_cd;
	}
	public void setDel_f_cd(String del_f_cd) {
		this.del_f_cd = del_f_cd;
	}
	public Integer getRg_k_seq_n() {
		return rg_k_seq_n;
	}
	public void setRg_k_seq_n(Integer rg_k_seq_n) {
		this.rg_k_seq_n = rg_k_seq_n;
	}
	public String getRg_d() {
		return rg_d;
	}
	public void setRg_d(String rg_d) {
		this.rg_d = rg_d;
	}
	public String getRg_tm() {
		return rg_tm;
	}
	public void setRg_tm(String rg_tm) {
		this.rg_tm = rg_tm;
	}
	public String getRg_ip() {
		return rg_ip;
	}
	public void setRg_ip(String rg_ip) {
		this.rg_ip = rg_ip;
	}
	public Integer getMdf_k_seq_n() {
		return mdf_k_seq_n;
	}
	public void setMdf_k_seq_n(Integer mdf_k_seq_n) {
		this.mdf_k_seq_n = mdf_k_seq_n;
	}
	public String getMdf_d() {
		return mdf_d;
	}
	public void setMdf_d(String mdf_d) {
		this.mdf_d = mdf_d;
	}
	public String getMdf_tm() {
		return mdf_tm;
	}
	public void setMdf_tm(String mdf_tm) {
		this.mdf_tm = mdf_tm;
	}
	public String getMdf_ip() {
		return mdf_ip;
	}
	public void setMdf_ip(String mdf_ip) {
		this.mdf_ip = mdf_ip;
	}
	
	public String getMstr_nm() {
		return mstr_nm;
	}
	public void setMstr_nm(String mstr_nm) {
		this.mstr_nm = mstr_nm;
	}
	public String getProg_path() {
		return prog_path;
	}
	public void setProg_path(String prog_path) {
		this.prog_path = prog_path;
	}
	public String getProg_file_nm() {
		return prog_file_nm;
	}
	public void setProg_file_nm(String prog_file_nm) {
		this.prog_file_nm = prog_file_nm;
	}
	public String getClt_tar_cd() {
		return clt_tar_cd;
	}
	public void setClt_tar_cd(String clt_tar_cd) {
		this.clt_tar_cd = clt_tar_cd;
	}
	public String getCoverage_cd() {
		return coverage_cd;
	}
	public void setCoverage_cd(String coverage_cd) {
		this.coverage_cd = coverage_cd;
	}
	public String getDta_knd_cd() {
		return dta_knd_cd;
	}
	public void setDta_knd_cd(String dta_knd_cd) {
		this.dta_knd_cd = dta_knd_cd;
	}
	public String getClt_tar_sensor_cd() {
		return clt_tar_sensor_cd;
	}
	public void setClt_tar_sensor_cd(String clt_tar_sensor_cd) {
		this.clt_tar_sensor_cd = clt_tar_sensor_cd;
	}
}
