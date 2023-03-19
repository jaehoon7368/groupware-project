package com.sh.groupware.report.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.report.model.dao.ReportDao;
import com.sh.groupware.report.model.dto.Category;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportMember;
import com.sh.groupware.report.model.dto.Type;
import com.sh.groupware.report.model.dto.YN;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	
	@Override
	public int insertReport(Report report) {
		int result = reportDao.insertReport(report);
		
		List<ReportMember> memberList = report.getMemberList();
		if (memberList.size() > 0) {
			for (ReportMember member : memberList) {
				member.setReportNo(report.getNo());
				log.debug("member = {}", member);
				result = insertReportMember(member);
			}
		} // if (memberList) end
		
		List<Reference> referenceList = report.getReferenceList();
		if (referenceList.size() > 0) {
			for (Reference refer : referenceList) {
				refer.setReferenceNo(report.getNo());
				refer.setCategory(Category.R);
				log.debug("refer = {}", refer);
				result = insertReference(refer);
			}
		} // if (referenceList) end
		
		return result;
	} // insertReport() end

	@Override
	public int insertReportMember(ReportMember member) {
		return reportDao.insertReportMember(member);
	} // insertReportMember() end
	
	@Override
	public int insertReference(Reference refer) {
		return reportDao.insertReference(refer);
	} // insertReference() end
	
} // class end
