package com.sh.groupware.report.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {

	@GetMapping("/report.do")
	public String report() {
		return "report/reportHome";
	} // report() end
	
	@GetMapping("/reportForm.do")
	public String reportForm() {
		return "report/reportForm";
	} // reportForm() end
	
	@GetMapping("/reportCreate.do")
	public String reportCreate() {
		return "report/reportCreate";
	} // reportCreate() end
	
} // class end
