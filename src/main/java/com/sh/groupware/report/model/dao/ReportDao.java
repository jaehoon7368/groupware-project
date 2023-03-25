package com.sh.groupware.report.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportComment;
import com.sh.groupware.report.model.dto.ReportDetail;
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

	List<ReportCheck> selectMyReportCheck(String loginMember);

	@Select("select * from view_reportCheck where report_no = #{no}")
	List<ReportCheck> findByReportNoReportCheckList(String no);

	@Select("select * from reportMember where report_no = #{no}")
	List<ReportMember> findByReportNoMemberList(String no);

	@Select("select * from reference where reference_no = #{no}")
	List<Reference> findByReportNoReference(String no);

	@Update("update reportMember set exclude_yn = 'Y' where report_no = #{no} and emp_id = #{empId}")
	int updateExcludeYnY(Map<String, Object> param);

	@Update("update reportMember set exclude_yn = 'N' where report_no = #{no} and emp_id = #{empId}")
	int updateExcludeYnN(Map<String, Object> param);

	int insertReportDetail(ReportDetail detail);

	@Update("update reportMember set create_yn = 'Y' where report_no = #{no} and emp_id = #{empId}")
	int updateCreateYnY(Map<String, Object> param);

	@Select("select * from report where dept_yn = 'Y' and writer in (select emp_id from emp where dept_code = #{code}) order by end_date")
	List<Report> findByDeptCodeReportList(String code);

	ReportDetail findByDetailNoReportDetail(String no);

	int updateReportDetail(ReportDetail reportDetail);

	@Delete("delete from reportDetail where no = #{no}")
	int reportDetailDelete(String no);

	@Update("update reportMember set create_yn = 'N' where report_no = #{reportNo} and emp_id = #{empId}")
	int updateCreateYnN(Map<String, Object> param);

	
	List<ReportComment> selectAllReportComment(String detailNo);

	int insertReportComment(ReportComment reportComment);

	int updateReportComment(ReportComment reportComment);

	@Delete("delete from reportComment where no = #{no}")
	int reportCommentDelete(String no);

	ReportComment findByNoReportComment(String no);
	
} // class end