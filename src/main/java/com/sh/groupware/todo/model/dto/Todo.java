package com.sh.groupware.todo.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Todo {
	
	private String no;
	private String content;
	private String info;
	private LocalDate endDate;
	private String explain;
	private String todoListNo;

}
