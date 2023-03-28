package com.sh.groupware.todo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.todo.model.dto.Todo;
import com.sh.groupware.todo.model.dto.TodoBoard;
import com.sh.groupware.todo.model.dto.TodoList;

@Mapper
public interface TodoDao {

	int todoBoardEnroll(TodoBoard todoBoard);
	@Select("select * from todoboard where emp_id = #{empId}")
	List<TodoBoard> selectTodoBoardByempId(String empId);
	
	@Select("select * from todoboard where no = #{no} order by no asc")
	TodoBoard selectOneTodoBoardByNo(String no);
	TodoList selectLastTodoList(Map<String,Object> param);
	
	int todoListEnroll(Map<String,Object> param);
	
	List<TodoList> selectTodoListByNo(String no);
	List<Todo> selectTodoByTodoListNo(String no);
	int todoEnroll(Todo todo);
	Todo todoSelectByNo(String no);
	int todoListUpdate(TodoList todoList);
	int todoListDelete(TodoList todoList);
	int todoInfoUpdate(Todo todo);
	int todoContentUpdate(Todo todo);
	@Delete("delete from todo where no = #{no}")
	int todoDelete(Todo todo);
	int commentEnroll(Map<String, Object> param);
	int bookMarkOn(Map<String, Object> param);
	int bookMarkOff(Map<String, Object> param);
	@Select("select * from todoBoard where no = #{todoBoardNo}")
	TodoBoard selectLastTodoBoardByNo(String todoBoardNo);
	int updateTodoFileUpload(String attachNo);
	@Select("select * from emp e left join attachment a on e.emp_id = a.pk_no where e.emp_id = #{empId}")
	Emp selectOneEmpByEmpId(String empId);
	@Select("select * from attachment where pk_no = #{empId}")
	Attachment selectOneAttachmentByEmpId(String empId);
	@Delete("delete from attachment where rename_filename = #{renameFilename}")
	int todoAttachDelete(String renameFilename);
	@Delete("delete from todocomment where no = #{no}")
	int todoComentDelete(String no);
	
	List<TodoBoard> selectBookMarkTodoBoard(String empId);
	int insertGroupEmp(Map<String, String> param);
	List<TodoBoard> selectTodoBoardByEmpId(String empId);
	
	

	
}
