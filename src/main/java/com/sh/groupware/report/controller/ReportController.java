package com.sh.groupware.report.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.attachment.model.service.AttachmentService;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.common.dto.Category;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.report.model.dto.ReferType;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportComment;
import com.sh.groupware.report.model.dto.ReportDetail;
import com.sh.groupware.report.model.dto.ReportMember;
import com.sh.groupware.report.model.dto.YN;
import com.sh.groupware.report.model.service.ReportService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private AttachmentService attachService;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	
	@GetMapping("/report.do")
	public String report(Model model, Authentication authentication) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		String deptCode = ((Emp) authentication.getPrincipal()).getDeptCode();
		model.addAttribute("empId", empId);
		
		List<ReportCheck> reportList = reportService.selectMyReportCheck(empId);
		model.addAttribute("reportList", reportList);
		
		List<ReportCheck> newReportList = reportService.selectMyReportCheck(empId);
		model.addAttribute("newReportList", newReportList);
		
		return "report/reportHome";
	} // report() end
	
	
//	@GetMapping("/reportForm.do")
//	public String reportForm(@RequestParam String no, Model model) {
//		log.debug("no = {}", no);
//		
//		List<ReportCheck> reportCheckList = reportService.findByReportNoReportCheckList(no);
//		List<Reference> referList = reportService.findByReportNoReference(no);
//		
//		model.addAttribute("reportCheckList", reportCheckList);
//		model.addAttribute("referList", referList);
//		return "report/reportForm";
//	} // reportForm() end
	
	
	@GetMapping("/reportCreateView.do")
	public String reportCreateView(Model model) {
		List<EmpDetail> empList = empService.selectAllEmpList();
		log.debug("empList = {}", empList);
		
		model.addAttribute("empList", empList);
		
		return "report/reportCreate";
	} // reportCreateView() end
	
	
	@PostMapping("/reportCreate.do")
	public String reportCreate(Report report, Authentication authentication, @RequestParam String _endDate, @RequestParam String reference, Model model) {
		log.debug("_endDate = {}", _endDate);
		log.debug("reference = {}", reference);
		log.debug("authentiation, {}", authentication);
		
		Emp loginMember = (Emp) authentication.getPrincipal();
		report.setWriter(loginMember.getEmpId());
		report.setEndDate(LocalDate.parse(_endDate));
		log.debug("report = {}", report);
		
		if (YN.Y == report.getDeptYn()) {
			List<Emp> empList = empService.findByDeptCodeEmpList(loginMember.getDeptCode());
			if (empList.size() > 0) {
				for (Emp emp : empList) {
					ReportMember reportMem = new ReportMember();
					reportMem.setEmpId(emp.getEmpId());
					report.addReportMember(reportMem);
				}
			}
		}
		
		if (ReferType.D == ReferType.valueOf(reference)) {
			for (Reference refer : report.getReferenceList()) {
				refer.setReferenceType(ReferType.D);
			}
		} // 참조 부서인 경우
		else {
			for (Reference refer : report.getReferenceList()) {
				refer.setReferenceType(ReferType.E);
			}
		} // 참조자인 경우
		
		int result = reportService.insertReport(report);
		
		List<Report> myReportList = reportService.findByWriterReportCheckList(loginMember.getEmpId());
		model.addAttribute("myReportList", myReportList);
		
		return "redirect:/report/reportCreateView.do";
	} // reportCreate() end
	
	
	@ResponseBody
	@PostMapping("/updateExcludeYn.do")
	public List<ReportCheck> updateExcludeYn(@RequestParam(value="report[]", required = false) List<String> report, @RequestParam(value = "unreport[]", required = false) List<String> unreport, @RequestParam String no, Model model) {
		log.debug("report = {}", report);
		log.debug("unreport = {}", unreport);
		log.debug("no = {}", no);
		
		int result = 0;
		if (report != null) {
			for (String empId : report) {
				Map<String, Object> param = new HashMap<>();
				param.put("no", no);
				param.put("empId", empId);
				result = reportService.updateExcludeYnN(param);
			}
		} // if (report.size() > 0) end
		
		if (unreport != null) {
			for (String empId : unreport) {
				Map<String, Object> param = new HashMap<>();
				param.put("no", no);
				param.put("empId", empId);
				result = reportService.updateExcludeYnY(param);
			}
		} // if (unreport.size() > 0) end
		
		List<ReportCheck> reportCheckList = reportService.findByReportNoReportCheckList(no);
		model.addAttribute("reportCheckList", reportCheckList);
		
		return reportCheckList;
	} // updateExcludeYn() end
	
	
	@PostMapping("/reportDetailEnroll.do")
	public String reportDetailEnroll(ReportDetail reportDetail, @RequestParam("upFile") List<MultipartFile> upFiles, Authentication authentication) {
		log.debug("reportDetail = {}", reportDetail);
		log.debug("upFiles = {}", upFiles);
		
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		reportDetail.setEmpId(empId);
		
		String saveDirectory = application.getRealPath("/resources/upload/report");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장 (서버 컴퓨터) 및 Attachment 객체 생성
		for (MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			
			if (upFile.getSize() > 0) {
				// 1. 저장				
				String renamedFilename = HelloSpringUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					upFile.transferTo(destFile); // 첨부파일을 서버컴퓨터에 저장하는 코드
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				// 2. attach 객체 생성 및 Board에 추가
				Attachment attach = new Attachment();
				attach.setRenameFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				attach.setCategory(Category.R);
				reportDetail.addAttachment(attach);
				log.debug("attach = {}", attach);
			} // if end
			
		} // foreach end
		log.debug("reportDetail = {}", reportDetail);
		
		int result = reportService.insertReportDetail(reportDetail);
		
		return  "redirect:/report/reportDetail.do?no=" + reportDetail.getReportNo();
	} // reportDetailEnroll() end
	
	
	@GetMapping("/reportDeptView.do")
	public String reportDeptView(@RequestParam String code, Model model) {
		log.debug("code = {}", code);
		List<Report> reportList = reportService.findByDeptCodeReportList(code);
		model.addAttribute("reportList", reportList);
		return "report/reportDept";
	} // reportDeptView() end
	
	
	@GetMapping("/reportElseView.do")
	public String reportElseView(Authentication authentication, Model model) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		
		List<Report> myReportMemberList = reportService.findByMemberReportCheckList(empId);
		model.addAttribute("myReportMemberList", myReportMemberList);
		
		return "report/reportElse";
	} // reportElseView() end
	
	
	@GetMapping("/reportReferView.do")
	public String reportReferView(Authentication authentication, Model model) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		String deptCode = ((Emp) authentication.getPrincipal()).getDeptCode();

		Map<String, Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("deptCode", deptCode);
		
		List<Report> myReportReferenceList = reportService.findByReferenceReportCheckList(param);
		model.addAttribute("myReportReferenceList", myReportReferenceList);
		
		return "report/reportRefer";
	} // reportReferView() end
	
	
	@GetMapping("/myListView.do")
	public String myListView(Authentication authentication, Model model) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		String deptCode = ((Emp) authentication.getPrincipal()).getDeptCode();

		List<Report> myReportList = reportService.findByWriterReportCheckList(empId);
		model.addAttribute("myReportList", myReportList);
		
		return "report/reportMyList";
	} // myListView() end
	
	
	@GetMapping("/reportDetail.do")
	public String reportDetail(@RequestParam String no, Model model) {
		model.addAttribute("no", no);
		
		List<ReportCheck> reportCheckList = reportService.findByReportNoReportCheckList(no);
		
		for (ReportCheck reportCheck : reportCheckList) {
			if (reportCheck.getDetailNo() != null) {
				Map<String, Object> param = new HashMap<>();
				param.put("category", Category.R);
				param.put("pkNo", reportCheck.getDetailNo());
				List<Attachment> attachList = attachService.selectAllAttachList(param);
				
				if (attachList.size() > 0) {
					for (Attachment attach : attachList) {
						reportCheck.addAttachment(attach);
					}
				} // 첨부파일 있는 경우
				
				List<ReportComment> commentList = reportService.selectAllReportComment(reportCheck.getDetailNo());
				if (commentList.size() > 0) {
					for (ReportComment comment : commentList) 
						reportCheck.addComment(comment);
				} // 댓글 있는 경우
				
			} // 작성된 보고 있는 경우 
		}
		
		List<Emp> referList = reportService.findByReportNoReference(no);
		
		model.addAttribute("reportCheckList", reportCheckList);
		model.addAttribute("referList", referList);
		return "report/reportDetail";
	}; // reportDetail() end
	

	@ResponseBody
	@GetMapping("/fileDownload.do")
	public Resource fileDownload(@RequestParam String no, HttpServletResponse response) {
		// renamedFilename으로 파일을 찾고, originalFilename으로 파일명 전송
		Attachment attach = attachService.selectOneAttachment(no);
		log.debug("attach = {}", attach);
		
		// FileUrlResource - file:~ 경로 사용
		String renamedFilename = attach.getRenameFilename();
		String originalFilename = attach.getOriginalFilename();
		// 한글 깨짐 대비
		try {
			// 톰캣의 기본 인코딩 변환 처리
			originalFilename = new String(originalFilename.getBytes("utf-8"), "iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage(), e);
		} 
		
		String saveDirectory = application.getRealPath("resources/upload/report");
		File downFile = new File(saveDirectory, renamedFilename);
		
		String location = "file:" + downFile; // downFile의 절대경로
		Resource resource = resourceLoader.getResource(location);
		log.debug("resource = {}", resource);
		log.debug("resource.exist() = {}", resource.exists()); // true
		log.debug("resource.getClass() = {}", resource.getClass()); // class org.springframework.core.io.FileUrlResource
		
		// 응답 헤더 설정
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + originalFilename);
		
		return resource;
	} // fileDownload() end
	
	
	@PostMapping("/reportDetailUpdate.do")
	public String reportDetailUpdate(ReportDetail reportDetail, @RequestParam("upFile") List<MultipartFile> upFiles, @RequestParam String noFile, Model model) {
		log.debug("reportDetail = {}", reportDetail);
		log.debug("noFile = {}", noFile);
		
		int result = 0;
		String saveDirectory = application.getRealPath("/resources/upload/report");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장 (서버 컴퓨터) 및 Attachment 객체 생성
		for (MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			
			if (upFile.getSize() > 0) {
				// 1. 저장				
				String renamedFilename = HelloSpringUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					upFile.transferTo(destFile); // 첨부파일을 서버컴퓨터에 저장하는 코드
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				// 2. attach 객체 생성 및 Board에 추가
				Attachment attach = new Attachment();
				attach.setRenameFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				attach.setCategory(Category.R);
				attach.setPkNo(reportDetail.getNo());
				reportDetail.addAttachment(attach);
				log.debug("attach = {}", attach);
			} // if end
			
		} // foreach end
		

		// 저장된 파일 삭제
		if (!"".equals(noFile)) {
			String[] attachNoArr = noFile.split(",");
			for (int i = 1; i < attachNoArr.length; i++) {
				Attachment attach = attachService.selectOneAttachment(attachNoArr[i]);
				
				File delFile = new File(saveDirectory, attach.getRenameFilename());
				
				if (delFile.exists())
					delFile.delete();
				
				result = attachService.deleteOneAttachment(attach.getNo());
			}
		}
		
		result = reportService.updateReportDetail(reportDetail);
		
		return "redirect:/report/reportDetail.do?no=" + reportDetail.getReportNo();
	} // reportDetailUpdate() end
	
	
	@PostMapping("/reportDetailDelete.do")
	public String reportDetailDelete(ReportDetail reportDetail) {
		log.debug("reportDetail = {}", reportDetail);
		int result = reportService.reportDetailDelete(reportDetail);
		return "redirect:/report/reportDetail.do?no=" + reportDetail.getReportNo();
	} // reportDetailDelete() end
	
	
	@PostMapping("/reportCommentEnroll.do")
	public String reportCommentEnroll(ReportComment reportComment, @RequestParam String reportNo, Authentication authentication) {
		log.debug("reportComment = {}", reportComment);
		
		String loginId = ((Emp) authentication.getPrincipal()).getEmpId();
		reportComment.setWriter(loginId);
		
		int result = reportService.insertReportComment(reportComment);
		
		return "redirect:/report/reportDetail.do?no=" + reportNo;
	} // reportCommentEnroll() end
	

	@ResponseBody
	@PostMapping("/reportCommentUpdate.do")
	public ReportComment reportCommentUpdate(@RequestParam String no, @RequestParam String detailNo, @RequestParam String content, Authentication authentication) {
		ReportComment reportComment = new ReportComment();
		reportComment.setNo(no);
		reportComment.setDetailNo(detailNo);
		reportComment.setContent(content);
		
		String loginId = ((Emp) authentication.getPrincipal()).getEmpId();
		reportComment.setWriter(loginId);
		
		int result = reportService.updateReportComment(reportComment);
		reportComment = reportService.findByNoReportComment(reportComment.getNo());
		log.debug("reportComment = {}", reportComment);
		
		return reportComment;
	} // reportCommentUpdate() end

	
	@ResponseBody
	@PostMapping("/reportCommentDelete.do")
	public int reportCommentDelete(@RequestParam String no, Authentication authentication) {
		log.debug("no = {}", no);
		
		int result = reportService.deleteReportComment(no);
		
		return result;
	} // reportCommentDelete() end
	
} // class end
