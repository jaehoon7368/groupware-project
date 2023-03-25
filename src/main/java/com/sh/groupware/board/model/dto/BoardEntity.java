package com.sh.groupware.board.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardEntity {
	

	private String no;
	private BType bType;
	private String title;
	private String content;
	private int readCount;
	private int likeCount;
	private LocalDateTime createdDate;
	private LocalDateTime updatedDate;
	private String empId;
	private String writer;
}
