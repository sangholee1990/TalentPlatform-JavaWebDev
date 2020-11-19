package com.gaia3d.web.dto.wmo;

import java.util.Arrays;
import java.util.List;

public class DQ_DomainConsistency extends DQ_Element {
	private Integer domainconsistencyseqn;     //DomainConsistency일련번호
//	private Integer dataqualityseqn      ;     //DataQuality일련번호
	private MD_Identifier measureidentification;     //대상식별고유값_MD_Identifier
	private DQ_Result[] result      ;     //품질평가결과값_DQ_ConformanceResult extends DQ_Result
	
	private List<DQ_ConformanceResult> resultArray;

	public List<DQ_ConformanceResult> getResultArray() {
		return this.resultArray;
	}
	public void setResultArray(List<DQ_ConformanceResult> resultArray) {
		this.resultArray =resultArray;
		//this.result = (DQ_Result[])resultArray.toArray();
	}
	
	public Integer getDomainconsistencyseqn() {
		return domainconsistencyseqn;
	}
	public void setDomainconsistencyseqn(Integer domainconsistencyseqn) {
		this.domainconsistencyseqn = domainconsistencyseqn;
	}
//	public Integer getDataqualityseqn() {
//		return dataqualityseqn;
//	}
//	public void setDataqualityseqn(Integer dataqualityseqn) {
//		this.dataqualityseqn = dataqualityseqn;
//	}
	public MD_Identifier getMeasureidentification() {
		return measureidentification;
	}
	public void setMeasureidentification(MD_Identifier measureidentification) {
		this.measureidentification = measureidentification;
	}
	public DQ_Result[] getResult() {
		return result;
	}
	public void setResult(DQ_Result[] result) {
		this.result = result;
	}

	
}
