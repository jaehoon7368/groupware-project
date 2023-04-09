package com.sh.groupware.chat.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.dto.ChatRoom;
import com.sh.groupware.chat.model.service.ChatService;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.todo.model.service.TodoService;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/chat")
@Controller
@Slf4j
public class ChatController {

	@Autowired
	private ChatService chatService;
	@Autowired
	private EmpService empService;
	@Autowired
	private TodoService todoService;
	
	@GetMapping("/chat.do")
	public void chat (Model model,Authentication authentication) {
		
		List<Emp> empList = empService.selectAllEmpAddTitleDept();
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		//사원아이디로 검색해서 채팅방 가져오기 
		List<ChatLog> chatLogs = chatService.seletChatLogByempId(empId);
		 model.addAttribute("empId",empId);
		 model.addAttribute("empList",empList);
		 model.addAttribute("chatLogs",chatLogs);
	}
	
	@ResponseBody
	@PostMapping("/selectEmpChat.do")
	public Map<String,Object> selectEmpChat(Model model,Authentication authentication,@RequestParam String empId) {
		String myEmpId = ((Emp) authentication.getPrincipal()).getEmpId();
		Map<String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("myEmpId", myEmpId);
		String chatroomId = chatService.findChattroomIdbyMemberId(param);
		List<ChatLog>chatLogs = new ArrayList<>();
		if(chatroomId == null) {
			chatroomId = generateRandomChatroomId();
			List<ChatRoom> chatRooms =Arrays.asList(
					new ChatRoom(chatroomId,empId, 0, null, null),
					new ChatRoom(chatroomId,myEmpId, 0, null, null));
			
			int result = chatService.createChatroom(chatRooms);
			log.debug("result = {}",result);
			log.debug("새 채팅방이 생성되었습니다.");
			
		}else {
			 chatLogs = chatService.findChatLogBychatroomId(chatroomId);
			param.put("chatLogs", chatLogs);
		}
	
		param.put("chatroomId", chatroomId);
		param.put("chatLogs",chatLogs);
		
		return param;
	}
	
	@GetMapping("/chatRoomPopUp.do")
	public void chatRoomPopUp (@RequestParam String chatroomId,Model model,Authentication authentication) {
		List <ChatLog> chatLogs = chatService.findChatLogBychatroomId(chatroomId);
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		Emp emp = empService.selectEmpDetail(empId);
		
		model.addAttribute("today", new Date());
		model.addAttribute("emp",emp);
		model.addAttribute("chatLogs",chatLogs);
	}
	@ResponseBody
//	@GetMapping("/selectEmpByEmpId.do")
	@GetMapping(path = "/selectEmpByEmpId.do", produces = "application/json")
	public Emp selectEmpByEmpId(@RequestParam String empId) {
		Emp emp = todoService.selectOneEmpByEmpId(empId);
		
		log.debug("emp 채팅 보낸 사람 {} ",emp);
		return emp;
	}
	@PostMapping("/chatroomDelete.do")
	public String chatroomDelete(@RequestParam String chatroomId) {
		log.debug("chatroomId={}",chatroomId);
		int result = chatService.chatroomDelete(chatroomId);
		
		return "redirect:/chat/chat.do";
	}
	
	
	
	
	/**
	 * 12자리의 영문자/숫자로 구성된 토큰 발행
	 */
	private String generateRandomChatroomId() {
		
		StringBuilder chatroomId = new StringBuilder();
		Random random = new Random();
		final int LEN = 12;
		// 반복처리
		for(int i = 0; i < LEN; i++) {
			// 숫자
			if(random.nextBoolean()) {
				chatroomId.append(random.nextInt(10));
			}
			// 영문자
			else {
				// 대문자
				if(random.nextBoolean()) {
					chatroomId.append((char) (random.nextInt(26) + 'A'));
				}
				// 소문자
				else {
					chatroomId.append((char) (random.nextInt(26) + 'a'));
				}
			}
		}
		return chatroomId.toString();
	}
}
