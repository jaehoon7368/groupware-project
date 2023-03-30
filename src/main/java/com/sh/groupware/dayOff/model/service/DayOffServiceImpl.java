package com.sh.groupware.dayOff.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.dayOff.model.dao.DayOffDao;
import com.sh.groupware.dayOff.model.dto.DayOff;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DayOffServiceImpl implements DayOffService {

	@Autowired
	private DayOffDao dayOffDao;
	
	@Override
	public int insertDayOff(DayOff dayOff) {
		return dayOffDao.insertDayOff(dayOff);
	} // insertDayOff() end
	
	@Override
	public List<DayOff> selectOneEmpDayOffList(String empId) {
		return dayOffDao.selectOneEmpDayOffList(empId);
	} //selectOneEmpDayOffList() end
	
} // class end
