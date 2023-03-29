package com.sh.groupware.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommonController {

	@GetMapping("/home/home.do")
	public String home() {
		return "common/home";
	} // home() end
	
	//최근 알림 컨트롤러
	
	
	
	
} // class end
