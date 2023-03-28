package com.sh.groupware.report.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportComment {

	private String no;
	private String detailNo;
	private String writer;
	private String content;
	private LocalDate regDate;
	private String writerName;
	private String jobTitle;
	private String profileImg;
	
} // class end
