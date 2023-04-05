package com.sh.groupware.chat.model.service;

import java.util.List;
import java.util.Map;

import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.dto.ChatRoom;
import com.sh.groupware.ws.model.dto.Payload;

public interface ChatService {

	String findChattroomIdbyMemberId(Map<String, Object> param);

	int createChatroom(List<ChatRoom> chatMembers);

	List<ChatLog> findChatLogBychatroomId(String chatroomId);

	int insertChatLog(ChatLog chatLog);

	List<ChatLog> seletChatLogByempId(String empId);

	String selectYourIdBychatroomId(Map<String, Object> param);

	int updateLastCheck(ChatLog lastCheck);


}
