package com.sh.groupware.emp.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.workingManagement.model.dto.WorkingManagement;
import com.sh.groupware.workingManagement.model.service.WorkingManagementService;
import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.attachment.model.service.AttachmentService;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.dept.model.dto.Dept;
import com.sh.groupware.dept.model.service.DeptService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
@SessionAttributes({"loginEmp"})
public class EmpController {
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private AttachmentService attachService;
	
	@Autowired
	private WorkingManagementService workingManagementService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy/MM/dd"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	//로그인 기능
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session) {
		log.debug("loginSuccess 핸들러 호출!");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		
		EmpDetail loginMember = empService.selectEmpDetail(empId);

		Attachment attach = attachService.selectEmpProfile(empId);
		loginMember.setAttachment(attach);
		
		session.setAttribute("loginMember", loginMember);
		
		List<Dept> deptList = deptService.selectAllDept();
		session.setAttribute("deptList", deptList);
		
		return "redirect:/home/home.do";
	}
	
	//로그아웃 기능
	@PostMapping("/empLogout.do")
	public String empLogout(SessionStatus status) {
		
		if(!status.isComplete())
			status.setComplete();
		
		return "redirect:/";
	}
	
	//내 근태현황
	@GetMapping("/empHome.do")
	public void empHome() {}
	
	//인사정보 등록 페이지
	@GetMapping("/empEnroll.do")
	public void empInsertPage() {}
	
	//인사정보 등록하기
	@PostMapping("/empEnroll.do")
	public String empEnroll(Emp emp,@RequestParam("file") MultipartFile file) {
		try {
			log.debug("emp = {}",emp);
			String rawPassword = emp.getPassword();
			String encodedPassword = passwordEncoder.encode(rawPassword);
			emp.setPassword(encodedPassword);
			log.debug("emp = {}", emp);
			
			//프로필사진 업로드
			String saveDirectory = application.getRealPath("/resources/upload/emp");
			log.debug("saveDirectory = {}", saveDirectory);
			log.debug("file = {}", file);
			if(file.getSize() > 0) {
				// 1. 저장 
				String pkNo = emp.getEmpId();
				String renamedFilename = HelloSpringUtils.renameMultipartFile(file);
				String originalFilename = file.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					file.transferTo(destFile);
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				Attachment attach = new Attachment();
				attach.setRenameFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				attach.setPkNo(pkNo);
				emp.setAttachment(attach);
				log.debug("attach = {}",attach);
				
			}
			int reasult = empService.insertEmp(emp);
				
			
		} catch (Exception e) {
			log.error("인사정보 등록 오류!", e);
			throw e;
		}
		log.trace("empEnroll 끝!");
		return "redirect:/emp/empEnroll.do";
	}
	
	@GetMapping("/empInfo.do")
	public void empInfo(Model model,Authentication authentication) {
		log.debug("authentication = {}", authentication);
		Emp principal = (Emp) authentication.getPrincipal();
		
		String empId = principal.getEmpId();
		//내 인사정보 가져오기
		EmpDetail emp = empService.selectEmpDetail(empId);
		//내 인사정보 사진 가져오기
		Attachment attach = attachService.selectEmpProfile(empId);
		log.debug("emp = {}",emp);
		log.debug("attach={}",attach);
		model.addAttribute("emp", emp);
		model.addAttribute("attach", attach);
		
	}
	
	@PostMapping("/empInfo.do")
	public String empUpdate(Emp emp,Authentication authentication) {
		log.debug("emp={}",emp);
		// 비밀번호 암호화 처리
		String rawPassword = emp.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		emp.setPassword(encodedPassword);
		
		int result = empService.empUpdate(emp);
		
		// 2. security context의 인증객체 갱신
		Emp newEmp = emp;
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
				newEmp,
				authentication.getCredentials(),
				authentication.getAuthorities()
		);
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		
		return "redirect:/emp/empInfo.do";
	}
	
	//내 연차내역 페이지 불러오기
	@GetMapping("/empAnnual.do")
	public void empAnnual(Model model,Authentication authentication) {
		Emp principal = (Emp) authentication.getPrincipal();
		
		String empId = principal.getEmpId();
		
	}
	
	//전사 인사정보
	@GetMapping("/empAllInfo.do")
	public void empAllInfo(Model model) {
		List<EmpDetail> empList = empService.selectEmpAll();
		
		model.addAttribute("empList", empList);
	}

}
