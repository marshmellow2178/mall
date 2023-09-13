package com.example.demo.global;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class GoodsUtil {

	public static String getDateFormat(LocalDateTime ldt) {
		return ldt.getMonthValue()+"월 "+ldt.getDayOfMonth()+"일";
	}
	
	public static String boardDateFormat(LocalDateTime ldt) {
		String result = "";
		LocalDateTime today = LocalDateTime.of(LocalDate.now(), LocalTime.of(0, 0, 0));
		
		if(ldt.getYear()<today.getYear()) {
			result = ldt.getYear()+"."+ldt.getMonthValue()+"."+ldt.getDayOfMonth();
		}
		else if(ldt.getDayOfYear() < today.getDayOfYear()) {
			result = ldt.getMonthValue()+"."+ldt.getDayOfMonth();
		}
		else{
			result = ldt.getHour()+":"+ldt.getMinute();
		}
		return result;
	}
	
	public static String secToMin(int second) {
		int min = second/60;
		second = second%60;
		return min+" : "+second;
	}
}
