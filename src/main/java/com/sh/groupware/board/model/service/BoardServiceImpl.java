package com.sh.groupware.board.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.board.model.dao.BoardDao;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.common.dto.Attachment;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<Board> selectBoardList(RowBounds rowBounds) {
		return boardDao.selectBoardList(rowBounds);
	}
	
	@Override
	public int insertBoard(Board board) {
		// 게시글 등록 - 동시에 채번된 pk를 조회
		int result = boardDao.insertBoard(board);
		log.debug("board = {}", board);
		
		// 첨부파일 등록
		List<Attachment> attachments = board.getAttachments();
		if(attachments.size() > 0) {
			for(Attachment attach : attachments) {
				attach.setPkNo(board.getNo());
				result = insertAttachment(attach);
			}
		}
		return result;
	}

	private int insertAttachment(Attachment attach) {
		return boardDao.insertAttachment(attach);
	}
	
	@Override
	public Board selectOneBoardCollection(String no) {
		return boardDao.selectOneBoardCollection(no);
	}
	
	@Override
	public Attachment selectOneAttachment(String no) {
		return boardDao.selectOneAttachment(no);
	}
	
	@Override
	public int selectBoardCount() {
		return boardDao.selectBoardCount();
	}
	
	@Override
	public Board selectBoardByNo(String no) {
		return boardDao.selectBoardByNo(no);
	}
	
	@Override
	public int deleteBoard(String no) {
		return boardDao.deleteBoard(no);
	}
	
	@Override
	public int updateBoard(Board board) {
		// 게시글 등록 - 동시에 채번된 pk를 조회
				int result = boardDao.updateBoard(board);
				log.debug("board = {}", board);
				
				// 첨부파일 등록
				List<Attachment> attachments = board.getAttachments();
				if(attachments.size() > 0) {
					for(Attachment attach : attachments) {
						attach.setPkNo(board.getNo());
						result = insertAttachment(attach);
					}
				}
				return result;
	}
	

}
