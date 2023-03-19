package com.sh.groupware.report.model.service;

import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportMember;

public interface ReportService {

	int insertReport(Report report);
	
	int insertReportMember(ReportMember member);
	
	int insertReference(Reference refer);

} // interface end
