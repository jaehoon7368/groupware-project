package com.sh.groupware.todo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.todo.model.dto.Todo;
import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;
import com.sh.groupware.todo.model.service.TodoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/todo")
@SessionAttributes("")
public class TodoController {

	@Autowired
	private TodoService todoService ;
	
	@GetMapping("/todo.do")
	public void todo (Model model) {
		List<TodoBoard> todoBoards = todoService.selectAllTodoBoard();                                                                                                                                                                                                                                                                                                                                                                                     
		log.debug("todoBoards {}=",todoBoards);
		
		model.addAttribute("todoBoards",todoBoards);
	}
	//게시판등록
	@PostMapping("/todoBoardEnroll.do")
	public String todoBoardEnroll(TodoBoard todoBoard , 
			Authentication authentication
			) {
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		todoBoard.setEmpId(empId);
		log.debug("TodoBoard = {}",todoBoard);
		log.debug("empId = {}",empId);
		int result = todoService.todoBoardEnroll(todoBoard);
		String no = todoBoard.getNo();
		return "redirect:/todo/todoList.do?no="+no;
	}
	
	
	
	@GetMapping("/todoList.do")
	public String todoList (@RequestParam String no,Model model) {
		TodoBoard todoBoard = todoService.selectOneTodoBoardByNo(no);
		List<TodoList> todoLists = todoService.selectTodoListByNo(no); 
		log.debug("todoLists = {}" ,todoLists);
		log.debug("todoBoard = {}" ,todoBoard);
		
		if(todoLists.size() > 0) {
		model.addAttribute("todoLists",todoLists);
		}
		
		model.addAttribute("todoBoard",todoBoard);
		return "todo/todoList";
		
	}
	
	//리스트 등록
	@PostMapping("/todoListEnroll.do")
	public String todoListEnroll (
			@RequestParam String todoListTitle,
			@RequestParam String no,
			Authentication authentication) {
		Map<String,Object> param = new HashMap<>();
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		param.put("empId", empId);
		param.put("no", no);
		param.put("todoListTitle", todoListTitle);
		log.debug("param = {}",param);
		int result = todoService.todoListEnroll(param);
		log.debug("param = {}",param);
		return "redirect:/todo/todoList.do?no="+no;
	}
	
	
	//할일 등록
	@PostMapping("/todoEnroll.do")
	public String todoEnroll(Todo todo,@RequestParam String todoBoardNo) {
		log.debug("Todo = {}", todo);
		
		int result = todoService.todoEnroll(todo);
		log.debug("todoBoardNo = {}",todoBoardNo);
		
		return "redirect:/todo/todoList.do?no="+todoBoardNo;
	}
	
	 
}
