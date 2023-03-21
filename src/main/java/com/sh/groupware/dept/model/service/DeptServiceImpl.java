package com.sh.groupware.dept.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.dept.model.dao.DeptDao;
import com.sh.groupware.dept.model.dto.Dept;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DeptServiceImpl implements DeptService {

	@Autowired
	private DeptDao deptDao;
	
	@Override
	public List<Dept> selectAllDept() {
		return deptDao.selectAllDept();
	} // selectAllDept() end
	
} // class end
