package com.sh.groupware.board.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Board extends BoardEntity{
	
	private int attachCount;
	private List<Attachment> attachments = new ArrayList<>();
	private List<BoardComment> boardComment = new ArrayList<>();
	private Emp emp;
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	}
	
	private List<BoardComment> commentList;

    public List<BoardComment> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<BoardComment> commentList) {
        this.commentList = commentList;
    }
	
//	public Board(String no, BType bType, String title, String content, int readCount, int likeCount,
//			LocalDateTime createdDate, LocalDateTime updatedDate, String empId, String writer, int attachCount,
//			List<Attachment> attachments, List<BoardComment> boardComment, Emp emp) {
//		super(no, bType, title, content, readCount, likeCount, createdDate, updatedDate, empId, writer);
//		this.attachCount = attachCount;
//		this.attachments = attachments;
//		this.boardComment = boardComment;
//		this.emp = emp;
//	}

	public Board(String no, String bType, String title, String content, int readCount, int likeCount,
			LocalDateTime createdDate, LocalDateTime updatedDate, String empId, String writer, int attachCount,
			List<Attachment> attachments, List<BoardComment> boardComment, Emp emp, List<BoardComment> commentList) {
		super(no, bType, title, content, readCount, likeCount, createdDate, updatedDate, empId, writer);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.boardComment = boardComment;
		this.emp = emp;
		this.commentList = commentList;
	}
	
	


	
}

