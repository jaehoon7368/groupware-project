package com.sh.groupware.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.chat.model.dao.ChatDao;
import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.dto.ChatRoom;
import com.sh.groupware.common.dao.CommonDao;
import com.sh.groupware.todo.model.dao.TodoDao;
import com.sh.groupware.ws.model.dto.Payload;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private TodoDao todoDao;
	
	@Override
	public String findChattroomIdbyMemberId(Map<String, Object> param) {
		return chatDao.findChattroomIdbyMemberId(param);
	}
	@Override
	public int createChatroom(List<ChatRoom> chatRooms) {
		int result =0;
		
		for(ChatRoom chatRoom : chatRooms) {
			result = chatDao.createChatroom(chatRoom); 
		}
		
		return result;
	}
	@Override
	public List<ChatLog> findChatLogBychatroomId(String chatroomId) {
		List <ChatLog> chatLogs =chatDao.findChatLogBychatroomId(chatroomId);
		if(!chatLogs.isEmpty()) {
			for(ChatLog chatLog : chatLogs) {
				String empId = chatLog.getEmpId();
				chatLog.setEmp(commonDao.selectOneEmpTitleJobByEmpId(empId));
				chatLog.getEmp().setAttachment(todoDao.selectOneAttachmentByEmpId(empId));
			}
		}
		return chatLogs;
	}
	@Override
	public int insertChatLog(ChatLog chatLog) {
		return chatDao.insertChatLog(chatLog);
	}
	
	@Override
	public List<ChatLog> seletChatLogByempId(String empId) {
		List <ChatLog> chatLogs =chatDao.seletChatLogByempId(empId);
		if(!chatLogs.isEmpty()) {
			for(ChatLog chatLog : chatLogs) {
				empId =chatLog.getEmpId();
				chatLog.setEmp(commonDao.selectOneEmpTitleJobByEmpId(empId));
				chatLog.getEmp().setAttachment(todoDao.selectOneAttachmentByEmpId(empId));
			}
		}
		return chatLogs;
		}
	@Override
	public String selectYourIdBychatroomId(Map<String, Object> param) {
		return chatDao.selectYourIdBychatroomId(param);
	}
	@Override
	public int updateLastCheck(ChatLog lastCheck) {
		return chatDao.updateLastCheck(lastCheck);
	}
	@Override
	public int chatroomDelete(String chatroomId) {
		return chatDao.chatroomDelete(chatroomId);
	}
	
	
}
