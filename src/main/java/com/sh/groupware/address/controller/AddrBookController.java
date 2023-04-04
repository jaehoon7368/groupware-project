package com.sh.groupware.address.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.groupware.address.model.service.AddrService;
import com.sh.groupware.emp.model.service.EmpService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/addr")
public class AddrBookController {

	@Autowired
	private AddrService addrService;

	@Autowired
	private EmpService empService;
	
	
	
	@GetMapping("/addrHome.do")
	public void addrHome() {
	}
	
	@GetMapping("/addrEnrollForm.do")
	public void addrEnroll() {
	}
	
	
	
	
	
	
	
}
