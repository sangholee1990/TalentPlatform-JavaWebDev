package com.gaia3d.web.dto.wmo;

public class EX_GeographicBoundingBox extends EX_GeographicExtent {

	private Integer geographicboundingboxseqn; //GeographicBoundingBox일련번호
//	private Integer extentseqn               ; //Extent일련번호
	private double westboundlongitude       ; //서쪽좌표
	private double eastboundlongitude       ; //동쪽좌표
	private double southboundlatitude       ; //남쪽좌표
	private double northboundlatitude       ; //북쪽좌표
	public Integer getGeographicboundingboxseqn() {
		return geographicboundingboxseqn;
	}
	public void setGeographicboundingboxseqn(Integer geographicboundingboxseqn) {
		this.geographicboundingboxseqn = geographicboundingboxseqn;
	}
//	public Integer getExtentseqn() {
//		return extentseqn;
//	}
//	public void setExtentseqn(Integer extentseqn) {
//		this.extentseqn = extentseqn;
//	}
	public double getWestboundlongitude() {
		return westboundlongitude;
	}
	public void setWestboundlongitude(double westboundlongitude) {
		this.westboundlongitude = westboundlongitude;
	}
	public double getEastboundlongitude() {
		return eastboundlongitude;
	}
	public void setEastboundlongitude(double eastboundlongitude) {
		this.eastboundlongitude = eastboundlongitude;
	}
	public double getSouthboundlatitude() {
		return southboundlatitude;
	}
	public void setSouthboundlatitude(double southboundlatitude) {
		this.southboundlatitude = southboundlatitude;
	}
	public double getNorthboundlatitude() {
		return northboundlatitude;
	}
	public void setNorthboundlatitude(double northboundlatitude) {
		this.northboundlatitude = northboundlatitude;
	}

	
}
