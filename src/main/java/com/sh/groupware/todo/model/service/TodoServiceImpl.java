package com.sh.groupware.todo.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.todo.model.dao.TodoDao;
import com.sh.groupware.todo.model.dto.Todo;
import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class TodoServiceImpl implements TodoService {

	@Autowired
	private TodoDao todoDao;
	
	@Override
	public int todoBoardEnroll(TodoBoard todoBoard) {
		return todoDao.todoBoardEnroll(todoBoard);
	}
	
	@Override
	public List<TodoBoard> selectTodoBoardByempId(String empId) {
		return todoDao.selectTodoBoardByempId(empId);
	}
	
	
	@Override
	public List<TodoList> selectTodoListByNo(String no) {
	    List<TodoList> todoLists =  new ArrayList<>();
	    	todoLists=	todoDao.selectTodoListByNo(no);
	    
			
			  if (todoLists.size() > 0) {
				  for (TodoList todoList : todoLists) {
			  todoList.setTodos(todoDao.selectTodoByTodoListNo(todoList.getNo()));
			  } 
				  }
			 
	    return todoLists;
	}
	@Override
	public TodoBoard selectOneTodoBoardByNo(String no) {
		return todoDao.selectOneTodoBoardByNo(no);
	}
	@Override
	public int todoListEnroll(Map<String,Object> param) {
		return todoDao.todoListEnroll(param);
	}
	@Override
	public TodoList selectLastTodoList(Map<String,Object> param) {
		return todoDao.selectLastTodoList(param);
	}
	@Override
	public int todoEnroll(Todo todo) {
		return todoDao.todoEnroll(todo);
	}
	@Override
	public Todo todoSelectByNo(String no) {
		return todoDao.todoSelectByNo(no);
	}
	@Override
	public int todoListUpdate(TodoList todoList) {
		return todoDao.todoListUpdate(todoList);
	}
	@Override
	public int todoListDelete(TodoList todoList) {
		return todoDao.todoListDelete(todoList);
	}
	@Override
	public int todoInfoUpdate(Todo todo) {
		return todoDao.todoInfoUpdate(todo);
	}
	@Override
	public int todoContentUpdate(Todo todo) {
		return todoDao.todoContentUpdate(todo);
	}
	@Override
	public int todoDelete(Todo todo) {
		return todoDao.todoDelete(todo);
	}
	@Override
	public int commentEnroll(Map<String, Object> param) {
		return todoDao.commentEnroll(param);
	}
	@Override
	public int bookMarkOn(Map<String, Object> param) {
		return todoDao.bookMarkOn(param);
	}
	@Override
	public TodoBoard selectLastTodoBoardByNo(String todoBoardNo) {
		return todoDao.selectLastTodoBoardByNo(todoBoardNo);
	}
	@Override
	public Emp selectOneEmpByEmpId(String empId) {
		
		Emp emp =todoDao.selectOneEmpByEmpId(empId);
		Attachment attach = todoDao.selectOneAttachmentByEmpId(empId);
		emp.setAttachment(attach);
		return emp;
	}
	
	@Override
	public int todoAttachDelete(String renameFilename) {
		return todoDao.todoAttachDelete(renameFilename);
	}
	@Override
	public int todoComentDelete(String no) {
		return todoDao.todoComentDelete(no);
	}
	
	@Override
	public int bookMarkOff(Map<String, Object> param) {
		return todoDao.bookMarkOff(param);
	}
	@Override
	public int insertGroupEmp(Map<String, Object> param) {
		int result = 0;
		
		String [] array = (String [])param.get("empIds");
		
		Map <String , String > userParam = new HashMap<>();
		for (int i = 0; i <array.length; i++) {
			userParam.put("todoBoardNo",(String)param.get("todoBoardNo"));
			userParam.put("empId",array[i]);
			result = todoDao.insertGroupEmp(userParam);
		}
		
		return result;
	}
	@Override
	public List<TodoBoard> selectTodoBoardByEmpId(String empId) {
		
		List<TodoBoard> todoBoardList =todoDao.selectTodoBoardByEmpId(empId);
			for(TodoBoard todoBoard : todoBoardList) {
				String boardNo = todoBoard.getNo();
				List<Attachment> attach = todoDao.selectAttachmentByBoardNo(boardNo);
				
				todoBoard.setAttachmentLists(attach);;
				
			}
		
		return todoBoardList;
	}
	@Override
	public List<TodoBoard> selectBookMarkTodoBoard(String empId) {
		List<TodoBoard> todoBoardList = todoDao.selectBookMarkTodoBoard(empId);
			for(TodoBoard todoBoard : todoBoardList) {
				String boardNo = todoBoard.getNo();
				List<Attachment> attach = todoDao.selectAttachmentByBoardNo(boardNo);
				todoBoard.setAttachmentLists(attach);;
		}
		return todoBoardList;
	}
	@Override
	public List<Attachment> selectAttachmentByBoardNo(String boardNo) {
		return todoDao.selectAttachmentByBoardNo(boardNo);
	}
	@Override
	public int todoBoardDelete(String no) {
		return todoDao.todoBoardDelete(no);
	}
	
}
