package com.sh.groupware.emp.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

	EmpDetail selectEmpDetail(String empId);
	
	List<EmpDetail> selectAllEmpList();
	
	@Select("select * from authority where emp_id = #{empId}")
	List<Authority> selectAllAuthorityList(String empId);

	@Select("select * from emp where dept_code = #{deptCode}")
	List<Emp> findByDeptCodeEmpList(String deptCode);

	@Select("select * from emp where dept_code = #{deptCode} and emp_id != #{empId}")
	List<Emp> findByDeptCodeEmpIdEmpList(Map<String, Object> param);

	@Update("update emp set password=#{password}, phone= #{phone}, address= #{address} where emp_id = #{empId}")
	int empUpdate(Emp emp);


	List<Emp> selectAllEmpAddTitleDept();

	
	List<Emp> findByMyDeptCodeManagerEmpList(Map<String, Object> param);

	@Select("select * from emp where dept_code = 'd1' and job_code in ('j1', 'j2') order by job_code desc")
	List<Emp> findByD1ManagerEmpList();
	
	//부서별 근태현황 사원조회
	List<EmpDetail> selectEmpDeptList(String deptCode);

	// 전사 인사정보
	List<EmpDetail> selectEmpAll();
	
}
