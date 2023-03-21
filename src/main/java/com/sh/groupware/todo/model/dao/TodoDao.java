package com.sh.groupware.todo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.http.ResponseEntity;

import com.sh.groupware.todo.model.dto.Todo;
import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;

@Mapper
public interface TodoDao {

	int todoBoardEnroll(TodoBoard todoBoard);
	@Select("select * from todoboard where emp_id = #{empId}")
	List<TodoBoard> selectTodoBoardByempId(String empId);
	@Select("select * from todoboard order by no asc")
	List<TodoBoard> selectAllTodoBoard();
	
	@Select("select * from todoboard where no = #{no} order by no asc")
	TodoBoard selectOneTodoBoardByNo(String no);
	TodoList selectLastTodoList(Map<String,Object> param);
	
	int todoListEnroll(Map<String,Object> param);
	
	List<TodoList> selectTodoListByNo(String no);
	List<Todo> selectTodoByTodoListNo(String no);
	int todoEnroll(Todo todo);
	
	

	
}
