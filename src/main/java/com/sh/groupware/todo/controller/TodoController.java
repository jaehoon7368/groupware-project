package com.sh.groupware.todo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/todo")
public class TodoController {

	
	
	@GetMapping("/todo.do")
	public void todo () {
		
	}
	
	@GetMapping("/todoList.do")
	public String todoList ( ) {
		return "todo/todoList";
	}
	 
}
