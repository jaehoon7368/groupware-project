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
public class BoardLike {
	
	private String likeNo;
	private String empId;
	private String boardNo;
	private LikeYn likeYn;
	private LocalDateTime regDate;
	
}
