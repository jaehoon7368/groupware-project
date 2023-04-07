package com.sh.groupware.address.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.groupware.address.model.dto.AddressBook;
import com.sh.groupware.address.model.dto.AddressGroup;
import com.sh.groupware.address.model.dto.AddressSubMenu;
import com.sh.groupware.address.model.service.AddrService;
import com.sh.groupware.board.model.dto.Board;
import com.sh.groupware.common.HelloSpringUtils;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.emp.model.service.EmpService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/addr")
@SessionAttributes({"addrGroupList"})
public class AddrBookController {

	@Autowired
	private AddrService addrService;

	@Autowired
	private EmpService empService;

	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	
	
	@GetMapping("/addrHome.do")
	public String addrHome(@RequestParam(defaultValue = "1") int cpage, @RequestParam(defaultValue = "전체") String keyword , Model model, AddressBook addressBook, AddressGroup addressGroup, Authentication authentication) {
	    String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    log.debug("loginMemberId = {}", empId);
	    addressBook.setWriter(empId);

	    // 페이징 처리
	    int limit = 10;
	    int offset = (cpage - 1) * limit; 
	    RowBounds rowBounds = new RowBounds(offset, limit);

	    List<AddressBook> addrBookList = new ArrayList<>();
	    if("전체".equals(keyword)) {
	    	 addrBookList = addrService.selectAddrBookListByPage(empId, rowBounds);
	    } else {
	    	addrBookList = addrService.filterNamesByKeyword(keyword); // 초성에 해당하는 이름 리스트를 가져옴
	    }
	    
	    log.debug("addrBookList = {}", addrBookList);

	    int totalCount = addrService.selectAddrBookCountById(empId);
	    log.debug("totalCount = {}", totalCount);
	    int totalPage = (int) Math.ceil((double) totalCount / limit);
	    log.debug("totalPage = {}", totalPage);

	    int startPage = ((cpage - 1) / 10) * 10 + 1; // 10 페이지씩 묶어서 보여줌
	    int endPage = Math.min(startPage + 9, totalPage);

	    List<AddressGroup> addrGroupList = addrService.selectGroupName(empId);
	    log.debug("addrGroupList = {}", addrGroupList);
	    addrGroupList.sort(Comparator.comparing(AddressGroup::getGroupName));

	    model.addAttribute("addrBookList", addrBookList);
	    model.addAttribute("addrGroupList", addrGroupList);
	    model.addAttribute("currentPage", cpage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("keyword", keyword);
	    
	    return "addr/addrHome";
	}
	
	@PostMapping("/createAddrGroup.do")
	public String createAddrGroup(Authentication authentication, @RequestParam("groupName") String groupName, AddressGroup addressGroup, AddressBook addressBook) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		log.debug("empId = {}", empId);
		
		addressGroup.setEmpId(empId);
		addressGroup.setGroupName(addressBook.getGroupName());
		addressGroup.setGroupType(addressBook.getGroupType());
		
		int result = addrService.insertAddrGroup(addressGroup);
		
		return "redirect:/addr/addrHome.do";
		
	}
	
	@GetMapping("/addrListForm.do")
	public String addrListForm(Model model,  @RequestParam("groupName") String groupName, Authentication authentication) {
		String empId = ((Emp) authentication.getPrincipal()).getEmpId();
		
	    List<AddressGroup> addrGroupByName = addrService.selectAddrBookListByGroupName(groupName);
	    List<AddressGroup> addrGroupNameList = addrService.selectGroupName(empId);
		
		log.debug("addrGroupNameList = {}", addrGroupNameList);
		
		model.addAttribute("addrGroupByName", addrGroupByName);
	    model.addAttribute("addrGroupNameList", addrGroupNameList);
	    return "addr/addrListForm";
	}
	

	
	@GetMapping("/addrEnrollForm.do")
	public String getSubMenu(Authentication authentication, Model model) {
	    String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    List<AddressGroup> addressGroups = addrService.findByEmpId(empId);
	    log.debug("addressGroups = {}", addressGroups);
	    
	    List<String> groupNames = new ArrayList<>();
	    for (AddressGroup group : addressGroups) {
	        groupNames.add(group.getGroupName());
	    }
	    log.debug("groupNames = {}", groupNames);
	    
	    model.addAttribute("groupNames", groupNames);
	    return "addr/addrEnrollForm";
	}
	 
		
	
	@GetMapping("/addrAnywhere.do")
	public void addrAnywhere(@RequestParam(defaultValue = "1") int cpage, Model model, Authentication authentication ) {
		// 페이징처리
				int limit = 10;
				int offset = (cpage - 1) * limit; 
				RowBounds rowBounds = new RowBounds(offset, limit);
				
				log.debug("authentication = {}", authentication);
				Emp principal = (Emp) authentication.getPrincipal();
				
				String empId = principal.getEmpId();
				//내 인사정보 가져오기
				EmpDetail empInfo = empService.selectEmpDetail(empId);
				
				List<EmpDetail> empList = empService.selectEmpAll(rowBounds);
				log.debug("empList = {}", empList);
				
				
				
//				List<AddressBook> addressBookList = new ArrayList<>();
//				log.debug("addressBookList = {}", addressBookList);
//				
				
				
				
				// 총 게시물 수
			    int totalCount = addrService.selectAddressBookCount();
			    log.debug("totalCount = {}", totalCount);

			    // 총 페이지 수 계산
			    int totalPage = (int) Math.ceil((double) totalCount / limit);
			    log.debug("totalPage = {}", totalPage);

			    // 시작 페이지와 끝 페이지 계산
			    int startPage = ((cpage - 1) / 10) * 10 + 1; // 10 페이지씩 묶어서 보여줌
			    int endPage = Math.min(startPage + 9, totalPage);
			    
			    model.addAttribute("empList", empList);
//			    model.addAttribute("addressBookList", addressBookList);
			    model.addAttribute("currentPage", cpage);
			    model.addAttribute("startPage", startPage);
			    model.addAttribute("endPage", endPage);
			    model.addAttribute("totalPage", totalPage);
	}
	
	@PostMapping("/addrEnroll.do")
	public String addrEnroll(
			 AddressBook addressBook,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			RedirectAttributes redirectAttr) {
		
		log.debug("addressBook = {}", addressBook);
			
			String saveDirectory = application.getRealPath("/resources/upload/addr");
			log.debug("saveDirectory = {}", saveDirectory);
			
			// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
			for(MultipartFile upFile : upFiles) {
				log.debug("upFile = {}", upFile);
				
				if(upFile.getSize() > 0) {
					// 1. 저장 
					String pkNo = addressBook.getAddrNo();
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
					addressBook.addAttachment(attach);
				}
			}
			log.debug("addressBook = {}", addressBook);
			int result = addrService.insertAddrbook(addressBook);
			redirectAttr.addFlashAttribute("msg", "주소록을 성공적으로 저장했습니다.");
		
		
		return "redirect:/addr/addrHome.do";
	}
	
	@GetMapping("/addrUpdateForm.do")
	public String addrUpdateFrom(@RequestParam String addrNo, Model model) {
		 AddressBook addressBook = addrService.selectOneAddrCollection(addrNo);
		 model.addAttribute("addressBook", addressBook);
		    
		 return "addr/addrUpdateForm"; 
	}
	
	@PostMapping("/addrUpdate.do")
	public String updateBoard(AddressBook addressBook,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			@RequestParam String addrNo,
			RedirectAttributes redirectAttr){
		
		String saveDirectory = application.getRealPath("/resources/upload/board");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			
			if(upFile.getSize() > 0) {
				// 1. 저장 
				String pkNo = addressBook.getAddrNo();
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
				addressBook.addAttachment(attach);
			}
	    }
		log.debug("addressBook = {}", addressBook);
	    int result = addrService.updateAddrBook(addressBook);
	    
	    return "redirect:/addr/addrUpdateForm.do?addrNo=" + addressBook.getAddrNo();
	}
	
	@GetMapping("/keywordSearch.do")
	@ResponseBody
	public List<AddressBook> filterNames(@RequestParam("keyword") String keyword) {
		
	    List<AddressBook> names = addrService.filterNamesByKeyword(keyword); // 초성에 해당하는 이름 리스트를 가져옴
	    return names; // HTTP 응답으로 이름 리스트 반환
	}
	
	@PostMapping("/addrsDelete.do")
	private String addrsDelete(@RequestParam(value = "addrNos[]", required = false) List<String> addrNos,
	                           Authentication authentication, RedirectAttributes redirectAttributes) {
	    String empId = ((Emp) authentication.getPrincipal()).getEmpId();
	    log.debug("addrNos 시작 = {}", addrNos);
	    
//	    List<AddressBook> addrsToDelete = addrService.selectAddrsByNos(addrNos);
//	    log.debug("addrNos 끝 = {}", addrNos);
//	    log.debug("addrsToDelete = {}", addrsToDelete);
//	    List<String> failedNos = new ArrayList<>();
//	    for (AddressBook addressBook : addrsToDelete) { 
//	            failedNos.add(addressBook.getAddrNo());
//	        }

	        int result = addrService.deleteAddrs(addrNos);

	    return "redirect:/addr/addrHome.do";
	}
	
	@PostMapping("/addrDelete.do")
	private String addrDelete(@RequestParam String addrNo, Authentication authentication, RedirectAttributes redirectAttributes) {
		
		log.debug("보드삭제 no 확인 = {}", addrNo);

	    AddressBook addressBook = addrService.selectAddrByNo(addrNo); // 삭제하려는 게시물 가져오기
	
	        int result = addrService.deleteAddr(addrNo);
	   
	    return "redirect:/addr/addrHome.do";
	}
	
	
}
