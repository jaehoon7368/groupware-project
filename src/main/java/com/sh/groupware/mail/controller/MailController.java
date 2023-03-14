package com.sh.groupware.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mail")
public class MailController {

	@GetMapping("/mail.do")
	public String mail() {
		return "mail/mail";
	} // mail() end
	
} // class end
