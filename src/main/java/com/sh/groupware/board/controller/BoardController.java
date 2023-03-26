package com.sh.groupware.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.service.BoardService;
import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.service.EmpService;

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
		
		// 총 게시물 수
	    int totalCount = boardService.selectBoardCount();
	    log.debug("totalCount = {}", totalCount);

	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) totalCount / limit);
	    log.debug("totalPage = {}", totalPage);

	    // 시작 페이지와 끝 페이지 계산
	    int startPage = ((cpage - 1) / 10) * 10 + 1; // 10 페이지씩 묶어서 보여줌
	    int endPage = Math.min(startPage + 9, totalPage);
		
		
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("currentPage", cpage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPage", totalPage);
	}
	
	
	@PostMapping("/boardEnroll.do")
	public String boardEnroll(
			Board board,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			RedirectAttributes redirectAttr
			) {
		log.debug("board = {}", board);
		
		String saveDirectory = application.getRealPath("/resources/upload/board");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			
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
	
	
	@GetMapping("/boardDetail.do")
	public void boardDetail(@RequestParam String no, Model model) {
		log.debug("no = {}", no);
		Board board = boardService.selectOneBoardCollection(no);
		log.debug("board = {}", board);
		
		model.addAttribute("board", board);
		
	}
	
	@ResponseBody
	@GetMapping("/fileDownload.do")
	public Resource fileDownload(@RequestParam String no, HttpServletResponse response) {
		// renameFilename 파일을 찾고, originalFilename으로 파일명 전송.
		Attachment attach = boardService.selectOneAttachment(no);
		log.debug("attach = {}", attach);
		
		// FileSystemResource - file:~ 경로 사용
		String renameFilename = attach.getRenameFilename();
		String originalFilename = attach.getOriginalFilename();
		
		// 한글깨짐대비
		try {
			originalFilename = new String(originalFilename.getBytes("utf-8"), "iso-8859-1");
		} catch (UnsupportedEncodingException e){
			log.error(e.getMessage(), e);
		}
		
		String saveDirectory = application.getRealPath("/resources/upload/board");
		File downFile = new File(saveDirectory, renameFilename);
		
		String location = "file:" + downFile;
		Resource resource = resourceLoader.getResource(location);
		log.debug("resource = {}", resource);
		log.debug("resource.exists() = {}", resource.exists());
		log.debug("resource.getClass() = {}", resource.getClass());
		log.debug("saveDirectory = {}", saveDirectory);
				
		// 응답헤더설정
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + originalFilename);
		
		return resource;
	}
	
	@PostMapping("/boardDelete.do")
	private String boardDelete(@RequestParam String no, Authentication authentication, RedirectAttributes redirectAttributes) {
	
		
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    Board board = boardService.selectBoardByNo(no); // 삭제하려는 게시물 가져오기

	    if (board != null && board.getEmpId().equals(empId)) { // 게시물 작성자와 현재 사용자가 같을 때만 삭제
	        int result = boardService.deleteBoard(no);

	    } else {
	    	redirectAttributes.addFlashAttribute("msg", "작성자만 삭제할 수 있습니다.");
	    }
	    
	    return "redirect:/board/boardList.do";
	}
	
	@GetMapping("/boardUpdateForm.do")
	private String updateBoard(@RequestParam String no, Model model) {
		
		 Board board = boardService.selectOneBoardCollection(no);
		 model.addAttribute("board", board);
		    
		 return "board/boardUpdateForm"; 
	}
	
	@PostMapping("/updateBoard.do")
	public String updateBoard(Board board,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			@RequestParam String no,
			RedirectAttributes redirectAttr){
		
		
		String saveDirectory = application.getRealPath("/resources/upload/board");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			
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
	    int result = boardService.updateBoard(board);
	    
	    return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}
	
	
	@GetMapping("/boardForm.do")
	private void boardForm() {
	
	}
	
	@GetMapping("/boardAdd.do")
	private void boardCreate() {}
	
	@GetMapping("/openBoardForm.do")
	private void openBoardForm() {}
	
	
}
