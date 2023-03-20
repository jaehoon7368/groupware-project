package com.sh.groupware.report.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.report.model.dao.ReportDao;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportMember;
import com.sh.groupware.report.model.dto.Type;

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
				refer.setType(Type.R);
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
	
	@Override
	public List<ReportCheck> selectMyReportCheck(String loginMember) {
		return reportDao.selectMyReportCheck(loginMember);
	} // selectMyReportCheck() end
	
	@Override
	public List<ReportCheck> findByReportNoReportCheckList(String no) {
		return reportDao.findByReportNoReportCheckList(no);
	} // findByReportNoReportCheckList() end

	
	@Override
	public List<ReportMember> findByReportNoMemberList(String no) {
		return reportDao.findByReportNoMemberList(no);
	} // findByReportNoMemberList
	
	@Override
	public List<Reference> findByReportNoReference(String no) {
		return reportDao.findByReportNoReference(no);
	} // findByReportNoReference() end
	
	@Override
	public int updateExcludeYn(List<String> report, List<String> unreport, String no) {
		int result = 0;
		
		if (report != null) {
			for (String empId : report) {
				Map<String, Object> param = new HashMap<>();
				param.put("no", no);
				param.put("empId", empId);
				result = updateExcludeYnN(param);
			}
		} // if (report.size() > 0) end
		
		if (unreport != null) {
			for (String empId : unreport) {
				Map<String, Object> param = new HashMap<>();
				param.put("no", no);
				param.put("empId", empId);
				result = updateExcludeYnY(param);
			}
		} // if (unreport.size() > 0) end
		return result;
	} // updateExcludeYn() end
	
	@Override
	public int updateExcludeYnY(Map<String, Object> param) {
		log.debug("no = {}, empId = {}", param.get("no"), param.get("empId"));
		return reportDao.updateExcludeYnY(param);
	} // updateExcludeYnY() end
	
	@Override
	public int updateExcludeYnN(Map<String, Object> param) {
		return reportDao.updateExcludeYnN(param);
	} // updateExcludeYnN() end
	
} // class end
