package com.sh.groupware.dayOff.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.dayOff.model.dto.DayOff;

@Mapper
public interface DayOffDao {

	int insertDayOff(DayOff dayOff);

	//내 연차내역 확인
	@Select("select * from dayoff where emp_id = #{empId} order by no desc")
	List<DayOff> selectOneEmpDayOffList(String empId);

} // interface end
