package com.sh.groupware.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;

import com.sh.groupware.chat.model.dto.ChatLog;
import com.sh.groupware.chat.model.dto.ChatRoom;

@Mapper
public interface ChatDao {

	String findChattroomIdbyMemberId(Map<String, Object> param);

	int createChatroom(ChatRoom chatRoom);

	List<ChatLog> findChatLogBychatroomId(String chatroomId);

	int insertChatLog(ChatLog chatLog);

	List<ChatLog> seletChatLogByempId(String empId);

	String selectYourIdBychatroomId(Map<String, Object> param);

	int updateLastCheck(ChatLog lastCheck);

	@Delete("delete from chat_room where chatroom_id = #{chatroomId}")
	int chatroomDelete(String chatroomId);


	

}
