package com.sh.groupware.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.groupware.board.model.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/boardHome.do")
	private void boardHome() {}
	
	@GetMapping("/boardList.do")
	private void boardList() {}
	
	@GetMapping("/boardForm.do")
	private void boardForm() {}
	
	@GetMapping("/boardAdd.do")
	private void boardCreate() {}
	
	@GetMapping("/openBoardForm.do")
	private void openBoardForm() {}
	
	
}
