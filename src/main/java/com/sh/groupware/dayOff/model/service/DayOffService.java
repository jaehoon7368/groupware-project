package com.sh.groupware.dayOff.model.service;

import java.util.List;

import com.sh.groupware.dayOff.model.dto.DayOff;
import com.sh.groupware.dayOff.model.dto.DayOffDetail;

public interface DayOffService {

	int insertDayOff(DayOff dayOff);

	List<DayOffDetail> selectOneEmpDayOffList(String empId);

	DayOffDetail selectLastLeaveCount(String empId);

	List<DayOff> selectDayOffYear();

} // interface end
