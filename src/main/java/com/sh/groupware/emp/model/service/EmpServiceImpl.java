package com.sh.groupware.emp.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.emp.model.dao.EmpDao;
import com.sh.groupware.emp.model.dto.Emp;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDao empDao;
	
	
	@Override
	public Emp selectEmp() {
		return empDao.selectEmp();
	}
}
