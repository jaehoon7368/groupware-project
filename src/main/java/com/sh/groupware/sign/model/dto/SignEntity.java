package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;

import com.sh.groupware.report.model.dto.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignEntity {

	private String no;
	private String empId;
	private String deptCode;
	private String jobCode;
	private SignType type;
	private LocalDate regDate;
	private YN emergency;
	private YN complete;
	
} // class end
