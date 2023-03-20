package com.sh.groupware.report.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.groupware.dept.model.dto.Dept;
import com.sh.groupware.dept.model.service.DeptService;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.report.model.dto.YN;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.dto.ReportDetail;
import com.sh.groupware.report.model.dto.ReportMember;
import com.sh.groupware.report.model.dto.ReferType;
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
	private DeptService deptService;
	
	
	@GetMapping("/report.do")
	public String report(Model model, Authentication authentication) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		model.addAttribute("empId", empId);
		
		List<ReportCheck> reportList = reportService.selectMyReportCheck(empId);
		model.addAttribute("reportList", reportList);
		
		List<ReportCheck> newReportList = reportService.selectMyReportCheck(empId);
		
		return "report/reportHome";
	} // report() end
	
	
	@GetMapping("/reportForm.do")
	public String reportForm(@RequestParam String no, Model model) {
		log.debug("no = {}", no);
		
		List<ReportCheck> reportCheckList = reportService.findByReportNoReportCheckList(no);
		List<Reference> referList = reportService.findByReportNoReference(no);
		
		model.addAttribute("reportCheckList", reportCheckList);
		model.addAttribute("referList", referList);
		return "report/reportForm";
	} // reportForm() end
	
	
	@GetMapping("/reportCreateView.do")
	public String reportCreateView(Model model) {
		List<EmpDetail> empList = empService.selectAllEmpList();
		log.debug("empList = {}", empList);
		
		List<Dept> deptList = deptService.selectAllDept();
		log.debug("deptList = {}", deptList);
		
		model.addAttribute("empList", empList);
		model.addAttribute("deptList", deptList);
		
		return "report/reportCreate";
	} // reportCreateView() end
	
	
	@PostMapping("/reportCreate.do")
	public String reportCreate(Report report, Authentication authentication, @RequestParam String _endDate, @RequestParam String reference) {
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
		
		return "redirect:/report/reportCreateView.do";
	} // reportCreate() end
	
	
	@PostMapping("/updateExcludeYn.do")
	public String updateExcludeYn(@RequestParam(value="report[]", required = false) List<String> report, @RequestParam(value = "unreport[]", required = false) List<String> unreport, @RequestParam String no, Model model) {
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
		
		return "redirect:/report/reportForm.do?no=" + no;
	} // updateExcludeYn() end
	
	
	@PostMapping("/reportDetailEnroll.do")
	public String reportDetailEnroll(@RequestParam String reportNo, @RequestParam String content, Authentication authentication) {
		log.debug("reportNo = {}, content = {}", reportNo, content);
		
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		ReportDetail detail = new ReportDetail(null, reportNo, empId, content, null);
		
		int result = reportService.insertReportDetail(detail);
		
		return  "redirect:/report/report.do";
	} // reportDetailEnroll() end
	
	
	@GetMapping("/reportDeptView.do")
	public String reportDeptView(@RequestParam String code, Model model) {
		log.debug("code = {}", code);
		List<Report> reportList = reportService.findByDeptCodeReportList(code);
		model.addAttribute("reportList", reportList);
		return "report/reportDept";
	} // reportDeptView() end
	
} // class end
