package com.sh.groupware.ws.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payload {
	
	private String from;
	private String to;
	private String msg;
	private long time; // 유닉스초
	private PayloadType type ;
	
	
	
	
}
