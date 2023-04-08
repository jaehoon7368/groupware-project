package com.sh.groupware.workingManagement;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.Map;

public class Calendar {
	
	public Map<String, Map<String, Object>> updateDateText(LocalDate date) {
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	    System.out.println(date.format(formatter));

	    // 현재 달의 첫 번째 날짜와 마지막 날짜를 가져옴.
	    LocalDate firstDate = date.with(TemporalAdjusters.firstDayOfMonth());
	    LocalDate lastDate = date.with(TemporalAdjusters.lastDayOfMonth());

	    // 첫 번째 날짜가 어떤 요일인지 가져옴.
	    DayOfWeek firstDayOfWeek = DayOfWeek.of(1); // 월요일로 설정
	    LocalDate firstDayOfThisWeek = firstDate.with(TemporalAdjusters.previousOrSame(firstDayOfWeek));
	    int firstWeekday = firstDayOfThisWeek.getDayOfWeek().getValue();

	    // 마지막 날짜가 몇 주차인지 계산.
	    int lastWeek = (int) Math.ceil((lastDate.getDayOfMonth() + firstWeekday - 1) / 7.0);

	    // 주차별 날짜를 계산합니다.
	    Map<String, Map<String, Object>> weekDates = new HashMap<>();
	    LocalDate weekStart = firstDayOfThisWeek; // 현재 달의 첫 주 시작 날짜
	    for (int i = 1; i <= lastWeek; i++) {
	        LocalDate weekEnd = weekStart.plusDays(6); // 현재 주의 마지막 날짜
	        if (weekEnd.isAfter(lastDate)) { // 현재 주의 마지막 날짜가 현재 달의 마지막 날짜를 넘어가면 현재 달의 마지막 날짜로 설정.
	            weekEnd = lastDate;
	        }
	        String start = weekStart.format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	        String end = weekEnd.format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	        Map<String, Object> week = new HashMap<>();
	        week.put("start", start);
	        week.put("end", end);
	        weekDates.put(i + "주차", week); // key에는 "n주차", value에는 start와 end를 저장한 Map을 저장.
	        weekStart = weekEnd.plusDays(1); // 다음 주의 시작 날짜
	    }

	    // 종료일을 일요일로 변경
	    LocalDate endDayOfThisWeek = lastDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
	    weekDates.get(lastWeek + "주차").put("end", endDayOfThisWeek.format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));

	    return weekDates;
	}
    

}

