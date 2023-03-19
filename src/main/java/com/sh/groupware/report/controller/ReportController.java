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
import com.sh.groupware.report.model.dto.Type;
import com.sh.groupware.report.model.dto.YN;
import com.sh.groupware.report.model.dto.Reference;
import com.sh.groupware.report.model.dto.Report;
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
	public String report() {
		return "report/reportHome";
	} // report() end
	
	
	@GetMapping("/reportForm.do")
	public String reportForm() {
		return "report/reportForm";
	} // reportForm() end
	
	
	@GetMapping("/reportCreateView.do")
	public String reportCreate(Model model) {
		List<EmpDetail> empList = empService.selectAllEmpList();
		log.debug("empList = {}", empList);
		
		List<Dept> deptList = deptService.selectAllDept();
		log.debug("deptList = {}", deptList);
		
		model.addAttribute("empList", empList);
		model.addAttribute("deptList", deptList);
		
		return "report/reportCreate";
	} // reportCreate() end
	
	
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
		
		if (ReferType.D.name().equals(reference)) {
			List<String> referenceDept = report.getReferenceDept();
			if (referenceDept.size() > 0) {
				for (String dept : referenceDept) {
					log.debug("dept = {}", dept);
					Map<String, Object> param = new HashMap<>();
					param.put("deptCode", dept);
					param.put("empId", loginMember.getEmpId());
					
					List<Emp> empList = empService.findByDeptCodeEmpIdEmpList(param);
					if (empList.size() > 0) {
						for (Emp emp : empList) {
							Reference refer = new Reference();
							refer.setReferenceType(ReferType.D);
							refer.setEmpId(emp.getEmpId());
							refer.setDeptCode(dept);
							report.addReference(refer);
						}
					} // empList 있는 경우
					else {
						Reference refer = new Reference();
						refer.setReferenceType(ReferType.D);
						refer.setDeptCode(dept);
						report.addReference(refer);
					} // empList 없는 경우
				}
			} // referenceDept 있는 경우
		} // 참조 부서 선택한 경우
		else {
			List<Reference> referenceList = report.getReferenceList();
			if (referenceList.size() > 0) {
				for (Reference refer : referenceList) {
					refer.setReferenceType(ReferType.E);
				}
			}
		} // 참조자 선택한 경우
		
		int result = reportService.insertReport(report);
		
		return "redirect:/report/reportCreateView.do";
	} // reportCreate() end
	
} // class end
