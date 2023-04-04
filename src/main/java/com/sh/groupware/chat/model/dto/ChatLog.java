package com.sh.groupware.chat.model.dto;

import java.util.List;

import com.sh.groupware.emp.model.dto.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLog extends ChatLogEntity{

	
	private Emp emp ;
	private int unreadCount;
	
}
