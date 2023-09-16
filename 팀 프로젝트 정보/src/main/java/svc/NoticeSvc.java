package svc;

import java.util.*;
import dao.*;
import vo.*;


public class NoticeSvc {
	private NoticeDao noticeDao;
	public NoticeSvc(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	public int getNoticeCount(String where) {
		int result = noticeDao.getNoticeCount(where);
		
		return result;
	}
	public List<NoticeInfo>getNoticeList(String where,int cpage,int psize){
		List<NoticeInfo> noticeList = noticeDao.getNoticeList(where,cpage,psize);
		return noticeList;
	}
	public NoticeInfo getNoticeView(int bnidx) {
		NoticeInfo noticeView = noticeDao.getNoticeView(bnidx);
		return noticeView;
	}
	public List<FaqInfo>getfaqList(String kind){
		List<FaqInfo> faqList = noticeDao.getfaqList(kind);
		return faqList;
	}
	public int updateRead(int bnidx) {
		int result = noticeDao.updateRead(bnidx);
		return result;
	}
	public int mantomanInsert(String kind,String title,String cont,String miid) {
		int result = noticeDao.mantomanInsert(kind,title,cont,miid);
		return result;
	}
	
}
