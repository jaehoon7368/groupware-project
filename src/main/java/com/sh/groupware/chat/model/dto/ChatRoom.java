package com.sh.groupware.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class ChatRoom {

	
	private String chatroomId; 
	private String empId; 
	private long lastCheck;
	private LocalDateTime createdAt;
	private LocalDateTime deletedAt;
	
}
