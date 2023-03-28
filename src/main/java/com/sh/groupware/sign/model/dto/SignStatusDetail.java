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
	
	public SignStatusDetail(String no, String signNo, String empId, int signOrder, Status status, LocalDate regDate,
			String name, String deptTitle, String jobTitle) {
		super(no, signNo, empId, signOrder, status, regDate);
		this.name = name;
		this.deptTitle = deptTitle;
		this.jobTitle = jobTitle;
	} // SignStatusDetail() end
	
} // class end
