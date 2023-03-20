package com.sh.groupware.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reservation")
public class ReservationController {
	

	
	@GetMapping("/reservation.do")
	public String reservation() {
		
		return "reservation/reservation";
	}
	
	@GetMapping("/asset1.do")
	public String asset1 () {
		return "reservation/asset1";
	}
	 

}
