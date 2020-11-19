package egovframework.rte.swfc.dto;

import java.util.Date;

public class CMEReportDTO {

	String id;
	String analyst;
	Date startObsTime;
	Date createTime;
	String speedClass;
	String analysisReportPath;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAnalyst() {
		return analyst;
	}
	public void setAnalyst(String analyst) {
		this.analyst = analyst;
	}	
	public Date getStartObsTime() {
		return startObsTime;
	}
	public void setStartObsTime(Date startObsTime) {
		this.startObsTime = startObsTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getSpeedClass() {
		return speedClass;
	}
	public void setSpeedClass(String speedClass) {
		this.speedClass = speedClass;
	}
	public String getAnalysisReportPath() {
		return analysisReportPath;
	}
	public void setAnalysisReportPath(String analysisReportPath) {
		this.analysisReportPath = analysisReportPath;
	}
}
