package com.sh.groupware.todo.model.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Todo {
	
	private String no;
	private String content;
	private String info;
	private LocalDateTime endDate;
	private String todoListNo;
	private String attachNo;
	private List<Attachment> attachments;
	private List<TodoComment> todocomments;

	
	public void addAttachment(Attachment attachment) {
		
		this.attachments.add(attachment);
	}
	
	
}
