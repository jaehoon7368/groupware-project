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
	public void addrHome(Model model, AddressBook addressBook, AddressGroup addressGroup, Authentication authentication) {
			String empId = ((Emp) authentication.getPrincipal()).getEmpId();
			log.debug("loginMemberId = {}", empId);
			List<AddressBook> addrBookList = addrService.selectAllAddrBookList(empId);
			addressBook.setWriter(empId);
			log.debug("addrBookList = {} ", addrBookList);
			
			List<AddressGroup> addrGroupList = addrService.selectGroupName(empId);
			log.debug("addrGroupList = {}", addrGroupList);
			
			// 이름으로 정렬
		    addrGroupList.sort(Comparator.comparing(AddressGroup::getGroupName));
			
			model.addAttribute("addrGroupList", addrGroupList);
			model.addAttribute("addrBookList", addrBookList);
			
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
	public String addrListForm(Model model,  @RequestParam("groupName") String groupName) {
	    List<AddressGroup> addrGroupList = addrService.selectAddrBookListByGroupName(groupName);
	    model.addAttribute("addrGroupList", addrGroupList);
	    model.addAttribute("groupName", groupName);
	    return "addr/addrListForm";
	}
	
	
	
	@GetMapping("/addrEnrollForm.do")
	public void addrEnrollForm() {
		
		
	}
	
//	  @GetMapping("/addrEnrollForm.do") public ResponseEntity<List<String>>
//	  getSubMenu(@RequestParam(value = "groupType") String groupType) {
//	  List<String> subMenuList = new ArrayList<>();
//	  
//	  List<AddressGroup> addressGroups = addrService.findByGroupType(groupType);
//	  log.debug("personalAddressGroups = {}", addressGroups); for (AddressGroup
//	  personalAddressGroup : addressGroups) {
//	  subMenuList.add(personalAddressGroup.getGroupName());
//	  log.debug("subMenuList = {}", subMenuList); }
//	 
//	 
//	  return ResponseEntity.ok(subMenuList); }
	 
		
	
	@GetMapping("/addrAnywhere.do")
	public void addrAnywhere(@RequestParam(defaultValue = "1") int cpage, Model model ) {
		// 페이징처리
				int limit = 20;
				int offset = (cpage - 1) * limit; 
				RowBounds rowBounds = new RowBounds(offset, limit);
				
				List<AddressBook> addressBookList = new ArrayList<>();
				log.debug("addressBookList = {}", addressBookList);
				List<Emp> empList = addrService.selectEmpList(rowBounds);
				log.debug("empList = {}", empList);
				for (Emp emp : empList) {
					
			        AddressBook addressBook = new AddressBook();
			        addressBook.setName(emp.getName());
			        addressBook.setJobName(emp.getJobCode());
			        addressBook.setPhone(emp.getPhone());
			        addressBook.setEmail(emp.getEmail());   
			        addressBook.setDeptTitle(emp.getDeptCode());

			        
			        addressBookList.add(addressBook);
			    }
				
				// 총 게시물 수
			    int totalCount = addrService.selectAddressBookCount();
			    log.debug("totalCount = {}", totalCount);

			    // 총 페이지 수 계산
			    int totalPage = (int) Math.ceil((double) totalCount / limit);
			    log.debug("totalPage = {}", totalPage);

			    // 시작 페이지와 끝 페이지 계산
			    int startPage = ((cpage - 1) / 20) * 20 + 1; // 10 페이지씩 묶어서 보여줌
			    int endPage = Math.min(startPage + 19, totalPage);
			    
				
				
			    model.addAttribute("addressBookList", addressBookList);
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
	

	
	
	
	
	
}
