package com.sh.groupware.emp.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.emp.model.dto.Authority;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;

@Mapper
public interface EmpDao {

	@Select("select * from emp")
	Emp selectEmp();

	int insertEmp(Emp emp);

	@Insert("insert into authority values(#{empId},#{auth})")
	int insertAuthority(Map<String, Object> param);

	List<EmpDetail> selectAllEmpList();
	
	@Select("select * from authority where emp_id = #{empId}")
	List<Authority> selectAllAuthorityList(String empId);

	@Select("select * from emp where dept_code = #{deptCode}")
	List<Emp> findByDeptCodeEmpList(String deptCode);

	@Select("select * from emp where dept_code = #{deptCode} and emp_id != #{empId}")
	List<Emp> findByDeptCodeEmpIdEmpList(Map<String, Object> param);
	
}
