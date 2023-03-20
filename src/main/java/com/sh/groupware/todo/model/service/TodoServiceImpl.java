package com.sh.groupware.todo.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.todo.model.dao.TodoDao;
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
	public List<TodoBoard> selectAllTodoBoard() {
		return todoDao.selectAllTodoBoard();
	}
	
	@Override
	public List<TodoList> selectTodoListByNo(String no) {
		return todoDao.selectTodoListByNo(no);
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
	public TodoList selectLastTodoList() {
		return todoDao.selectLastTodoList();
	}
	
}
