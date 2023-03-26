package com.sh.groupware.workingManagement.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.workingManagement.Calendar;
import com.sh.groupware.workingManagement.model.dto.WorkingManagement;
import com.sh.groupware.workingManagement.model.service.WorkingManagementService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/workingManagement")
public class WorkingManagementController {

	@Autowired
	private WorkingManagementService workingManagementService;
	
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy/MM/dd"); //날짜 패턴 변경
	DateTimeFormatter dayff = DateTimeFormatter.ofPattern("yy/MM"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	@GetMapping("/checkWorkTime.do")
	public ResponseEntity<WorkingManagement> checkWorkTime(Authentication authentication) {
		 Emp principal = (Emp) authentication.getPrincipal();
		 String empId = principal.getEmpId();
		 String time = now.format(dayf);
		 Map<String,Object> param = new HashMap<>();
		 param.put("empId", empId);
		 param.put("time", time);
		 
		 WorkingManagement work = workingManagementService.checkWorkTime(param);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(work);
	}
	
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
	
	//퇴근하기 버튼 누를시 퇴근시간 update
	@PostMapping("/updateEndWork.do")
	public ResponseEntity<?> updateEndWork(Authentication authentication){
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		String time = now.format(dayf);
		Map<String,Object> param = new HashMap<>();
		Map<String,Object> state = new HashMap<>();
		param.put("empId", empId);
		param.put("time", time);
		 
		WorkingManagement work = workingManagementService.checkWorkTime(param);
		
		if(work == null) {
			state.put("state","출근전");
		}else if(work.getEndWork() == null) {
			//퇴근시간 업데이트
			int result = workingManagementService.updateEndWok(param);
			state.put("state", "성공");	
		}
		else {
			 state.put("state", "실패");
		}
			
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(state);
	}
	
	//퇴근버튼 눌렀을시 오늘 근무시간 업데이트
	@PostMapping("/updateDayWorkTime.do")
	public ResponseEntity<?> updateDayWorkTime(Long daytime, Authentication authentication) {
		log.debug("daytime = {}", daytime);
	  	Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		String time = now.format(dayf);
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("time", time);
		param.put("daytime", daytime);
		Map<String,Object> state = new HashMap<>();
		int result = workingManagementService.updateDayWorkTime(param);
		if(result > 0)
			state.put("state", "성공");	
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(state);
	}
	
	// 달의 전체 workingManagement, 그 달의 주차별 시작,종료일 가져오기 (table에 뿌려주는 용도)
	@ResponseBody
	@GetMapping("/selectMonthWork.do")
	public ResponseEntity<?> selectMonthWork(String dateText,Authentication authentication){
		log.debug("dateText={}", dateText);
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		
		String time = now.format(dayff); //이번달
		
		String[] arr = dateText.split("\\.");
		String date = arr[0].substring(2) + "/" + arr[1] ;
		log.debug("date = {}",date);
		
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("date", date);
		param.put("time", time);
		
		 // 회원의 월별 근태현황 조회
		List<WorkingManagement> workList = workingManagementService.selectMonthWork(param);
		
		//이번달 누적 시간 가져오기
		int totalMonthTime = workingManagementService.totalMonthTime(param);
		
		Calendar cal = new Calendar();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
 	    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));
 	    Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);
		log.debug("weekDate = {}",weekDates);
	
		// 주간별 누적근무시간
		Map<String, Object> weekTime = new HashMap<>();

		// weekDates 맵의 모든 내부 맵을 순회합니다.
		for (String week : weekDates.keySet()) {

		    // 내부 맵에서 "start"와 "end" 값을 가져와서 새로운 맵에 추가합니다.
		    Map<String, Object> startEndMap = new HashMap<>();
		    startEndMap.put("empId", empId);
		    startEndMap.put("start", weekDates.get(week).get("start"));
		    startEndMap.put("end", weekDates.get(week).get("end"));
		    
		    //주간별 누적근무시간 가져오기
		    int workTimes = workingManagementService.selectWeekWorkTime(startEndMap);
		    
		    weekTime.put(week, workTimes);
		    weekDates.get(week).put("workTime", weekTime.get(week));
		    
		}

		
		Map<String, Object> response = new HashMap<>();
		response.put("workList", workList);
		response.put("weekDates", weekDates);
		response.put("totalMonthTime", totalMonthTime);

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(response);
	}
	
	// 주차 클릭시 start,end 사이 날짜 근무 가져오기
	@ResponseBody
	@GetMapping("/selectWeekDatas.do")
	public ResponseEntity<?> selectWeekDatas(String start, String end,Authentication authentication){
		log.debug("start = {}",start);
		log.debug("end = {}",end);
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("start", start);
		param.put("end", end);
		List<WorkingManagement> weekList = workingManagementService.selectWeekDatas(param);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(weekList);
	}
	
	// 금주의 누적시간 가져오기
	@GetMapping("/weekTotalTime.do")
	public ResponseEntity<?> weekTotalTime(String start, String end, Authentication authentication){
		log.debug("start = {}",start);
		log.debug("end = {}",end);
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("start", start);
		param.put("end", end);
		
		int weekTotalTime = workingManagementService.weekTotalTime(param);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(weekTotalTime);
	}
}
