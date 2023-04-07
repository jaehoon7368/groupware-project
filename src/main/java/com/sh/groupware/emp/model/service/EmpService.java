package com.sh.groupware.emp.model.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;

public interface EmpService {


	Emp selectEmp();

	int insertEmp(Emp emp);

	EmpDetail selectEmpDetail(String empId);

	List<EmpDetail> selectAllEmpList();

	List<Emp> findByDeptCodeEmpList(String deptCode);

	List<Emp> findByDeptCodeEmpIdEmpList(Map<String, Object> param);

	int empUpdate(Emp emp);

	List<Emp> selectAllEmpAddTitleDept();

	int updateQuit(Map<String, Object> param);
	
	List<EmpDetail> selectEmpDeptList(String deptCode);

	List<EmpDetail> selectEmpAll(RowBounds rowBounds);

	double selectBaseDayOff(String empId);

	List<EmpDetail> empFinderList(Map<String, Object> param, RowBounds rowBounds);

	int selectEmpCount();

	int selectEmpCountDept(Map<String, Object> param);

	int selectEmpDeptCount(String deptCode);

	List<EmpDetail> empFinderDeptList(Map<String, Object> param);

	List<Emp> selectEmpAddTitleDept(Map<String, Object> param);

	
}
