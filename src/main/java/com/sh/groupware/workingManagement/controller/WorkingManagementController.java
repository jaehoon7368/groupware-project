package com.sh.groupware.workingManagement.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.workingManagement.model.service.WorkingManagementService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/workingManagement")
public class WorkingManagementController {

	@Autowired
	private WorkingManagementService workingManagementService;
	
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy/MM/dd"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	//출근하기 버튼 누를시 근무 시작 일시,시간 저장
	@ResponseBody
	@PostMapping("/insertStartWork.do")
	public ResponseEntity<?> insertStartWork(Authentication authentication) {
	    Emp principal = (Emp) authentication.getPrincipal();
	    String empId = principal.getEmpId();
	    String time = now.format(dayf);
	    Map<String,Object> param = new HashMap<>();
	    Map<String,Object> state = new HashMap<>();
	    log.debug(time);
	    param.put("empId", empId);
	    param.put("time", time);

	    int checkStartwork = workingManagementService.checkStartwork(param);

	    if(checkStartwork == 0) {
	        int result = workingManagementService.insertStartWork(empId);
	        state.put("state", "성공");
	    } else {
	        state.put("state", "실패");
	    }
	    
	    return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(state);
	}
}
