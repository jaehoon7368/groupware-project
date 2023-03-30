package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignStatusDetail extends SignStatus {

	private String name;
	private String deptTitle;
	private String jobTitle;
	private String profileImg;

	public SignStatusDetail(String no, String signNo, String empId, int signOrder, Status status, String reason,
			LocalDate regDate, String name, String deptTitle, String jobTitle,
			String profileImg) {
		super(no, signNo, empId, signOrder, status, reason, regDate);
		this.name = name;
		this.deptTitle = deptTitle;
		this.jobTitle = jobTitle;
		this.profileImg = profileImg;
	} // SignStatusDetail() end
	
	
	
} // class end
