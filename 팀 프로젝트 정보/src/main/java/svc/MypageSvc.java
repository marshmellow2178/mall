package svc;

import java.sql.ResultSet;
import java.util.*;
import dao.*;
import vo.*;

public class MypageSvc {
	private MypageDao mypageDao;
	public MypageSvc(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	}
	public int getMiList(String miid,String pw){
		int result = mypageDao.getMiList(miid,pw);
		
		return result;
	}
	public MemberAddr getMaList(String miid){
		MemberAddr maList = mypageDao.getMaList(miid);	
		
		return maList;
	}
	public int getPointListCount(String miid) {
		int result =0;
		result = mypageDao.getPointListCount(miid);
		return result;
	}
	public List<PointInfo> getPointList(String miid,int cpage,int psize){
		
		 List<PointInfo> pointList = mypageDao.getPointList(miid,cpage,psize);
		 return pointList;
		 
	}
	public PointInfo getPointSum(String miid) {
		PointInfo pointtotal = mypageDao.getPointSum(miid);
		
		return pointtotal;
		
	}
	public int getCouponListCount(String miid) {
		int result=0;
		return result;
	}
	public List<Coupon> getCouponList(String miid, int cpage, int psize){
		 List<Coupon> couponList =null;
		
		 return couponList;
	}
	
}
