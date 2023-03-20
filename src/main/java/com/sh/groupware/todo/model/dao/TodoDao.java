package com.sh.groupware.todo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.http.ResponseEntity;

import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;

@Mapper
public interface TodoDao {

	int todoBoardEnroll(TodoBoard todoBoard);
	@Select("select * from todoboard where emp_id = #{empId}")
	List<TodoBoard> selectTodoBoardByempId(String empId);
	@Select("select * from todoboard")
	List<TodoBoard> selectAllTodoBoard();
	@Select("select * from todolist where todoboard_no = #{no}")
	List<TodoList> selectTodoListByNo(String no);
	@Select("select * from todoboard where no = #{no}")
	TodoBoard selectOneTodoBoardByNo(String no);
	
	int todoListEnroll(Map<String,Object> param);
	
	
	TodoList selectLastTodoList();
	

	
}
