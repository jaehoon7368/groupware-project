package com.sh.groupware.workingManagement.model.service;

import java.util.Map;

import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

public interface WorkingManagementService {

	int insertStartWork(String empId);

	WorkingManagement selectStartwork(String no);

	int checkStartwork(Map<String, Object> param);

}
