package com.sh.groupware.ws.controller;

import java.util.Map;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.sh.groupware.ws.model.dto.Payload;

import lombok.extern.slf4j.Slf4j;

/**
 * applicaton-destination-prefix로 지정한 요청처리
 */
@Controller
@Slf4j
public class StompController {

	@MessageMapping("/a")
	@SendTo("/topic/a") 
	public Map<String, Object> a(Map<String, Object> payload){
		log.debug("/app/a payload = {}", payload);
		
		// db 등록등 부가작업
		
		return payload;
	}
	
	@MessageMapping("/b") // /app/b
	@SendTo("/app/b") 
	public Map<String, Object> b(Map<String, Object> payload){
		log.debug("/app/b payload = {}", payload);
		
		// db 등록등 부가작업
		
		return payload;
	}
	
	
	@MessageMapping("/admin/notice")
	@SendTo("/app/notice")
	public Payload adminNotice(Payload payload) {
		log.debug("/admin/notice : payload = {}", payload);
		
		return payload;
	}
	
	@MessageMapping("/admin/notice/{memberId}")
	@SendTo("/app/notice/{memberId}")
	public Payload adminPersonalNotice(Payload payload, @DestinationVariable String memberId) {
		log.debug("/admin/notice/{} : payload = {}", memberId, payload);
		return payload;
	}
	
	
	
}
