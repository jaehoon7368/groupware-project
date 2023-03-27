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
	private int sign_order;
	private Status status;
	private LocalDate regDate;
	
} // class end
