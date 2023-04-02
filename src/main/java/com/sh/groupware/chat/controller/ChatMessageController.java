package com.sh.groupware.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
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
	
	@MessageMapping("/chat/{chatroomId}")
	@SendTo({"/app/chat/{chatroomId}"})
	public ChatLog chat(ChatLog chatLog,@DestinationVariable String chatroomId ,@RequestParam String empName) {
		log.debug("chatroomId ={}",chatroomId);
		log.debug("chatLog ={}",chatLog);
		log.debug("chatLog EMp{}",chatLog.getEmpId());
		
		int reulst = chatService.insertChatLog(chatLog);
		chatLog.setEmp(empService.selectEmpDetail(chatLog.getEmpId()));
		return chatLog;
	
	}
	
	
	
	@MessageMapping("/chat/lastCheck")
	public void lastCheck(ChatLog lastCheck) {
		//int result = chatService.updateLastCheck(lastCheck);
		
	}
	
}
