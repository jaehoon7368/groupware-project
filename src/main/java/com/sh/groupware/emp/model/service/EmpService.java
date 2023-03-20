package com.sh.groupware.emp.model.service;

import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

public interface EmpService {


	Emp selectEmp();

	int insertEmp(Emp emp);

	EmpDetail selectEmpDetail(String empId);



}
