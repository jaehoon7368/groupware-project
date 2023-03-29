package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignStatus {

	private String no;
	private String signNo;
	private String empId;
	private int signOrder;
	private Status status;
	private String reason;
	private LocalDate regDate;
	
	public SignStatus(String empId) {
		super();
		this.empId = empId;
	} // SignStatus() end
	
} // class end
