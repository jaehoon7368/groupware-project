package com.sh.groupware.workingManagement.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

@Mapper
public interface WorkingManagementDao {

	int insertStartWork(String empId);

	@Select("select * from working_management where no = #{no}")
	WorkingManagement selectStartwork(String no);

	@Select("select count(*) from working_management where emp_id = #{empId} AND TRUNC(reg_date) = TO_DATE(#{time})")
	int checkStartwork(Map<String, Object> param);

}
