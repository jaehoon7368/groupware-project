package com.sh.groupware.board.model.dto;

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
public class BoardComment {
	private Emp emp;

	private String no;
	private String content;
	private LocalDateTime regDate;
	private int commentLevel;
	private String refCommentNo;
	private String boardNo;
	private String empId;
	private String writer;
	
}
