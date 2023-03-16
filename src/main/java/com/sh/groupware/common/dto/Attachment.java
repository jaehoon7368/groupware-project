package com.sh.groupware.common.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {

	private String no;
	private String originalFilename;
	private String renameFilename;
	private LocalDateTime regDate;
	private Category category;
	private String pkNo;
}
