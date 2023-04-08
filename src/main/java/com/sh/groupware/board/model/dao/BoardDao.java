package com.sh.groupware.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.board.model.dto.BCategory;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.dto.BoardComment;
import com.sh.groupware.board.model.dto.BoardLike;
import com.sh.groupware.board.model.dto.BoardType;
import com.sh.groupware.common.dto.Attachment;

@Mapper
public interface BoardDao {

	List<Board> selectBoardList(RowBounds rowBounds);

	int insertBoard(Board board);

	int insertAttachment(Attachment attach);

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

	int boardLikeDown(BoardLike boardLike);

	int boardLikeUp(BoardLike boardLike);

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

	int insertBoardType(BoardType boardType);

	@Select("select * from boardType order by no")
	List<BoardType> selectBoardTypeList();

	List<Board> findByNoBoardList(String no, RowBounds rowBounds);

	int selectBoardNoCount(String no);

	@Select("select category from boardType where no = #{no}")
	BCategory selectOneBoardCategory(String bType);

	@Select("select * from boardType where no = (select b_type from board where no = #{no})")
	BoardType selectOneBoardType(String no);

	@Select("select * from board")
	List<Board> selectHomeBoardList();












}
