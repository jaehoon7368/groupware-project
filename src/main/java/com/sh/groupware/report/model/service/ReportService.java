package com.sh.groupware.report.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportComment;
import com.sh.groupware.report.model.dto.ReportDetail;
import com.sh.groupware.report.model.dto.ReportMember;

public interface ReportService {

	int insertReport(Report report);
	
	int insertReportMember(ReportMember member);
	
	int insertReference(Reference refer);

	List<ReportCheck> selectMyReportCheck(String loginMember);

	List<ReportCheck> findByReportNoReportCheckList(String no);
	
	List<ReportMember> findByReportNoMemberList(String no);
	
//	List<Reference> findByReportNoReference(String no);

	List<Emp> findByReportNoReference(String no);

	int updateExcludeYnY(Map<String, Object> param);

	int updateExcludeYnN(Map<String, Object> param);

	int updateExcludeYn(List<String> report, List<String> unreport, String no);

	int insertReportDetail(ReportDetail detail);

	int updateCreateYnY(Map<String, Object> param);

	List<Report> findByDeptCodeReportList(String code, RowBounds rowBounds);

	int updateReportDetail(ReportDetail reportDetail);

	int reportDetailDelete(ReportDetail reportDetail);

	List<ReportComment> selectAllReportComment(String detailNo);

	int insertReportComment(ReportComment reportComment);

	int updateReportComment(ReportComment reportComment);

	int deleteReportComment(String no);

	ReportComment findByNoReportComment(String no);

	List<Report> findByWriterReportCheckList(String empId, RowBounds rowBounds);

	List<Report> findByMemberReportCheckList(String empId, RowBounds rowBounds);

	List<Report> findByReferenceReportCheckList(Map<String, Object> param, RowBounds rowBounds);

	int selectDeptCodeListCount(String code);

	int selectWriterListCount(String empId);

	int selectReferListCount(Map<String, Object> param);

	int selectMemberListCount(String empId);

	List<Report> findByWriterReportList(String empId);

} // interface end
