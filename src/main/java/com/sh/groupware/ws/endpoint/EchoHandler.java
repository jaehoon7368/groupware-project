package com.sh.groupware.ws.endpoint;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class EchoHandler extends TextWebSocketHandler{

	
	List<WebSocketSession> sessionList = new CopyOnWriteArrayList<>(); // 동기화처리 List 쓰기작업시 별도의 복사본을 생성해 작업
	
	//오픈
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.debug("[현재 세션수 {}] 세션{} 연결!",sessionList.size(),session.getId());
		
	}
	
	//클로즈
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.debug("[현재 세션수 {}] 세션{} 해제!",sessionList.size(),session.getId());
		
	}
	
	//메시지
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("{} 로 부터 메시지  - {} ",session.getId(),message.getPayload());  //전송할 내용 페이로드 
		
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
			
		}
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.error(exception.getMessage(),exception);
	}
	
	
	
	
	
	
	
	
	
}
