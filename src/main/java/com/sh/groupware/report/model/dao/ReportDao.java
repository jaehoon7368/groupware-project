package com.sh.groupware.report.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportMember;

@Mapper
public interface ReportDao {

	int insertReport(Report report);

	@Insert("insert into reportMember values (seq_reportMember_no.nextval, #{reportNo}, #{empId}, default, default)")
	int insertReportMember(ReportMember member);

	@Select("select * from reportMember where dept_code = #{deptCode}")
	List<ReportMember> findByDeptCodeReportMember(String deptCode);

	@Select("select * from reference where dept_code = #{deptCode}")
	List<Reference> findByDeptCodeReference(String deptCode);

	@Insert("insert into reference values (seq_reference_no.nextval, #{empId}, #{type}, #{referenceNo}, #{referenceType}, #{deptCode})")
	int insertReference(Reference refer);

} // interface end
