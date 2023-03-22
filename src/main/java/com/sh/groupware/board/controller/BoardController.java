package com.sh.groupware.board.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping("/boardHome.do")
	private void boardHome() {}
	
	@GetMapping("/boardList.do")
	public void boardList(@RequestParam(defaultValue = "1") int cpage, Model model) {
		
		// 페이징처리
		int limit = 10;
		int offset = (cpage - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Board> boardList = boardService.selectBoardList(rowBounds);
		log.debug("boardList = {}", boardList);
		model.addAttribute("boardList", boardList);
	}
	
//	@GetMapping("/boardDetail.do")
//	public void boardDetail(@RequestParam int no, Model model) {
//		log.debug("no = {}", no);
//		Board board = boardService.selectOneBoardCollection(no);
//		log.debug("board = {}", board);
//		
//		model.addAttribute("board", board);
//		
//	}
	
	
	
	
	
	@GetMapping("/boardForm.do")
	private void boardForm() {}
	
	@GetMapping("/boardAdd.do")
	private void boardCreate() {}
	
	@GetMapping("/openBoardForm.do")
	private void openBoardForm() {}
	
	
}
