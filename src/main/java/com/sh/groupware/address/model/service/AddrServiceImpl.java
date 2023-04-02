package com.sh.groupware.address.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.groupware.address.model.dao.AddrBookDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j

public class AddrServiceImpl implements AddrService {

	@Autowired
	private AddrBookDao addrBookDao;
}
