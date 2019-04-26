package web.dto;

import java.io.Serializable;

public class User implements Serializable  {
	
	private String id; 
	private String pw; 
	private String phone;
	private String email;
	private String name;
	private String img;
	private String sort;
	
	@Override
	public String toString() {
		return "User [id=" + id + ", pw=" + pw + ", phone=" + phone + ", email=" + email + ", name=" + name + ", img="
				+ img + ", sort=" + sort + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	
}
