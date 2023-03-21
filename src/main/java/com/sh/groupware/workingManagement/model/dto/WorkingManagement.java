package com.sh.groupware.workingManagement.model.dto;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WorkingManagement {

	private String no;
	private Timestamp startWork;
	private Timestamp endWork;
	private Timestamp overtime;
	private LocalDate regDate;
	private String state;
	private Timestamp dayWorkTime;
	private String empId;
}
