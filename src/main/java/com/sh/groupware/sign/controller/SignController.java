package com.sh.groupware.sign.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.report.model.dto.YN;
import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignType;
import com.sh.groupware.sign.model.service.SignService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/sign")
public class SignController {
	
	@Autowired
	private SignService signService;

	@GetMapping("/sign.do")
	public String sign(Model model, Authentication authentication) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		List<Sign> myCreateSignList = signService.findByMyCreateSignList(empId);
		model.addAttribute("myCreateSignList", myCreateSignList);
		return "sign/signHome";
	} // sign() end
	
	
	@GetMapping("/form/dayOff.do")
	public String dayOff() {
		return "form/dayOffForm";
	} // dayOff() end
	
	
	@PostMapping("/dayOffCreate.do")
	public String dayOffCreate(DayOffForm dayOffForm, @RequestParam String emergency, Authentication authentication) {
		log.debug("dayOffForm = {}", dayOffForm);
		log.debug("emergency = {}", emergency);

		Emp loginMember = (Emp) authentication.getPrincipal();
		SignEntity sign = new SignEntity(
			null, 
			loginMember.getEmpId(), 
			loginMember.getDeptCode(), 
			loginMember.getJobCode(), 
			SignType.D, 
			null, 
			YN.valueOf(emergency),
			null
		);
		int result = signService.insertSign(dayOffForm, sign);
		
		return "redirect:/sign/sign.do";
	} // dayOffCreate() end
	
	
	@GetMapping("/form/trip.do")
	public String trip() {
		return "form/tripForm";
	} // trip() end
	
	
	@GetMapping("/form/product.do")
	public String product() {
		return "form/productForm";
	} // product() end
	
	
	@GetMapping("/form/resignation.do")
	public String resignation() {
		return "form/resignationForm";
	} // resignation() end
	
	
	@PostMapping("/resignationCreate.do")
	public String resignationCreate(@RequestParam ResignationForm resignation, @RequestParam String emergency, Authentication authentication) {
		log.debug("resignationForm = {}", resignation);
		
		Emp loginMember = (Emp) authentication.getPrincipal();
		SignEntity sign = new SignEntity(
			null, 
			loginMember.getEmpId(), 
			loginMember.getDeptCode(), 
			loginMember.getJobCode(), 
			SignType.R, 
			null, 
			YN.valueOf(emergency),
			null
		);
		int result = signService.insertSign(resignation, sign);
		
		
		return "redirect:/sign/sign.do";
	} // resignationCreate() end
	
} // class end
