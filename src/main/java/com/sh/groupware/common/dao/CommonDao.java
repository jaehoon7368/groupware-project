package com.sh.groupware.common.dao;
	
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.common.dto.RecentNotification;
import com.sh.groupware.emp.model.dto.Emp;
	
@Mapper
public interface CommonDao {
	
	List<RecentNotification> selectAllReNoti();

	Emp selectOneEmpTitleJobByEmpId(String empId);
	
	
}
