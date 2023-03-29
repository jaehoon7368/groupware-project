package com.sh.groupware.dayOff.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sh.groupware.dayOff.model.dto.DayOff;

@Mapper
public interface DayOffDao {

	int insertDayOff(DayOff dayOff);

} // interface end
