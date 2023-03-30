package com.sh.groupware.dayOff.model.service;

import java.util.List;

import com.sh.groupware.dayOff.model.dto.DayOff;

public interface DayOffService {

	int insertDayOff(DayOff dayOff);

	List<DayOff> selectOneEmpDayOffList(String empId);

} // interface end
