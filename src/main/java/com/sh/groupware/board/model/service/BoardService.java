package com.sh.groupware.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.ResponseEntity;

import com.sh.groupware.board.model.dto.BCategory;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.dto.BoardComment;
import com.sh.groupware.board.model.dto.BoardLike;
import com.sh.groupware.board.model.dto.BoardType;
import com.sh.groupware.common.dto.Attachment;

public interface BoardService {

	List<Board> selectBoardList(RowBounds rowBounds);

	int insertBoard(Board board);

	Board selectOneBoardCollection(String no);

	Attachment selectOneAttachment(String no);

	int selectBoardCount();

	Board selectBoardByNo(String no);

	int deleteBoard(String no);

	int updateBoard(Board board);

	int insertBoardComment(BoardComment boardComment);

	int updateReadCount(String no);

	List<Board> selectBoardHome(Board board);

	List<Board> selectNewsBoardList(Board board);

	List<Board> selectPhotoBoardList(Board board);

	List<Board> selectMenuBoardList(RowBounds rowBounds);

	List<BoardComment> selectBoardComment(String no);

	int updateBoardComment(BoardComment boardComment);

	BoardComment selectBoardCommentByNo(String commentNo);

	int deleteBoardComment(String commentNo);

	int boardlikeUp(BoardLike boardLike);

	int boardlikeDown(BoardLike boardLike);

	int selectBoardLikeCount(String no);

	Map<String, Object> selectBoardLikeCheck(BoardLike boardLike);


	List<BoardComment> selectBoardComment(BoardComment boardComment);

	List<Board> selectNewsBoardList();

	List<BoardComment> selectCommentListByBoardNo(String no);

	List<Board> selectPhotoBoard();

	int selectBoardCountByNo(String no);

	int selectCommentCount(String no);

	int selectBoardCommentCount(String no);

	List<Board> selectBoardsByNos(List<String> boardNos);

	int deleteBoards(List<String> boardNos);

	List<BoardType> selectBoardTypeList();

	int insertBoardType(BoardType boardType);

	List<Board> findByNoBoardList(String no, RowBounds rowBounds);

	int selectBoardNoCount(String no);

	BCategory selectOneBoardCategory(String bType);

	BoardType selectOneBoardType(String no);

	List<Board> selectHomeBoardList();

	

	


	


	



	

//	List<Board> selectBoardsByNos(List<String> boardNos);

//	int deleteBoards(List<String> boardNos);

	

	

	




}
