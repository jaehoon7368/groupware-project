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
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignType;
import com.sh.groupware.sign.model.dto.TripForm;
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
		List<Sign> mySignList = signService.findByMySignList(empId);
		model.addAttribute("myCreateSignList", myCreateSignList);
		model.addAttribute("mySignList", mySignList);
		return "sign/signHome";
	} // sign() end
	
	
	@GetMapping("/form/dayOff.do")
	public String dayOff() {
		return "sign/form/dayOffForm";
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
		return "sign/form/tripForm";
	} // trip() end
	
	
	@GetMapping("/form/product.do")
	public String product() {
		return "sign/form/productForm";
	} // product() end
	
	
	@GetMapping("/form/resignation.do")
	public String resignation() {
		return "sign/form/resignationForm";
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
	
	
	@GetMapping("/signDetail.do")
	public String signDetail(@RequestParam String no, @RequestParam String type, Model model) {
		log.debug("no = {}, type = {}", no, type);
		
		Sign sign = signService.findByNoSign(no);
		
		model.addAttribute("sign", sign);
		
		if ("D".equals(type)) {
			DayOffForm dayOff = signService.findBySignNoDayOffForm(no);
			model.addAttribute("dayOff", dayOff);
			return "sign/detail/dayOffDetail";
		} // 연차신청서
		
		if ("T".equals(type)) {
			TripForm trip = signService.findBySignNoTripForm(no);
			model.addAttribute("trip", trip);
			return "sign/detail/tripDetail";
		} // 출장신청서
		
		if ("P".equals(type)) {
			ProductForm product = signService.findBySignNoProductForm(no);
			model.addAttribute("product", product);
			return "sign/detail/productDetail";
		} // 비품신청서
		
		if ("R".equals(type)) {
			ResignationForm resignation = signService.findBySignNoResignationForm(no);
			model.addAttribute("resignation", resignation);
			return "sign/detail/resignationDetail";
		} // 사직서
		
		return "sign/signHome";
	} // signDetail() end
	
} // class end
