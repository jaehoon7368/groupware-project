package com.sh.groupware.dayOff.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DayOff {

	private String no;
	private String empId;
	private int dayOffYear;
	private LocalDate startDate;
	private LocalDate endDate;
	private double count;
	private double leaveCount;
	private LocalDate regDate;
	
} // class end
