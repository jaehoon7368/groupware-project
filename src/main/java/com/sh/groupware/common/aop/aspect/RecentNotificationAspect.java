package com.sh.groupware.common.aop.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sh.groupware.common.aop.service.RecentNotificationService;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Aspect
@Component
public class RecentNotificationAspect {

	/*
	 * @Autowired private RecentNotificationService recentNotificationService;
	 * 
	 * 
	 * @Pointcut("execution(* com.sh.groupware..*(..))") public void pointcut() {}
	 * 
	 * @AfterReturning("pointcut()") public void sendNotification (JoinPoint
	 * joinPint,Object returnObj) {
	 * 
	 * 
	 * }
	 * 
	 * @AfterReturning(pointcut="pointcut()", returning="returnObj") public void
	 * afterReturningAdvice(JoinPoint joinPoint, Object returnObj) { //타겟메소드의 리턴
	 * 데이터를 다른 용도로 처리할 때 사용함.
	 * recentNotificationService.recentNotification(joinPoint,returnObj); }
	 */
	
	
}
