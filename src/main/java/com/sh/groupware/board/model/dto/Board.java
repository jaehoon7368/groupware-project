package com.sh.groupware.board.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board extends BoardEntity{
	
	private int attachCount;
	private List<Attachment> attachments = new ArrayList<>();
	private Emp emp;
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	}

	public Board(String no, String category, String title, String content, int readCount, int likeCount,
			LocalDateTime createdDate, LocalDateTime updatedDate, String empId, String writer, int attachCount) {
		super(no, category, title, content, readCount, likeCount, createdDate, updatedDate, empId, writer);
		this.attachCount = attachCount;
	}

	
	
	
}

