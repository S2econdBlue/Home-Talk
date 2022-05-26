package com.ssafy.vue.dto;

public class BoardAllDto {
	private int no;
	private String id;
	private String time;
	private String title;
	private int deposit;
	private int monthlyFee;
	private String detail; 
	private String roadnameAddress;
	private String save_path;
	private String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSave_path() {
		return save_path;
	}
	public void setSave_path(String save_path) {
		this.save_path = save_path;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getDeposit() {
		return deposit;
	}
	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}
	public int getMonthlyFee() {
		return monthlyFee;
	}
	public void setMonthlyFee(int monthlyFee) {
		this.monthlyFee = monthlyFee;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getRoadnameAddress() {
		return roadnameAddress;
	}
	public void setRoadnameAddress(String roadnameAddress) {
		this.roadnameAddress = roadnameAddress;
	}
	@Override
	public String toString() {
		return "BoardAllDto [no=" + no + ", id=" + id + ", time=" + time + ", title=" + title + ", deposit=" + deposit
				+ ", monthlyFee=" + monthlyFee + ", detail=" + detail + ", roadnameAddress=" + roadnameAddress
				+ ", save_path=" + save_path + ", name=" + name + "]";
	}
	
}