package com.sh.groupware.dayOff.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.dayOff.model.dto.DayOff;
import com.sh.groupware.dayOff.model.dto.DayOffDetail;

@Mapper
public interface DayOffDao {

	int insertDayOff(DayOff dayOff);

	//내 연차내역 확인
	List<DayOffDetail> selectOneEmpDayOffList(String empId);

	DayOffDetail selectLastLeaveCount(String empId);

	// 연차 사용기간 년도
	@Select("select day_off_year from dayoff group by day_off_year order by day_off_year")
	List<DayOff> selectDayOffYear();

} // interface end
