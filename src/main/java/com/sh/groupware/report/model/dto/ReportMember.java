package com.sh.groupware.report.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportMember {

	private String no;
	private String reportNo;
	private String empId;
	private YN createYn;
	private YN excludeYn;
	private String profileImg;
	
} // class end
