package com.sh.groupware.todo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodoList {
	
	private String no;
	private String title;
	private String todoboardNo;
	private String empId;

}
