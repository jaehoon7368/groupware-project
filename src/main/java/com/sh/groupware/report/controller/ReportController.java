package com.sh.groupware.report.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.groupware.dept.model.dto.Dept;
import com.sh.groupware.dept.model.service.DeptService;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
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
	
	
	@GetMapping("/reportCreate.do")
	public String reportCreate(Model model) {
		List<EmpDetail> empList = empService.selectAllEmpList();
		log.debug("empList = {}", empList);
		
		List<Dept> deptList = deptService.selectAllDept();
		log.debug("deptList = {}", deptList);
		
		model.addAttribute("empList", empList);
		model.addAttribute("deptList", deptList);
		
		return "report/reportCreate";
	} // reportCreate() end
	
} // class end
