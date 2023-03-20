package com.sh.groupware.dept.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.dept.model.dto.Dept;

@Mapper
public interface DeptDao {

	@Select("select * from dept")
	List<Dept> selectAllDept();

} // interface end
