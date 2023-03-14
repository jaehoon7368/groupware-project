package com.sh.groupware.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;



@Slf4j
public class LoggerInterceptor extends HandlerInterceptorAdapter{
	
	/**
	 * 전처리 Handler 호출전
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("===================================================");
		log.debug(request.getMethod() + " " + request.getRequestURI());
		log.debug("===================================================");
		return super.preHandle(request, response, handler);
	}
	
	/**
	 * 후처리 Handler 리턴후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
		
		log.debug("-------------------------------------------------------");
		log.debug("ModelAndView = " + modelAndView);
	}
	
	/**
	 * view단 응답처리 후
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		log.debug("-------------------------------------------------------");
		super.afterCompletion(request, response, handler, ex);
		log.debug("=========================================================");
		log.debug("");
	}
}
