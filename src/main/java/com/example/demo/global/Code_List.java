package com.example.demo.global;

public final class Code_List {
	//db에는 1글자로, 화면에는 설명으로 표시하기
	//회원
	public final static String NORMAL_USER = "n";
	public final static String IDLE_USER = "i";
	public final static String DELETE_USER = "d";
	public final static String BANNED_USER = "b";
	
	//포인트
	public final static int SAVE_RATE = 100;	//1/100
	public final static int USE_RATE = 1;
	public final static int REGISTER_POINT = 1000;
	
	public final static String JOIN = "가입 축하금";
	public final static String ADMIN = "관리자";
	public final static String ATTENDANCE = "출석체크";
	
	public final static String SAVE = "구매 적립";
	public final static String USE = "구매 사용";
	
	//어드민
	public static final int SYSTEM = 0;
	
	//주문상태
	public static final String PAID = "p";
	public static final String START = "s";
	public static final String COMPLETE = "c";
	
	//상품
	public static final String IS_VIEW = "y";
	public static final String DELETE = "n";
	public static final int DELIVERY = 3000;
	public static final int FREE_DELIVER = 50000;
	
	//이벤트
	public static final String getEventStatus(String status) {
		String res = "";
		if(status.equals("o")) res = "진행중";
		else if(status.equals("w")) res = "대기중";
		else if(status.equals("c")) res = "종료";	
		else res = "비공개";
		return res;
	}
	
	public static final String EVENT_TYPE_ATT= "a";		//출석체크
	public static final String EVENT_TYPE_NORMAL= "n";	//일반
	
	//Faq&문의
	public static final String getQuestionCtgr(String ctgr) {
		String res="";
		if(ctgr==null || ctgr.equals("")) {
			res = "전체";
		}else if(ctgr.equals("m")) {
			res = "회원";
		}else if(ctgr.equals("p")) {
			res = "상품";
		}else if(ctgr.equals("o")) {
			res = "주문";
		}else {
			res = "기타";
		}
		return res;
	}
	
	//공지사항
	public static final String getNoticeCtgr(String ctgr) {
		String res="";
		if(ctgr==null || ctgr.equals("")) {
			res = "전체";
		}else if(ctgr.equals("n")) {
			res = "일반";
		}else if(ctgr.equals("a")) {
			res = "중요";
		}else {
			res = "기타";
		}
		return res;
	}
	
	//업로드
	public static final String PRODUCT_IMG = "resources/static/img/product_img/";
	public static final String EVENT_IMG = "resources/static/img/event_img/";
}
