package com.sh.groupware.board.model.dto;
import java.time.LocalDateTime;

import org.springframework.web.bind.annotation.PostMapping;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardEntity {
	

	private String no;
	private String bType;
	/* private BType bType; */
	private String title;
	private String content;
	private int readCount;
	private int likeCount;
	@JsonFormat(pattern = "yyyy.MM.dd HH:mm:ss")
	private LocalDateTime createdDate;
	private LocalDateTime updatedDate;
	private String empId;
	private String writer;
	private int commentCount;
}
