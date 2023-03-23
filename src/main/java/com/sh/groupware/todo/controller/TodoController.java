package com.sh.groupware.todo.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.attachment.model.service.AttachmentService;
import com.sh.groupware.common.dto.Attachment;
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
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private ServletContext application;
	
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
	
	@ResponseBody
	@GetMapping("/todoSelectByNo.do")
	public Todo todoSelectByNo (@RequestParam String no) {
		Todo todo = todoService.todoSelectByNo(no);
		log.debug("코멘트 여러개 확인 = {}",todo.getTodocomments());
		return todo;
	}
	
	@PostMapping("todoListUpdate.do")
	public String todoListUpdate(TodoList todoList,@RequestParam String todoBoardNo) {
		
		int result = todoService.todoListUpdate(todoList);
		
		return "redirect:/todo/todoList.do?no="+todoBoardNo;
	}
	
	@PostMapping("todoListDelete.do")
	public String todoListDelete(TodoList todoList,@RequestParam String todoBoardNo) {
		
		log.debug("Delete todoList {}",todoList);
		int result = todoService.todoListDelete(todoList);
		return "redirect:/todo/todoList.do?no="+todoBoardNo;	
		}

	@PostMapping("todoInfoUpdate.do")
	public String todoInfoUpdate(Todo todo,@RequestParam String todoBoardNo) {
		int result = todoService.todoInfoUpdate(todo);
		return "redirect:/todo/todoList.do?no="+todoBoardNo; 
	}
	@PostMapping("todoContentUpdate.do")
	public String todoContentUpdate(Todo todo,@RequestParam String todoBoardNo) {
		int result = todoService.todoContentUpdate(todo);
		return "redirect:/todo/todoList.do?no="+todoBoardNo;
	}
	@PostMapping("todoDelete.do")
	public String todoDelete(Todo todo,@RequestParam String todoBoardNo) {
		int result = todoService.todoDelete(todo);
		return "redirect:/todo/todoList.do?no="+todoBoardNo;
	}
	
	
	
	@ResponseBody
	@PostMapping("todoFileUpload.do") 
	public Attachment todoFileUpload (
			@RequestParam MultipartFile file,
			@RequestParam String todoNo
			) {
		String saveDirectory = application.getRealPath("/resources/upload/todo");
		log.debug("saveDirectory = {}", saveDirectory);
		Todo todo = todoService.todoSelectByNo(todoNo);
		
		Attachment attach = new Attachment();
		
		
		if(file.getSize() > 0) {
			// 1. 저장 
			String renamedFilename = HelloSpringUtils.renameMultipartFile(file);
			String originalFilename = file.getOriginalFilename();
			File destFile = new File(saveDirectory, renamedFilename);
			try {
				file.transferTo(destFile);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			
			// 2. attach객체생성 및 Board에 추가
			
			attach.setRenameFilename(renamedFilename);
			attach.setOriginalFilename(originalFilename);
			attach.setPkNo(todoNo);
		}

		// attachment 에 
		int  result = attachmentService.todoFileUpload(attach);
		//attachmetn 조회하기 
		
		
		return attach;
	
	
	}
	 
	
	
	//seq_todocomment_no;   댓글등록
	@PostMapping("commentEnroll.do")
	public String commentEnroll (
			@RequestParam String content, 
			@RequestParam String todoNo,
			@RequestParam String todoBoardNo,
			Authentication authentication
			) {
		String empId =  ((Emp)authentication.getPrincipal()).getEmpId();
		Map<String,Object> param = new HashMap<>();
		param.put("todoNo",todoNo);
		param.put("content",content);
		param.put("empId", empId);
		int result = todoService.commentEnroll(param);
		
		log.debug("param = {}",param);
		return "redirect:/todo/todoList.do?no="+todoBoardNo;
	};
	//북마크 등록
	@ResponseBody
	@PostMapping("bookMarkOn.do")
	public TodoBoard bookMarkOn(@RequestParam String todoBoardNo) {
		log.debug("todoBoardNo = {}",todoBoardNo);
		int result =  todoService.bookMarkOn(todoBoardNo);
		TodoBoard todoBoard  = todoService.selectLastTodoBoardByNo(todoBoardNo);
		return todoBoard;
	}
	
	
	








}
