package egovframework.rte.swfc.dto;

import java.util.Date;
import java.util.List;

public class FlarePredication {

	Date create_date;
	Double total_c;
	Double total_m;
	Double total_x;
	
	List<FlarePredicationDetail> details;
	
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Double getTotal_c() {
		return total_c;
	}
	public void setTotal_c(Double total_c) {
		this.total_c = total_c;
	}
	public Double getTotal_m() {
		return total_m;
	}
	public void setTotal_m(Double total_m) {
		this.total_m = total_m;
	}
	public Double getTotal_x() {
		return total_x;
	}
	public void setTotal_x(Double total_x) {
		this.total_x = total_x;
	}
	
	public List<FlarePredicationDetail> getDetails() {
		return details;
	}
	public void setDetails(List<FlarePredicationDetail> details) {
		this.details = details;
	}
	
}
