package com.sh.groupware.workingManagement.model.service;

import java.util.List;
import java.util.Map;

import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

public interface WorkingManagementService {

	int insertStartWork(String empId);

	WorkingManagement selectStartwork(String no);

	int checkStartwork(Map<String, Object> param);

	WorkingManagement checkWorkTime(Map<String, Object> param);

	int updateEndWok(Map<String, Object> param);

	int updateDayWorkTime(Map<String, Object> param);

	List<WorkingManagement> selectMonthWork(Map<String, Object> param);

	List<WorkingManagement> selectWeekDatas(Map<String, Object> param);

	int weekTotalTime(Map<String, Object> param);

	int totalMonthTime(Map<String, Object> param);

	int selectWeekWorkTime(Map<String, Object> startEndMap);

	int selectWeekOverTime(Map<String, Object> startEndMap);

	int monthOverTime(Map<String, Object> startEndMap);


	

}
