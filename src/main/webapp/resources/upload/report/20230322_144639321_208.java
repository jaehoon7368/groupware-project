package com.sh.spring.chat.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.spring.chat.model.dto.ChatLog;
import com.sh.spring.chat.model.dto.ChatMember;

@Mapper
public interface ChatDao {

	@Select("select chatroom_id from chat_member where member_id = #{memberId}") 
	String findChatroomIdByMemberId(String memberId);

	@Insert("insert into chat_member (chatroom_id, member_id) values (#{chatroomId}, #{memberId})")
	int insertChatMember(ChatMember chatMember);

	@Select("select * from chat_log where chatroom_id = #{chatroomId} order by no")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);

	@Insert("insert into chat_log values (seq_chat_log_no.nextval, #{chatroomId}, #{memberId}, #{msg}, #{time}, #{type})")
	int insertChatLog(ChatLog chatLog);

	List<ChatLog> findAdminChatList();

	@Update("update chat_member set last_check = #{time} where chatroom_id = #{chatroomId} and member_id = #{memberId}")
	int updateLastCheck(ChatLog lastCheck);

	@Select("select * from chat_member where member_id = #{memberId}")
	ChatMember findChatMemberByMemberId(String memberId);

	@Select("select count(*) from chat_log where chatroom_id = #{chatroomId} and time > #{lastCheck}")
	int getUnreadCountByChatroomIdAndLastCheck(ChatMember chatMember);
	
}
