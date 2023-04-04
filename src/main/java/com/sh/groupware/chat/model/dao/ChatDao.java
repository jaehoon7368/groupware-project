package com.sh.groupware.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.dto.ChatRoom;
import com.sh.groupware.ws.model.dto.Payload;

@Mapper
public interface ChatDao {

	String findChattroomIdbyMemberId(Map<String, Object> param);

	int createChatroom(ChatRoom chatRoom);

	List<ChatLog> findChatLogBychatroomId(String chatroomId);

	int insertChatLog(ChatLog chatLog);

	List<ChatLog> seletChatLogByempId(String empId);

	String selectYourIdBychatroomId(Map<String, Object> param);

	int updateLastCheck(ChatLog lastCheck);


	

}
