package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DayOffForm {

	private String no;
	private String signNo;
	private DayOffType type;
	private Half half;
	private LocalDate startDate;
	private LocalDate endDate;
	private double count;
	private String content;
	
} // class end
