package com.sh.groupware.todo.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.todo.model.dto.Todo;
import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;

public interface TodoService {

	int todoBoardEnroll(TodoBoard todoBoard);

	List<TodoBoard> selectTodoBoardByempId(String empId);


	List<TodoList> selectTodoListByNo(String no);

	TodoBoard selectOneTodoBoardByNo(String no);

	int todoListEnroll(Map<String,Object> param);

	TodoList selectLastTodoList(Map<String,Object> param);

	int todoEnroll(Todo todo);

	Todo todoSelectByNo(String no);

	int todoListUpdate(TodoList todoList);

	int todoListDelete(TodoList todoList);

	int todoInfoUpdate(Todo todo);

	int todoContentUpdate(Todo todo);

	int todoDelete(Todo todo);

	int commentEnroll(Map<String, Object> param);

	int bookMarkOn(Map<String, Object> param);

	int bookMarkOff(Map<String, Object> param);
	
	TodoBoard selectLastTodoBoardByNo(String todoBoardNo);

	Emp selectOneEmpByEmpId(String empId);

	int todoAttachDelete(String renameFilename);

	int todoComentDelete(String no);

	List<TodoBoard> selectBookMarkTodoBoard(String empId);


	int insertGroupEmp(Map<String, Object> param);

	List<TodoBoard> selectTodoBoardByEmpId(String empId);

	List<Attachment> selectAttachmentByBoardNo(String boardNo);
	

}
