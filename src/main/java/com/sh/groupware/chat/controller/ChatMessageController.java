package com.sh.groupware.chat.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.service.ChatService;
import com.sh.groupware.emp.model.service.EmpService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatMessageController {

	@Autowired
	private ChatService chatService;
	@Autowired
	private EmpService empService;
	@Autowired
	SimpMessagingTemplate simpleMessageingTemplate;
	
	@MessageMapping("/chat/{chatroomId}")
	@SendTo({"/app/chat/{chatroomId}"})
	public ChatLog chat(ChatLog chatLog,@DestinationVariable String chatroomId ,@RequestParam String empName) {
		log.debug("chatroomId ={}",chatroomId);
		log.debug("chatLog ={}",chatLog);
		log.debug("chatLog EMp{}",chatLog.getEmpId());
		
		int reulst = chatService.insertChatLog(chatLog);
		chatLog.setEmp(empService.selectEmpDetail(chatLog.getEmpId()));
		
		String empId = chatLog.getEmpId();
		Map <String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("chatroomId", chatroomId);
		
		
		String yourId = chatService.selectYourIdBychatroomId(param);
		//상대방과 나의  채팅목록  소켓 연결
		simpleMessageingTemplate.setDefaultDestination("/queue/default");
		
		simpleMessageingTemplate.convertAndSend("/app/chat/" + empId + "/chatList", chatLog);
		simpleMessageingTemplate.convertAndSend("/app/chat/" + yourId + "/chatList", chatLog);
		
		return chatLog;
	}
	
	
	
	@MessageMapping("/chat/lastCheck")
	@SendTo("/app/chat/{chatroomId}")
	public void lastCheck(@Payload ChatLog lastCheck) {
		int result = chatService.updateLastCheck(lastCheck);
		log.debug("lastCheck= {}" ,lastCheck);
		
		String empId = lastCheck.getEmpId();
		String chatroomId = lastCheck.getChatroomId();
		Map <String,Object> param = new HashMap<>();
		param.put("empId", empId);
		param.put("chatroomId", chatroomId);
		String yourId = chatService.selectYourIdBychatroomId(param);
		//상대방과 나의  채팅목록  소켓 연결
		simpleMessageingTemplate.setDefaultDestination("/queue/default");
		simpleMessageingTemplate.convertAndSend("/app/chat/" + empId + "/chatList", lastCheck);
		simpleMessageingTemplate.convertAndSend("/app/chat/" + yourId + "/chatList", lastCheck);
		
	
	}
	
}
