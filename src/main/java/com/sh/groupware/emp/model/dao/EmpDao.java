package com.sh.groupware.emp.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.emp.model.dto.Emp;

@Mapper
public interface EmpDao {

	@Select("select * from emp")
	Emp selectEmp();

	int insertEmp(Emp emp);

	@Insert("insert into authority values(#{empId},#{auth})")
	int insertAuthority(Map<String, Object> param);
	
	

}
