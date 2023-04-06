package com.sh.groupware.board.model.dto;

import com.sh.groupware.report.model.dto.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardType {

	private String no;
	private String title;
	private String explain;
	private BCategory category;
	private YN commentYn;
	
} // class end
