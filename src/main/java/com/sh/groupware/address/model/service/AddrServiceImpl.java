package com.sh.groupware.address.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.address.model.dao.AddrBookDao;
import com.sh.groupware.address.model.dto.AddressBook;
import com.sh.groupware.address.model.dto.AddressGroup;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class AddrServiceImpl implements AddrService {

	@Autowired
	private AddrBookDao addrBookDao;
	
	@Override
	public int insertAddrbook(AddressBook addressBook) {
		
		// 게시글 등록 - 동시에 채번된 pk를 조회
				int result = addrBookDao.insertAddrbook(addressBook);
				log.debug("addressBook = {}", addressBook);
				// 첨부파일 등록
				List<Attachment> attachments = addressBook.getAttachments();
				if(attachments.size() > 0) {
					for(Attachment attach : attachments) {
						attach.setPkNo(addressBook.getAddrNo()); // fk설정
						result = insertAttachment(attach);
					}
				}
				return result;
	}

	private int insertAttachment(Attachment attach) {
		return addrBookDao.insertAttachment(attach);
	}
	
	@Override
	public List<Emp> selectEmpList(RowBounds rowBounds) {
		return addrBookDao.selectEmpList(rowBounds);
	}
	
	@Override
	public int selectAddressBookCount() {
		return addrBookDao.selectAddressBookCount();
	}
	
	@Override
	public List<AddressBook> selectAllAddrBookList(String empId) {
		return addrBookDao.selectAllAddrBookList(empId);
	}
	
	@Override
	public int insertAddrGroup(AddressGroup addressGroup) {
		return addrBookDao.insertAddrGroup(addressGroup);
	}
	
	@Override
	public List<AddressGroup> selectGroupName(String empId) {
		return addrBookDao.selectGroupName(empId);
	}
	
	@Override
	public List<AddressGroup> selectAddrBookListByGroupName(String groupName, RowBounds rowBounds) {
		return addrBookDao.selectAddrBookListByGroupName(groupName, rowBounds);
	}
	
	@Override
	public List<AddressGroup> findByEmpId(String empId) {
		return addrBookDao.findByEmpId(empId);
	}
	
	@Override
	public AddressBook selectOneAddrCollection(String addrNo) {
		return addrBookDao.selectOneAddrCollection(addrNo);
	}
	
	@Override
	public int updateAddrBook(AddressBook addressBook) {
		return addrBookDao.updateAddrBook(addressBook);
	}
	
	@Override
	public List<AddressBook> selectAddrBookListByPage(String empId, RowBounds rowBounds) {
		return addrBookDao.selectAddrBooklistByPage(empId, rowBounds);
	}
	
	@Override
	public int selectAddrBookCountById(String empId) {
		return addrBookDao.selectAddressBookCountById(empId);
	}
	
	@Override
	public List<AddressBook> filterNamesByKeyword(String keyword) {
		return addrBookDao.filterNamesByKeyword(keyword);
	}
	
	@Override
	public List<AddressBook> selectAddrsByNos(List<String> addrNos) {
		return addrBookDao.selectAddrsByNos(addrNos);
	}
	
	@Override
	public int deleteAddrs(List<String> addrNos) {
		return addrBookDao.deleteAddrs(addrNos);
	}
	
	@Override
	public AddressBook selectAddrByNo(String addrNo) {
		return addrBookDao.selectAddrByNo(addrNo);
	}
	
	@Override
	public int deleteAddr(String addrNo) {
		return addrBookDao.deleteAddr(addrNo);
	}
	
	@Override
	public int selectAddrBookListByGroupNameCount(String groupName) {
		return addrBookDao.selectAddrBookListByGroupNameCount(groupName);
	}
}

