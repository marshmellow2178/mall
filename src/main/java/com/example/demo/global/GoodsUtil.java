package com.example.demo.global;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class GoodsUtil {

	public static String getDateFormat(LocalDateTime ldt) {
		if(ldt==null) {
			return "";
		}
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
	
	public static int point_calculate(int point, int days) {	//포인트, 연속출석날짜 -> 최종 포인트
		if(days>=3) { point += 100; }
		if(days>=7) { point += 300; }
		if(days>=15) { point += 500; }
		if(days==LocalDateTime.now().toLocalDate().lengthOfMonth()) { point *= 2; }
		return point;
	}
	
	public static String attendance_level(int num, int lastday) {
		if(num<=0) { return "";}
		String str = "level";
		if(num<3) {
			str += "1";
		}else if(num<7) {
			str += "2";
		}else if(num<15) {
			str += "3";
		}else if(num<lastday){
			str += "4";
		}else {
			str += "5";
		}
		return str;
	}
}
