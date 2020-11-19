package com.gaia3d.web.dto;

import org.hibernate.validator.constraints.NotBlank;

public class UserDTO {
	Integer id;
	
	@NotBlank
	String userId;
	
	String password;
	
	@NotBlank
	String name;

	String phone;
	
	String department;
	String position;
	
	@NotBlank
	String email;
	
	@NotBlank
	String role;
	
	@NotBlank
	String groupCd;
	
	String groupName;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getGroupCd() {
		return groupCd;
	}

	public void setGroupCd(String groupCd) {
		this.groupCd = groupCd;
	}
	
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", userId=" + userId + ", password="
				+ password + ", name=" + name + ", phone=" + phone
				+ ", department=" + department + ", position=" + position
				+ ", email=" + email + ", role=" + role + ", groupCd="
				+ groupCd + ", groupName=" + groupName + "]";
	}
	
	
}
