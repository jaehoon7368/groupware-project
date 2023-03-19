package com.sh.groupware.emp.model.service;

import java.util.List;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;

public interface EmpService {


	Emp selectEmp();

	int insertEmp(Emp emp);

	List<EmpDetail> selectAllEmpList();

}
