package com.sh.groupware.sign.controller;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.groupware.dayOff.model.dto.DayOff;
import com.sh.groupware.dayOff.model.service.DayOffService;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.report.model.dto.YN;
import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.SignStatusDetail;
import com.sh.groupware.sign.model.dto.SignType;
import com.sh.groupware.sign.model.dto.Status;
import com.sh.groupware.sign.model.dto.TripForm;
import com.sh.groupware.sign.model.service.SignService;
import com.sh.groupware.workingManagement.model.dto.WorkingManagement;
import com.sh.groupware.workingManagement.model.service.WorkingManagementService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/sign")
public class SignController {
	
	@Autowired
	private SignService signService;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private WorkingManagementService workingService;
	
	@Autowired
	private DayOffService dayOffService;

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
	public String dayOff(Authentication authentication, Model model) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		double leaveCount = signService.findByEmpIdTotalCount(empId);
		
		model.addAttribute("leaveCount", leaveCount);
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
		int result = signService.insertSignDayOffForm(dayOffForm, sign);
		
		return "redirect:/sign/sign.do";
	} // dayOffCreate() end
	
	
	@GetMapping("/form/trip.do")
	public String trip() {
		return "sign/form/tripForm";
	} // trip() end
	
	
	@PostMapping("/tripCreate.do")
	public String tripCreate(TripForm tripForm, @RequestParam String emergency, Authentication authentication) {
		log.debug("tripForm = {}", tripForm);

		Emp loginMember = (Emp) authentication.getPrincipal();
		SignEntity sign = new SignEntity(
			null, 
			loginMember.getEmpId(), 
			loginMember.getDeptCode(), 
			loginMember.getJobCode(), 
			SignType.T, 
			null, 
			YN.valueOf(emergency),
			null
		);
		
		int result = signService.insertSignTripForm(tripForm, sign);
		
		return "redirect:/sign/sign.do";
	} // tripCreate() end
	
	
	@GetMapping("/form/product.do")
	public String product() {
		return "sign/form/productForm";
	} // product() end
	
	
	@PostMapping("/productCreate.do")
	public String productCreate(ProductForm productForm, @RequestParam String emergency, Authentication authentication) {
		log.debug("productForm = {}", productForm);
		
		Emp loginMember = (Emp) authentication.getPrincipal();
		SignEntity sign = new SignEntity(
			null, 
			loginMember.getEmpId(), 
			loginMember.getDeptCode(), 
			loginMember.getJobCode(), 
			SignType.P, 
			null, 
			YN.valueOf(emergency),
			null
		);
		int result = signService.insertSignProductForm(productForm, sign);
		
		
		return "redirect:/sign/sign.do";
	} // productCreate() end
	
	
	@GetMapping("/form/resignation.do")
	public String resignation() {
		return "sign/form/resignationForm";
	} // resignation() end
	
	
	@PostMapping("/resignationCreate.do")
	public String resignationCreate(ResignationForm resignation, @RequestParam String emergency, Authentication authentication) {
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
		int result = signService.insertSignResignationForm(resignation, sign);
		
		
		return "redirect:/sign/sign.do";
	} // resignationCreate() end
	
	
	@GetMapping("/signDetail.do")
	public String signDetail(@RequestParam String no, @RequestParam String type, Model model) {
		log.debug("no = {}, type = {}", no, type);
		
		Sign sign = signService.findByNoSign(no);
		
		model.addAttribute("sign", sign);
		
		if ("D".equals(type)) {
			double leaveCount = signService.findByEmpIdTotalCount(sign.getEmpId());
			log.debug("leaveCount = {}", leaveCount);
			DayOffForm dayOff = signService.findBySignNoDayOffForm(no);
			model.addAttribute("dayOff", dayOff);
			model.addAttribute("leaveCount", leaveCount);
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
	
	
	@PostMapping("/signStatusUpdate.do")
	public String signStatusUpdate(SignStatus signStatus) {
		log.debug("signStatus = {}", signStatus);
		int result = 0;
//		int result = signService.signStatusUpdate(signStatus);
		
		Sign sign = signService.findByNoSign(signStatus.getSignNo());
		log.debug("sign = {}", sign);
		List<SignStatusDetail> signStatusList = sign.getSignStatusList();
		log.debug("signStatusList = {}", signStatusList);
		
		for (int i = 0; i < signStatusList.size(); i++) {
			if (signStatus.getEmpId().equals(signStatusList.get(i).getEmpId())) {
				// 내 결제 상태 업데이트
				result = signService.updateMySignStatus(signStatus);
				
				// 내가 마지막 결재자인 경우
				if (i == signStatusList.size() - 1) {
					result = signService.updateSignComplete(sign.getNo());
					
					// 결재 양식에 따라 해당 테이블 업데이트
					switch (sign.getType()) {
					case D:
						DayOffForm dayOffForm = signService.findBySignNoDayOffForm(sign.getNo());
						log.debug("dayOffForm = {}", dayOffForm);
						double leaveCount = signService.findByEmpIdTotalCount(sign.getEmpId());
						log.debug("leaveCount = {}", leaveCount);
						
						DayOff dayOff = new DayOff(
							null, 
							sign.getEmpId(), 
							dayOffForm.getStartDate().getYear(),
							dayOffForm.getStartDate(),
							dayOffForm.getEndDate(),
							dayOffForm.getCount(),
							leaveCount - dayOffForm.getCount(),
							null
						);
						log.debug("dayOff = {}", dayOff);
						
						result = dayOffService.insertDayOff(dayOff);
						break;
					case T:
						TripForm trip = signService.findBySignNoTripForm(sign.getNo());
						log.debug("trip = {}", trip);
						
						WorkingManagement working = new WorkingManagement();
						working.setState("출장");
						working.setEmpId(sign.getEmpId());
						
						int betweenDays = (int) Duration.between(trip.getStartDate().atStartOfDay(), trip.getEndDate().atStartOfDay()).toDays();
						log.debug("betweenDays = {}", betweenDays);
						
						working.setRegDate(trip.getStartDate());
						result = workingService.insertRegDateState(working);
						
						if (betweenDays > 1) {
							for (int j = 1; j <= betweenDays; j++) {
								working.setRegDate(trip.getStartDate().plusDays(j));
								result = workingService.insertRegDateState(working);
							}
						}
						
						break;
					case R:
						ResignationForm resignation = signService.findBySignNoResignationForm(sign.getNo());
						log.debug("resignation = {}", resignation);
						
						Map<String, Object> param = new HashMap<>();
						param.put("endDate", resignation.getEndDate());
						param.put("empId", sign.getEmpId());
						
						result = empService.updateQuit(param);
						break;
					} // switch end
					
				} // if end
				// 내가 마지막 결재자가 아닌 경우
				else {
					// 결재인 경우에만 다음 결재자 결재 상태 업데이트
					if (Status.C == signStatus.getStatus()) {
						result = signService.updateNextSignStatus(signStatusList.get(i + 1).getNo());
					} // if end
				} // else end
				
			} // if end
		} // for end
		
		return "redirect:/sign/sign.do";
	} // signStatusUpdate() end
	
} // class end
