package com.sh.groupware.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.board.model.dto.Board;
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





}
