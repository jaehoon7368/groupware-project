package com.sh.groupware.dayOff.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.dayOff.model.dao.DayOffDao;
import com.sh.groupware.dayOff.model.dto.DayOff;
import com.sh.groupware.dayOff.model.dto.DayOffDetail;

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
	public List<DayOffDetail> selectOneEmpDayOffList(String empId) {
		return dayOffDao.selectOneEmpDayOffList(empId);
	} //selectOneEmpDayOffList() end
	
	@Override
	public DayOffDetail selectLastLeaveCount(String empId) {
		return dayOffDao.selectLastLeaveCount(empId);
	} //selectLastLeaveCount() end
	
	@Override
	public List<DayOff> selectDayOffYear() {
		return dayOffDao.selectDayOffYear();
	} //selectDayOffYear() end
	
	@Override
	public List<DayOffDetail> selectOneEmpDayOffListYear(Map<String, Object> param) {
		return dayOffDao.selectOneEmpDayOffListYear(param);
	}
	
} // class end
