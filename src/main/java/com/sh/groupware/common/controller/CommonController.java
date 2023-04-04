package com.sh.groupware.common.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sh.groupware.common.dto.RecentNotification;
import com.sh.groupware.common.service.CommonService;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.report.model.dto.ReportCheck;
import com.sh.groupware.report.model.service.ReportService;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.service.SignService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommonController {
	@Autowired
	private CommonService commonService;

	@Autowired
	private SignService signService;

	@Autowired
	private ReportService reportService;
	
	//최근 알림 컨트롤러
	@GetMapping("/home/home.do")
	public String home(Model model,Authentication authentication) {
		log.debug("이거 진짜 되는거야 ?");
		
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		log.debug("empId= {}",empId);
		List<RecentNotification> reNotis = commonService.selectAllReNoti(); 
		log.debug("reNotis={} ",reNotis);
		
		// 결재 대기 문서
		List<Sign> mySignList = signService.findByMySignList(empId);
		
		// 보고
		List<ReportCheck> reportList = reportService.selectMyReportCheck(empId);
		
		// 남은 시간 계산 
		for(RecentNotification reNoti :reNotis ) {
			LocalDateTime past = reNoti.getRegDate();
			LocalDateTime now = LocalDateTime.now();
			Duration diff = Duration.between(past, now);
			long hours = diff.toHours();
			long minutes = diff.toMinutes();
			reNoti.setHour(hours);
			reNoti.setMin(minutes);
		}
		
		
		model.addAttribute("reNotis",reNotis);
		model.addAttribute("mySignList", mySignList);
		model.addAttribute("reportList", reportList);
		
		return "common/home";
	} // home() end
	
	
	
	
} // class end
