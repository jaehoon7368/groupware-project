package com.sh.groupware.emp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
