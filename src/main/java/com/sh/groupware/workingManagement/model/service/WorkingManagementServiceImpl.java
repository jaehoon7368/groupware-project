package com.sh.groupware.workingManagement.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.workingManagement.model.dao.WorkingManagementDao;
import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

@Service
public class WorkingManagementServiceImpl implements WorkingManagementService {

	@Autowired
	private WorkingManagementDao workingManagementDao;
	
	@Override
	public int insertStartWork(String empId) {
		return workingManagementDao.insertStartWork(empId);
	}
	
	@Override
	public WorkingManagement selectStartwork(String no) {
		return workingManagementDao.selectStartwork(no);
	}
	
	@Override
	public int checkStartwork(Map<String, Object> param) {
		return workingManagementDao.checkStartwork(param);
	}
	
	@Override
	public WorkingManagement checkWorkTime(Map<String, Object> param) {
		return workingManagementDao.checkWorkTime(param);
	}
	
	@Override
	public int updateEndWok(Map<String, Object> param) {
		return workingManagementDao.updateEndWork(param);
	}
	
	@Override
	public int updateDayWorkTime(Map<String, Object> param) {
		return workingManagementDao.updateDayWorkTime(param);
	}
	
	@Override
	public List<WorkingManagement> selectMonthWork(Map<String, Object> param) {
		return workingManagementDao.selectMonthWok(param);
	}
	
	@Override
	public int totalMonthTime(Map<String, Object> param) {
		return workingManagementDao.totalMonthTime(param);
	}
	
	@Override
	public List<WorkingManagement> selectWeekDatas(Map<String, Object> param) {
		return workingManagementDao.selectWeekDatas(param);
	}
	
	@Override
	public int weekTotalTime(Map<String, Object> param) {
		return workingManagementDao.weekTotalTime(param);
	}
	
	@Override
	public int selectWeekWorkTime(Map<String, Object> startEndMap) {
		return workingManagementDao.selectWeekWorkTime(startEndMap);
	}
	
	@Override
	public int insertRegDateState(WorkingManagement working) {
		return workingManagementDao.insertRegDateState(working);
	} // insertRegDateState() end
	
}
