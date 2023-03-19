package com.sh.groupware.report.model.service;

import java.util.List;

import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportMember;

public interface ReportService {

	int insertReport(Report report);
	
	int insertReportMember(ReportMember member);
	
	int insertReference(Reference refer);

	List<ReportCheck> selectMyReportCheck(String loginMember);

} // interface end
