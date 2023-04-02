package com.sh.groupware.chat.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLogEntity {
	
	private int no;
	private String chatroomId;
	private String empId;
	private String msg;
	private long time;
	private String type;
	
}
