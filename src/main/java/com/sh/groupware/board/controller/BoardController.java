package com.sh.groupware.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.groupware.board.model.dto.BCategory;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.board.model.dto.BoardComment;
import com.sh.groupware.board.model.dto.BoardLike;
import com.sh.groupware.board.model.dto.BoardType;
import com.sh.groupware.board.model.dto.LikeYn;
import com.sh.groupware.board.model.service.BoardService;
import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.service.EmpService;
import com.sh.groupware.report.model.dto.ReportComment;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
@SessionAttributes("boardTypeList")
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
	private void boardHome(@ModelAttribute Board board, Model model) {
		List<Board> boardList = boardService.selectBoardHome(board);
		List<BoardType> boardTypeList = boardService.selectBoardTypeList();
		
	    log.debug("boardList = {}", boardList);
	    log.debug("boardTypeList = {}", boardTypeList);
	    
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("boardTypeList", boardTypeList);
	}
	
	@GetMapping("/boardList.do")
	public void boardList(@RequestParam(defaultValue = "1") int cpage, Model model) {
		
		// 페이징처리
		int limit = 20;
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
	    int startPage = ((cpage - 1) / 20) * 20 + 1; // 10 페이지씩 묶어서 보여줌
	    int endPage = Math.min(startPage + 19, totalPage);
	    
		
		
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
		
		BCategory cate = boardService.selectOneBoardCategory(board.getBType());
		
		return "redirect:/board/boardTypeList.do?no=" + board.getBType() + "&category=" + cate;
		
//		String bType = board.getBType() == null ? "" : board.getBType().toString();
//		    switch (bType) {
//		        case "M":
//		            return "redirect:/board/menuBoardList.do";
//		        case "P":
//		            return "redirect:/board/photoBoardList.do";
//		        case "N":
//		            return "redirect:/board/newsBoardList.do";
//		        default:
//		            return "redirect:/board/boardList.do";
//		    }
	}
	
	
	@GetMapping("/boardDetail.do")
	public void boardDetail(@RequestParam(required = false) String no, HttpServletRequest request, Model model, Authentication authentication) {
	    if (no == null) { // 파라미터가 누락된 경우
	        model.addAttribute("errorMsg", "잘못된 요청입니다.");
	        return;
	    }

	    HttpSession session = request.getSession();
	    String key = "board:" + no; // 게시글 번호를 key로 사용
	    Set<String> readBoardSet = (Set<String>) session.getAttribute("readBoardSet");

	    if (readBoardSet == null) {
	        readBoardSet = new HashSet<>();
	    }

	    if (!readBoardSet.contains(key)) { // 세션에 해당 게시글의 조회 여부가 없을 경우
	        int result = boardService.updateReadCount(no); // 게시글 조회수 증가
	        readBoardSet.add(key); // 세션에 해당 게시글의 조회 여부를 저장
	        session.setAttribute("readBoardSet", readBoardSet);
	    } else {
	        // 세션에 해당 게시글의 조회 여부가 있을 경우 조회수 증가하지 않음
	        int result = 0;
	    }

	    Board board = boardService.selectOneBoardCollection(no);
	    if (board == null) {
	        model.addAttribute("errorMsg", "존재하지 않는 게시글입니다.");
	        return;
	    }
	    List<BoardComment> commentList = boardService.selectBoardComment(no);
	    
	    log.debug("no = {}", no);
	    int likeCount = boardService.selectBoardLikeCount(no);
	    int commentCount = boardService.selectCommentCount(no);
	    log.debug("likeCount1 = {}", likeCount);
	    log.debug("commentCount = {}", commentCount);
	    
	    model.addAttribute("commentCount", commentCount);
	    model.addAttribute("board", board);
	    model.addAttribute("commentList", commentList);
	    model.addAttribute("likeCount", likeCount);
	    log.debug("likeCount3 = {}", likeCount);
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
		
		log.debug("보드삭제 no 확인 = {}", no);
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    Board board = boardService.selectBoardByNo(no); // 삭제하려는 게시물 가져오기
	    BoardType boardType = boardService.selectOneBoardType(board.getBType());

	    if (board != null && board.getEmpId().equals(empId)) { // 게시물 작성자와 현재 사용자가 같을 때만 삭제
	        int result = boardService.deleteBoard(no);
	    } else {
	    	redirectAttributes.addFlashAttribute("msg", "작성자만 삭제할 수 있습니다.");
	    }
	    return "redirect:/board/boardTypeList.do?no=" + board.getBType() + "&category=" + boardType.getCategory();
	}
	
	@PostMapping("/boardCommentDelete.do")
	private String boardDCommentDelete(@RequestParam String commentNo, Authentication authentication, RedirectAttributes redirectAttributes, Board board) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    BoardComment boardComment = boardService.selectBoardCommentByNo(commentNo);
	    	
	    	log.debug("boardComment = {}", boardComment);
	        int result = boardService.deleteBoardComment(commentNo);
	   
	    return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}
	
	@PostMapping("/boardsDelete.do")
	private String boardDelete(@RequestParam(value = "boardNos[]", required = false) List<String> boardNos,
	                           Authentication authentication, RedirectAttributes redirectAttributes) {
	    String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    log.debug("boardNos 시작 = {}", boardNos);
	    
//	    List<Board> boardsToDelete = boardService.selectBoardsByNos(boardNos);
//	    log.debug("boardNos 끝 = {}", boardNos);
//	    log.debug("boardsToDelete = {}", boardsToDelete);
//	    List<String> failedNos = new ArrayList<>();
//	    for (Board board : boardsToDelete) { 
//	            failedNos.add(board.getNo());
//	        }

        BoardType boardType = boardService.selectOneBoardType(boardNos.get(0));
        log.debug("boardType = {}", boardType);
        
        int result = boardService.deleteBoards(boardNos);
        
        return "redirect:/board/boardTypeList.do?no=" + boardType.getNo() + "&category=" + boardType.getCategory();
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
	
	
	@GetMapping("/newsBoardList.do")
	public String selectNewsBoardList(Model model) {
	    List<Board> boardList = boardService.selectNewsBoardList();
	    Map<String, Object> commentCountMap = new HashMap<>();
	    
	    for (Board board : boardList) {
	        List<BoardComment> commentList = boardService.selectCommentListByBoardNo(board.getNo());
	        int likeCount = boardService.selectBoardCountByNo(board.getNo());	        
	        board.setLikeCount(likeCount);
	        board.setCommentList(commentList);

	        int commentCount = boardService.selectBoardCommentCount(board.getNo());
	        commentCountMap.put("CommentCount", commentCount);
	    }
	   
	    
	    log.debug("commentCountMap = {}", commentCountMap);
	    log.debug("boardList = {}", boardList);
	    
	    model.addAttribute("commentCountMap", commentCountMap);
	    model.addAttribute("boardList", boardList);
	    return "/board/newsBoardList";
	}
	
	 

	@GetMapping("/photoBoardList.do")
	public String selectPhotoBoardList(Model model) {
		 List<Board> boardList = boardService.selectPhotoBoard();
		 Map<String, Object> commentCountMap = new HashMap<>();
		    
		    for (Board board : boardList) {
		        List<BoardComment> commentList = boardService.selectCommentListByBoardNo(board.getNo());
		        int likeCount = boardService.selectBoardCountByNo(board.getNo());
		        board.setLikeCount(likeCount);
		        board.setCommentList(commentList);
		        
		        int commentCount = boardService.selectBoardCommentCount(board.getNo());
		        commentCountMap.put("CommentCount", commentCount);
		    }
		    
		    model.addAttribute("commentCountMap", commentCountMap);
		    model.addAttribute("boardList", boardList);
		    return "/board/photoBoardList";
		}
	
	@GetMapping("/menuBoardList.do")
	private void menuBoardList(@RequestParam(defaultValue = "1") int cpage, Model model) {
	
			int limit = 20;
			int offset = (cpage - 1) * limit; 
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			List<Board> boardList = boardService.selectMenuBoardList(rowBounds);
			log.debug("boardList = {}", boardList);
			
			// 총 게시물 수
		    int totalCount = boardService.selectBoardCount();
		    log.debug("totalCount = {}", totalCount);

		    // 총 페이지 수 계산
		    int totalPage = (int) Math.ceil((double) totalCount / limit);
		    log.debug("totalPage = {}", totalPage);

		    // 시작 페이지와 끝 페이지 계산
		    int startPage = ((cpage - 1) / 20) * 20 + 1; // 10 페이지씩 묶어서 보여줌
		    int endPage = Math.min(startPage + 19, totalPage);
			
			
		    model.addAttribute("boardList", boardList);
		    model.addAttribute("currentPage", cpage);
		    model.addAttribute("startPage", startPage);
		    model.addAttribute("endPage", endPage);
		    model.addAttribute("totalPage", totalPage);
	}
	
	@PostMapping("/boardCommentEnroll.do")
	public String boardCommentEnroll(BoardComment boardComment, Board board, @RequestParam String no, Authentication authentication) {
		log.debug("boardComment = {}", boardComment);

		String boardNo = board.getNo();
		boardComment.setBoardNo(boardNo);
		
		int result = boardService.insertBoardComment(boardComment);
		
		return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}
	
	@PostMapping("/boardCommentUpdate.do")
	@ResponseBody
	public Map<String, Object> boardCommentUpdate(@RequestBody BoardComment boardComment) {
	    int result = boardService.updateBoardComment(boardComment);
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("result", result > 0 ? "success" : "fail");
	    return responseData;
	}
	
	@PostMapping("/commentEnroll.do")
	@ResponseBody
	public String boardCommentEnroll(@RequestBody BoardComment boardComment, Authentication authentication, Board board) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    boardComment.setEmpId(empId);
	    boardComment.setBoardNo(board.getNo());
	    boardComment.setCommentLevel(0); // 댓글의 경우 기본 레벨 0
	    
	    log.debug("boardComment = {} ", boardComment);
	    int result = boardService.insertBoardComment(boardComment);
	   
	    return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}
	
	@PostMapping("/boardLikeUp.do")
	@ResponseBody
	public Map<String, Object> boardlikeUp(@RequestBody BoardLike boardLike) {
	Map<String, Object> resultMap = new HashMap<>();
	 
	try {
	    int result = boardService.boardlikeUp(boardLike);
	    resultMap.put("result", "success");
	    log.debug("resultMap = {}", resultMap);
	} catch (Exception e) {
	    resultMap.put("result", "fail");
	    log.error("Failed to like a board: {}", e.getMessage(), e);
	}
	return resultMap;
}


	@PostMapping("/boardLikeDown.do")
	@ResponseBody
	public Map<String, Object> boardlikeDown(@RequestBody BoardLike boardLike) {
	Map<String, Object> resultMap = new HashMap<>();

	try {
	    int result = boardService.boardlikeDown(boardLike);
	    resultMap.put("result", "success");
	    log.debug("resultMap = {}", resultMap);
	} catch (Exception e) {
	    resultMap.put("result", "fail");
	    log.error("Failed to unlike a board: {}", e.getMessage(), e);
	}
	return resultMap;
	}

	@GetMapping("/boardLikeCheck.do")
	@ResponseBody
	public Map<String, Object> boardLikeCheck(@RequestParam("boardNo") String boardNo, @RequestParam("empId") String empId, Model model) {
			Map<String, Object> result = new HashMap<>();
			try {
					BoardLike boardLike = new BoardLike();
					boardLike.setBoardNo(boardNo);
					boardLike.setEmpId(empId);
					log.debug("boardLike = {}", boardLike);
			
			 Map<String, Object> likeMap = boardService.selectBoardLikeCheck(boardLike);
			    log.debug("likeMap = {}", likeMap);
			    String likeYn = (String) likeMap.get("ISLIKED");
			    	log.debug("likeYn = {}", likeYn);
				    if ("N".equals(likeYn)) { // 좋아요 정보가 없는 경우
				        result.put("isLiked", false);
				    } else {
				        result.put("isLiked", true);
				    }
			    result.put("likeCount", likeMap.get("LIKECOUNT"));
			    result.put("result", "success");
			    log.debug("result = {}", result);
			} catch (Exception e) {
			    result.put("result", "error");
			    result.put("message", "좋아요 확인 중 오류가 발생했습니다.");
			    e.printStackTrace();
			}
			model.addAttribute("result", result);
			return result;
		}
	
	
	
	
	
	@GetMapping("/boardForm.do")
	private void boardForm() {}
	
	@GetMapping("/boardAdd.do")
	private void boardCreate() {}
	
	
	@PostMapping("/boardTypeAdd.do")
	public String boardTypeAdd(BoardType boardType, Model model) {
		log.debug("boardType = {}", boardType);
		
		int result = boardService.insertBoardType(boardType);
		List<BoardType> boardTypeList = boardService.selectBoardTypeList();
		
		model.addAttribute("boardTypeList", boardTypeList);
		
		return "redirect:/board/boardTypeList.do?no=" + boardType.getNo() + "&category=" + boardType.getCategory();
	} // boardTypeAdd() end
	
	
	@GetMapping("/boardTypeList.do")
	public String boardTypeList(String no, String category, @RequestParam(defaultValue = "1") int cpage, Model model) {
		log.debug("no = {}, category = {}", no, category);
		
		// 페이징처리
		int limit = 20;
		int offset = (cpage - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Board> boardList = boardService.findByNoBoardList(no, rowBounds);
		log.debug("boardList = {}", boardList);

		// 총 게시물 수
	    int totalCount = boardService.selectBoardNoCount(no);
	    log.debug("totalCount = {}", totalCount);

	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) totalCount / limit);
	    log.debug("totalPage = {}", totalPage);

	    // 시작 페이지와 끝 페이지 계산
	    int startPage = ((cpage - 1) / 10) * 10 + 1; // 10 페이지씩 묶어서 보여줌
	    int endPage = Math.min(startPage + 9, totalPage);
	    
	    //댓글
	    Map<String, Object> commentCountMap = new HashMap<>();
	    
	    for (Board board : boardList) {
	        List<BoardComment> commentList = boardService.selectCommentListByBoardNo(board.getNo());
	        int likeCount = boardService.selectBoardCountByNo(board.getNo());	        
	        board.setLikeCount(likeCount);
	        board.setCommentList(commentList);

	        int commentCount = boardService.selectBoardCommentCount(board.getNo());
	        board.setCommentCount(commentCount);
	    }
	   
	    
	    log.debug("commentCountMap = {}", commentCountMap);
	    log.debug("boardList = {}", boardList);
	    
	    model.addAttribute("commentCountMap", commentCountMap);
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("currentPage", cpage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPage", totalPage);
		
		switch (category) {
		case "C":
			return "board/boardClassicList";
		case "F":
			return "board/boardFeedList";
		} // switch end
		
		return "board/boardHome";
	} // boardTypeList() end
	
}
