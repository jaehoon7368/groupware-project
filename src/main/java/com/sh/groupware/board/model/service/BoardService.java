package com.sh.groupware.board.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.board.model.dto.Board;

public interface BoardService {

	List<Board> selectBoardList(RowBounds rowBounds);

	int insertBoard(Board board);

//	Board selectOneBoardCollection(int no);

}
