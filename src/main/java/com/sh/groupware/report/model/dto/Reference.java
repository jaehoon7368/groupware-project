package com.sh.groupware.report.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reference {

	private String no;
	private String empId;
	private Type type;
	private String referenceNo;
	
} // class end
