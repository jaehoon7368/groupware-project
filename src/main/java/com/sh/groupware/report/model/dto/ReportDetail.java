package com.sh.groupware.report.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportDetail {
	
	private String no;
	@NonNull
	private String reportNo;
	@NonNull
	private String empId;
	@NonNull
	private String content;
	private LocalDate regDate;
	
} // class end
