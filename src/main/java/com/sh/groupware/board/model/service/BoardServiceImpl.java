package com.sh.groupware.board.model.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.sh.groupware.board.model.dao.BoardDao;
import com.sh.groupware.board.model.dto.BCategory;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.dto.BoardComment;
import com.sh.groupware.board.model.dto.BoardLike;
import com.sh.groupware.board.model.dto.BoardType;
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
	
	@Override
	public int insertBoardComment(BoardComment boardComment) {
		return boardDao.insertBoardComment(boardComment);
	}
	
	@Override
	public int updateReadCount(String no) {
		return boardDao.updateReadCount(no);
	}
	
	@Override
	public List<Board> selectBoardHome(Board board) {
		return boardDao.selectBoardHome(board);
	}

	@Override
	public List<Board> selectNewsBoardList(Board board) {
		return boardDao.selectNewsBoardList(board);
	}
	
	@Override
	public List<Board> selectPhotoBoardList(Board board) {
		return boardDao.selectPhotoBoardList(board);
	}
	
	@Override
	public List<Board> selectMenuBoardList(RowBounds rowBounds) {
		return boardDao.selectMenuBoardList(rowBounds);
	}
	
	@Override
	public List<BoardComment> selectBoardComment(String no) {
		return boardDao.selectBoardComment(no);
	}
	
	@Override
	public int updateBoardComment(BoardComment boardComment) {
		return boardDao.updateBoardComment(boardComment);
	}

	@Override
	public BoardComment selectBoardCommentByNo(String commentNo) {
		return boardDao.selectBoardCommentByNo(commentNo);
	}
	
	@Override
	public int deleteBoardComment(String commentNo) {
		return boardDao.deleteBoardComment(commentNo);
	}

	@Override
	public int boardlikeDown(BoardLike boardLike) {
		return boardDao.boardLikeDown(boardLike);
	}
	
	@Override
	public int boardlikeUp(BoardLike boardLike) {
		return boardDao.boardLikeUp(boardLike);
	}
	
	@Override
	public int selectBoardLikeCount(String no) {
		return boardDao.selectBoardLikeCount(no);
	}

	
	@Override
	public Map<String, Object> selectBoardLikeCheck(BoardLike boardLike) {
		return boardDao.selectBoardLikeCheck(boardLike);
	}
	
	@Override
	public List<BoardComment> selectBoardComment(BoardComment boardComment) {
		return boardDao.selectBoardComment(boardComment);
	}
	
	@Override
	public List<Board> selectNewsBoardList() {
		return boardDao.selectNewsBoardList();
	}
	
	@Override
	public List<BoardComment> selectCommentListByBoardNo(String no) {
		return boardDao.selectCommentListByBoardNo(no);
	}
	
	@Override
	public List<Board> selectPhotoBoard() {
		return boardDao.selectPhotoBoard();
	}
	
	@Override
	public int selectBoardCountByNo(String no) {
		return boardDao.selectBoardCountByNo(no);
	}

	@Override
	public int selectCommentCount(String no) {
		return boardDao.selectCommentCount(no);
	}
	
	@Override
	public int selectBoardCommentCount(String no) {
		return boardDao.selectBoardCommentCount(no);
	}
	
	@Override
	public List<Board> selectBoardsByNos(List<String> boardNos) {
		return boardDao.selectBoardsByNos(boardNos);
	}
	
	@Override
	public int deleteBoards(List<String> boardNos) {
		return boardDao.deleteBoards(boardNos);
	}


	@Override
	public int insertBoardType(BoardType boardType) {
		return boardDao.insertBoardType(boardType);
	} // insertBoardType() end
	
	
	@Override
	public List<BoardType> selectBoardTypeList() {
		return boardDao.selectBoardTypeList();
	} // selectBoardTypeList() end
	
	
	@Override
	public List<Board> findByNoBoardList(String no, RowBounds rowBounds) {
		return boardDao.findByNoBoardList(no, rowBounds);
	} // findByNoBoardList() end
	
	
	@Override
	public int selectBoardNoCount(String no) {
		return boardDao.selectBoardNoCount(no);
	} // selectBoardNoCount() end
	
	
	@Override
	public BCategory selectOneBoardCategory(String bType) {
		return boardDao.selectOneBoardCategory(bType);
	} // selectOneBoardCategory() end

}
