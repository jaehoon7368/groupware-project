package com.sh.groupware.workingManagement.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.groupware.common.attachment.model.service.AttachmentService;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
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
	
	@Autowired
	private AttachmentService attachService;
	
	@Autowired
	private EmpService empService;
	
	DateTimeFormatter dayff = DateTimeFormatter.ofPattern("yy-MM"); //날짜 패턴 변경
	
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy-MM-dd"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	// 근태관리 로드될시 금일 근무 기록 조회
	@GetMapping("/checkWorkTime.do")
	public ResponseEntity<WorkingManagement> checkWorkTime(Authentication authentication) {
		 Emp principal = (Emp) authentication.getPrincipal();
		 String empId = principal.getEmpId();
		 String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
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
	    String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
	    Map<String,Object> param = new HashMap<>();
	    Map<String,Object> state = new HashMap<>();
	    log.debug(time);
	    param.put("empId", empId);
	    param.put("time", time);

	    WorkingManagement work = workingManagementService.checkWorkTime(param); //금일 출근기록이 있는지 확인

	    if(work == null) {
	        int result = workingManagementService.insertStartWork(empId); // insert
	        state.put("state", "성공");
	    }else if(work.getState().equals("반차")) {
	    	int result = workingManagementService.updateStartWork(param); //반차일시 반차 행 update
			state.put("state", "성공");
		}else if(work.getState().equals("출장")) {
			state.put("state", "출장");
		}else if(work.getState().equals("연차")) {
			state.put("state", "연차");
	    }else {
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
		log.debug("work = {}",work);
		
		if(work == null) {
			state.put("state","출근전");
		}else if(work.getState().equals("출장")) {
			state.put("state", "출장");
		}else if(work.getState().equals("연차")) {
			state.put("state", "연차");
		}
		else if(work.getEndWork() == null || work.getState().equals("반차")) {
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
	public ResponseEntity<?> updateDayWorkTime(Long daytimes, Authentication authentication) {
		log.debug("daytime = {}", daytimes);
		
		long daytime = daytimes; // 기본근무시간
		long overtime = 0; //연장근무시간
		
		// 5시간 이상 일했을 시 점심시간 1시간 제외
		if(daytimes > 18000000) {
			daytime = daytimes - 3600000;
		}
		
		//근무시간이 8시간이 넘었을때 기본근무시간과 연장근무시간 처리
		if(daytime > 28800000) {
			overtime = daytime - 28800000;
			daytime = 28800000;
		}
		
	  	Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		String time = now.format(dayf);
		
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("time", time);
		param.put("daytime", daytime);
		param.put("overtime", overtime);
		
		WorkingManagement work = workingManagementService.checkWorkTime(param);
		int result = 0;
		if(work.getState().equals("반차")) {
			result = workingManagementService.updateDayWorkTimeHalf(param); //반차 근무시간 업데이트시 4시간 추가 
		}else {
			result = workingManagementService.updateDayWorkTime(param); // 금일 근무시간 업데이트
		}
		
		Map<String,Object> state = new HashMap<>();
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
		log.debug("dateText={}", dateText); //2023.04
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
								
		Calendar cal = new Calendar();
 	    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));
 	    log.debug("currentDate = {}",currentDate);
 	    Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);
		log.debug("weekDate = {}",weekDates);
	
		// 주간별 누적근무시간
		Map<String, Object> weekTime = new HashMap<>();

		// weekDates 맵의 모든 내부 맵을 순회
		for (String week : weekDates.keySet()) {

		    // 내부 맵에서 "start"와 "end" 값을 가져와서 새로운 맵에 추가
		    Map<String, Object> startEndMap = new HashMap<>();
		    startEndMap.put("empId", empId);
		    startEndMap.put("start", weekDates.get(week).get("start"));
		    startEndMap.put("end", weekDates.get(week).get("end"));
		    
		    //주간별 누적 기본 근무시간 가져오기
		    int workTimes = workingManagementService.selectWeekWorkTime(startEndMap);
		    
		    //주간별 연장 근무시간 가져오기
		    int weekOverTime = workingManagementService.selectWeekOverTime(startEndMap);
		    
		    weekTime.put(week, workTimes);
		    weekTime.put(week+"overtime", weekOverTime);
		    weekDates.get(week).put("workTime", weekTime.get(week));
		    weekDates.get(week).put("workOverTime", weekTime.get(week+"overtime"));
		    
		}

		Map<String, Object> response = new HashMap<>();
		response.put("weekDates", weekDates);

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
	
	// 이번달, 금주의 누적시간 가져오기
	@GetMapping("/weekTotalTime.do")
	public ResponseEntity<?> weekTotalTime(String start, String end, Authentication authentication){
		log.debug("start = {}",start);
		log.debug("end = {}",end);
		Emp principal = (Emp) authentication.getPrincipal();
		String empId = principal.getEmpId();
		
		String monthTime = now.format(dayff);
		
		
		Map<String,Object> param = new HashMap<>();
		Map<String,Object> time = new HashMap<>();
		param.put("empId", empId);
		param.put("start", start);
		param.put("end", end);
		param.put("monthTime", monthTime);
		
		// 금주 누적시간 가져오기
		int weekTotalTime = workingManagementService.weekTotalTime(param);
		time.put("weekTotalTime",weekTotalTime);
		
		// 금주 연장시간 가져오기
		int weekOverTime = workingManagementService.selectWeekOverTime(param);
		time.put("weekOverTime",weekOverTime);
		
		//이번달 기본 누적 시간 가져오기
		int totalMonthTime = workingManagementService.totalMonthTime(param);
		time.put("totalMonthTime", totalMonthTime);
		
		//이번달 연장 근무 시간 가져오기
		int totalMonthOverTime = workingManagementService.monthOverTime(param);
		time.put("totalMonthOverTime", totalMonthOverTime);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(time);
	}
	
	@GetMapping("/empDeptView.do")
	public String empDeptView(@RequestParam String code, Model model) {
		model.addAttribute("deptCode", code);
		return "emp/empDept";
	}
	
	
	//부서별 월,주간 근태현황 불러오기
	@ResponseBody
	@GetMapping("/selectDeptWork.do")
	public ResponseEntity<?> selectDeptWork(String dateText, String deptCode) {
	    String[] arr = dateText.split("\\.");
	    String date = arr[0].substring(2) + "/" + arr[1];

	    Map<String,Object> param = new HashMap<>();
	    param.put("date",date);
	    param.put("deptCode", deptCode);

	    Calendar cal = new Calendar();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	    
	    List<EmpDetail> empList = empService.selectEmpDeptList(deptCode);
	    log.debug("empList = {}",empList);

	    List<Map<String, Object>> workList = new ArrayList<>();

	    for(EmpDetail emp : empList) {
	        Map<String, Object> work = new HashMap<>();
	        List<Map<String, Object>> weekDatesList = new ArrayList<>();
	        work.put("name", emp.getName()); // 회원 이름
	        work.put("jobTitle", emp.getJobTitle()); // 회원 직급
	        work.put("deptTitle", emp.getDeptTitle()); // 회원 부서
	        
	        // profile있을 시 프로필 보여주고 없으면 기본프로필 보여주기
	        String renameFilename = emp.getRenameFilename();
	        if(renameFilename == null) {
	        	work.put("profile", "default.png");
	        }else {
	        	work.put("profile", emp.getRenameFilename());
	        }

	        Map<String, Object> startEndMap = new HashMap<>();
	        startEndMap.put("empId", emp.getEmpId()); // 회원 pk no
	        startEndMap.put("monthTime", date); //선택한 달 ex)23/03

	        // 선택한 달의 기본 누적근무 시간
	        int monthWorkTime = workingManagementService.totalMonthTime(startEndMap);
	        work.put("monthWorkTime", monthWorkTime);

	        // 선택한 달의 연장 누적근무 시간
	        int monthOverTime = workingManagementService.monthOverTime(startEndMap);
	        work.put("monthOverTime", monthOverTime);

	        // 선택한 달의 주차별 시작,끝날짜
	        Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);

	        for (String week : weekDates.keySet()) {
	            startEndMap.put("start", weekDates.get(week).get("start"));
	            startEndMap.put("end", weekDates.get(week).get("end"));

	            int workTimes = workingManagementService.selectWeekWorkTime(startEndMap);
	            int overTimes = workingManagementService.selectWeekOverTime(startEndMap);

	            Map<String, Object> weekMap = new HashMap<>();
	            weekMap.put("week", week);
	            weekMap.put("workTime", workTimes);
	            weekMap.put("overTime", overTimes);
	            weekMap.put("start", weekDates.get(week).get("start"));
	            weekMap.put("end", weekDates.get(week).get("end"));

	            weekDatesList.add(weekMap);
	        }

	        work.put("weekDates", weekDatesList);
	        workList.add(work);
	    }

	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
	            .body(workList);
	}
	
	@ResponseBody
	@GetMapping("/searchEmpDept.do")
	public ResponseEntity<?> searchEmpDept( String dateText, String deptCode, String searchType, String searchKeyword) {
		log.debug("dateText = {}",dateText);
		log.debug("deptCode = {}",deptCode);
		log.debug("searchType = {}",searchType);
		log.debug("searchKeyword = {}",searchKeyword);
		
		String[] arr = dateText.split("\\.");
		    String date = arr[0].substring(2) + "/" + arr[1];

		    Map<String,Object> param = new HashMap<>();
		    param.put("date",date);
		    param.put("deptCode", deptCode);
		    param.put("searchType", searchType);
		    param.put("searchKeyword", searchKeyword);

		    Calendar cal = new Calendar();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
		    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));

		    List<EmpDetail> empList = empService.empFinderDeptList(param);
		    log.debug("empList = {}",empList);

		    List<Map<String, Object>> workList = new ArrayList<>();

		    for(EmpDetail emp : empList) {
		        Map<String, Object> work = new HashMap<>();
		        List<Map<String, Object>> weekDatesList = new ArrayList<>();
		        work.put("name", emp.getName()); // 회원 이름
		        work.put("jobTitle", emp.getJobTitle()); // 회원 직급
		        work.put("deptTitle", emp.getDeptTitle()); // 회원 부서
		        
		        // profile있을 시 프로필 보여주고 없으면 기본프로필 보여주기
		        String renameFilename = emp.getRenameFilename();
		        if(renameFilename == null) {
		        	work.put("profile", "default.png");
		        }else {
		        	work.put("profile", emp.getRenameFilename());
		        }

		        Map<String, Object> startEndMap = new HashMap<>();
		        startEndMap.put("empId", emp.getEmpId()); // 회원 pk no
		        startEndMap.put("monthTime", date); //선택한 달 ex)23/03

		        // 선택한 달의 기본 누적근무 시간
		        int monthWorkTime = workingManagementService.totalMonthTime(startEndMap);
		        work.put("monthWorkTime", monthWorkTime);

		        // 선택한 달의 연장 누적근무 시간
		        int monthOverTime = workingManagementService.monthOverTime(startEndMap);
		        work.put("monthOverTime", monthOverTime);

		        // 선택한 달의 주차별 시작,끝날짜
		        Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);

		        for (String week : weekDates.keySet()) {
		            startEndMap.put("start", weekDates.get(week).get("start"));
		            startEndMap.put("end", weekDates.get(week).get("end"));

		            int workTimes = workingManagementService.selectWeekWorkTime(startEndMap);
		            int overTimes = workingManagementService.selectWeekOverTime(startEndMap);

		            Map<String, Object> weekMap = new HashMap<>();
		            weekMap.put("week", week);
		            weekMap.put("workTime", workTimes);
		            weekMap.put("overTime", overTimes);
		            weekMap.put("start", weekDates.get(week).get("start"));
		            weekMap.put("end", weekDates.get(week).get("end"));

		            weekDatesList.add(weekMap);
		        }

		        work.put("weekDates", weekDatesList);
		        workList.add(work);
		    }

		    return ResponseEntity.ok()
		            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
		            .body(workList);
	}
}
