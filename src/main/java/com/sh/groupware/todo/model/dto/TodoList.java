package com.sh.groupware.todo.model.dto;

import java.util.ArrayList;
import java.util.List;

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
	private List<Todo> todos = new ArrayList<>();

}
