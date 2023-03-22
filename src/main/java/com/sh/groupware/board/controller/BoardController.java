package com.sh.groupware.board.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.service.BoardService;
import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.report.model.dto.ReportCheck;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private EmpService empService;
	
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
	
	@PostMapping("/boardEnroll.do")
	public String boardEnroll(
			Board board,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			RedirectAttributes redirectAttr
			) {

		log.debug("board = {}", board);
		
		// ServletContext : application객체의 타입. DI. 스프링과 관계없는 servlet spec의 객체
		String saveDirectory = application.getRealPath("/resources/upload/board");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
//			log.debug("upFile = {}", upFile.getOriginalFilename());
//			log.debug("upFile = {}", upFile.getSize());	
			
			if(upFile.getSize() > 0) {
				// 1. 저장 
				String pkNo = board.getNo();
				String renameFilename = HelloSpringUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renameFilename);
				try {
					upFile.transferTo(destFile);
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				// 2. attach객체생성 및 Board에 추가
				Attachment attach = new Attachment();
				attach.setRenameFilename(renameFilename);
				attach.setOriginalFilename(originalFilename);
				attach.setPkNo(pkNo);
				board.addAttachment(attach);
			}
			
			
		}
		
		log.debug("board = {}", board);
		int result = boardService.insertBoard(board);
		
		redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 저장했습니다.");
		
		return "redirect:/board/boardList.do";
	}
	
	
	
	
	
	@GetMapping("/boardForm.do")
	private void boardForm() {
	
	}
	
	@GetMapping("/boardAdd.do")
	private void boardCreate() {}
	
	@GetMapping("/openBoardForm.do")
	private void openBoardForm() {}
	
	
}
