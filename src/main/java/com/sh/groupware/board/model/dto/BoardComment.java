package com.sh.groupware.board.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardComment {

	private String no;
	private String content;
	private LocalDateTime regDate;
	private int commentLevel;
	private int refComment;
	private String boardNo;
	private String empId;
}
