package com.sh.groupware.report.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportEntity {

	private String no;
	private String writer;
	private String title;
	private String explain;
	private LocalDate regDate;
	private YN publicYn;
	
} // class end
