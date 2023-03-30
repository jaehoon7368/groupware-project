package com.sh.groupware.dayOff.model.dto;


import java.time.LocalDate;

import com.sh.groupware.sign.model.dto.DayOffType;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class DayOffDetail extends DayOff {
	private DayOffType type;
	private String content;
	private int baseDayOff;
	
	public DayOffDetail(String no, String formNo, String empId, int dayOffYear, LocalDate startDate, LocalDate endDate,
			double count, double leaveCount, LocalDate regDate, DayOffType type, String content, int baseDayOff) {
		super(no, formNo, empId, dayOffYear, startDate, endDate, count, leaveCount, regDate);
		this.type = type;
		this.content = content;
		this.baseDayOff = baseDayOff;
	} //DayOffDetail end
	
	
	
	
}
