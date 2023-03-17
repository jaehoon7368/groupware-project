package com.sh.groupware.emp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.service.EmpService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes({"loginEmp"})
public class EmpController {
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session) {
		log.debug("loginSuccess 핸들러 호출!");
		
		return "redirect:/home/home.do";
	}
	
	@GetMapping("emp/empHome.do")
	public void empHome() {}
	
	@GetMapping("emp/empEnroll.do")
	public void empInsertPage() {}
	
	@PostMapping("emp/empEnroll.do")
	public String empEnroll(Emp emp) {
		try {
			log.debug("emp = {}",emp);
			String rawPassword = emp.getPassword();
			String encodedPassword = passwordEncoder.encode(rawPassword);
			emp.setPassword(encodedPassword);
			log.debug("emp = {}", emp);
			
			int reasult = empService.insertEmp(emp);
			
		} catch (Exception e) {
			log.error("회원가입오류!", e);
			throw e;
		}
		log.trace("memberEnroll 끝!");
		return "redirect:/emp/empEnroll.do";
	}
	
	@GetMapping("/emp/passwordEncode.do")
	public void selectOneEmp() {
		Emp emp = empService.selectEmp();
		log.debug("enp = {}",emp);
		log.debug("empPassword={}",emp.getPassword());
		String rawPassword = emp.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		log.debug("encodedPassword = {}", encodedPassword);
		
	}

}
