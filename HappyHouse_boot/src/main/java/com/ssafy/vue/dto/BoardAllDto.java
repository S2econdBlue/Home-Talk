package com.ssafy.vue.dto;

public class BoardAllDto {
	private int no;
	private String id;
	private String time;
	private String title;
	private String content;
	private int deposit;
	private int monthlyFee;
	private String detail; 
	private String roadnameAddress;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
		return "BoardAllDto [no=" + no + ", id=" + id + ", time=" + time + ", title=" + title + ", content=" + content
				+ ", deposit=" + deposit + ", monthlyFee=" + monthlyFee + ", detail=" + detail + ", roadnameAddress="
				+ roadnameAddress + "]";
	}
}