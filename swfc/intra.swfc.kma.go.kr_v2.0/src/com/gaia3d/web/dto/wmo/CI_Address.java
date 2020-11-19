package com.gaia3d.web.dto.wmo;

public class CI_Address {

	private Integer addressseqn          ;     //Address일련번호
	private Integer contactseqn          ;     //Contact일련번호
	private String deliverypoint        ;     //위치주소
	private String city                 ;     //도시
	private String administrativearea   ;     //주_지역
	private String postalcode           ;     //우편번호
	private String country              ;     //나라
	private String electronicmailaddress;     //메일주소
	
	public Integer getAddressseqn() {
		return addressseqn;
	}
	public void setAddressseqn(Integer addressseqn) {
		this.addressseqn = addressseqn;
	}
	public Integer getContactseqn() {
		return contactseqn;
	}
	public void setContactseqn(Integer contactseqn) {
		this.contactseqn = contactseqn;
	}
	public String getDeliverypoint() {
		return deliverypoint;
	}
	public void setDeliverypoint(String deliverypoint) {
		this.deliverypoint = deliverypoint;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAdministrativearea() {
		return administrativearea;
	}
	public void setAdministrativearea(String administrativearea) {
		this.administrativearea = administrativearea;
	}
	public String getPostalcode() {
		return postalcode;
	}
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getElectronicmailaddress() {
		return electronicmailaddress;
	}
	public void setElectronicmailaddress(String electronicmailaddress) {
		this.electronicmailaddress = electronicmailaddress;
	}
	
}
