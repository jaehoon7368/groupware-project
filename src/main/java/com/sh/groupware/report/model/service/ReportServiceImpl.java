package com.sh.groupware.report.model.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.common.attachment.model.dao.AttachmentDao;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.common.dto.Category;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.report.model.dao.ReportDao;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportComment;
import com.sh.groupware.report.model.dto.ReportDetail;
import com.sh.groupware.report.model.dto.ReportMember;
import com.sh.groupware.report.model.dto.Type;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private ServletContext application;
	
	
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
	
	
//	@Override
//	public List<Reference> findByReportNoReference(String no) {
//		return reportDao.findByReportNoReference(no);
//	} // findByReportNoReference() end
	
	
	@Override
	public List<Emp> findByReportNoReference(String no) {
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
	
	
	@Override
	public int insertReportDetail(ReportDetail detail) {
		int result = reportDao.insertReportDetail(detail);
		
		List<Attachment> attachList = detail.getAttachments();
		for (Attachment attach : attachList) {
			attach.setPkNo(detail.getNo());
			
			result = attachmentDao.insertReportAttachment(attach);
		}
		
		Map<String, Object> param = new HashMap<>();
		param.put("no", detail.getReportNo());
		param.put("empId", detail.getEmpId());
		
		result = updateCreateYnY(param);
		
		return result;
	} // insertReportDetail() end
	
	
	@Override
	public int updateCreateYnY(Map<String, Object> param) {
		return reportDao.updateCreateYnY(param);
	} // updateCreateYnY() end
	
	
	@Override
	public List<Report> findByDeptCodeReportList(String code) {
		List<Report> reportList = reportDao.findByDeptCodeReportList(code);
		
		if (reportList.size() > 0) {
			for (Report repo : reportList) {
				List<ReportMember> memberList = findByReportNoMemberList(repo.getNo());
				if (memberList.size() > 0) {
					for (ReportMember member : memberList) {
						repo.addReportMember(member);
					}
				} // memberList report에 저장
				
//				List<Reference> referList = findByReportNoReference(repo.getNo());
//				if (referList.size() > 0) {
//					for (Reference refer : referList) {
//						repo.addReference(refer);
//					}
//				} // referList report에 저장
			}
		}
		return reportList;
	} // findByDeptCodeReportList() end
	
	
	@Override
	public int updateReportDetail(ReportDetail reportDetail) {
		int result = reportDao.updateReportDetail(reportDetail);
		
		List<Attachment> attachments = reportDetail.getAttachments();
		if (attachments.size() > 0) {
			for (Attachment attach : attachments)
				result = attachmentDao.insertReportAttachment(attach);				
		}
		return result;
	} // updateReportDetail() end
	
	
	@Override
	public int reportDetailDelete(ReportDetail reportDetail) {
		int result = 0;
		
		Map<String, Object> param = new HashMap<>();
		param.put("category", Category.R);
		param.put("pkNo", reportDetail.getNo());
		
		List<Attachment> attachments = attachmentDao.selectAllAttachList(param);
		if (attachments.size() > 0) {
			for (Attachment attach : attachments) {
				String saveDirectory = application.getRealPath("/resources/upload/report");
				File delFile = new File(saveDirectory, attach.getRenameFilename());
				
				if (delFile.exists())
					delFile.delete();
				
				result = attachmentDao.deleteOneAttachment(attach.getNo());
			}
		}
		
		param.put("reportNo", reportDetail.getReportNo());
		param.put("empId", reportDetail.getEmpId());
		result = reportDao.updateCreateYnN(param);
		
		result = reportDao.reportDetailDelete(reportDetail.getNo());
		
		return result;
	} //reportDetailDelete() end
	
	
	@Override
	public List<ReportComment> selectAllReportComment(String detailNo) {
		return reportDao.selectAllReportComment(detailNo);
	} // selectAllReportComment() end
	
	
	@Override
	public int insertReportComment(ReportComment reportComment) {
		return reportDao.insertReportComment(reportComment);
	} // insertReportComment() end
	
	
	@Override
	public int updateReportComment(ReportComment reportComment) {
		return reportDao.updateReportComment(reportComment);
	} // updateReportComment() end
	
	
	@Override
	public int deleteReportComment(String no) {
		return reportDao.reportCommentDelete(no);
	} // reportCommentDelete() end
	
	
	@Override
	public ReportComment findByNoReportComment(String no) {
		return reportDao.findByNoReportComment(no);
	} // findByNoReportComment() end
	
	
	@Override
	public List<Report> findByWriterReportCheckList(String empId) {
		return reportDao.findByWriterReportCheckList(empId);
	} // findByWriterReportCheckList() end
	
	
	@Override
	public List<Report> findByMemberReportCheckList(String empId) {
		return reportDao.findByMemberReportCheckList(empId);
	} // findByMemberReportCheckList() end
	
	
	@Override
	public List<Report> findByReferenceReportCheckList(Map<String, Object> param) {
		return reportDao.findByReferenceReportCheckList(param);
	} // findByReferenceReportCheckList() end
	
} // class end
