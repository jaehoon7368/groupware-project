package com.sh.groupware.todo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sh.groupware.emp.model.dto.Emp;
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
	
	@PostMapping("/todoBoardEnroll.do")
	public String todoBoardEnroll(TodoBoard todoBoard , 
			Authentication authentication
			) {
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		todoBoard.setEmpId(empId);
		log.debug("TodoBoard = {}",todoBoard);
		log.debug("empId = {}",empId);
		int result = todoService.todoBoardEnroll(todoBoard);
		return "redirect:/todo/todoList.do?empId="+empId;
	}
	
	@GetMapping("/todoList.do")
	public String todoList (@RequestParam String no,Model model) {
		
		TodoBoard todoBoard = todoService.selectOneTodoBoardByNo(no);
		List<TodoList> todoLists = todoService.selectTodoListByNo(no); 
		log.debug("todoLists= {}",todoLists);
		model.addAttribute("todoLists",todoLists);
		model.addAttribute("todoBoard",todoBoard);
		model.addAttribute("todoListsLength", todoLists.size());
		return "todo/todoList";
		
	}
	
	@ResponseBody
	@PostMapping("todoListEnroll.do")
	public int todoListEnroll (
			@RequestParam String todoListTitle,
			@RequestParam String pageTodoBoardNo,
			Authentication authentication) {
		Map<String,Object> param = new HashMap<>();
		
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		
		param.put("empId", empId);
		param.put("no", pageTodoBoardNo);
		param.put("todoListTitle", todoListTitle);
		
		log.debug("todoListTitle = {}",todoListTitle);
		
		int result = todoService.todoListEnroll(param); 
		TodoList todoList = todoService.selectLastTodoList();
		
		log.debug("todoList = {}",todoList);
		
		
			return result;
					
	}
	 
}
