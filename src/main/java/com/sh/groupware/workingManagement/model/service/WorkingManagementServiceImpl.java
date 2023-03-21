package com.sh.groupware.workingManagement.model.service;

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
}
