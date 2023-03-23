package com.sh.groupware.todo.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodoComment {

	private String no;
	private String content;
	private LocalDateTime regDate;
	private String empId;
	private String todoNo;

	
	
}
