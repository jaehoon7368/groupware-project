package com.sh.groupware.emp.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.emp.model.dto.Emp;

@Mapper
public interface EmpDao {

	@Select("select * from emp")
	Emp selectEmp();

}
