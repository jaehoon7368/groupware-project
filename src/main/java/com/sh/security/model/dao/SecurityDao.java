package com.sh.security.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

@Mapper
public interface SecurityDao {

	UserDetails loadUserByUsername(String username);

}
