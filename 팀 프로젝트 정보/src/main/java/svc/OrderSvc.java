package svc;


import java.util.*;
import dao.*;
import vo.*;


public class OrderSvc {
	private OrderDao orderDao;
	public OrderSvc(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	public List<OrderCart> getcartList(String miid){
		List<OrderCart> cartList = orderDao.getCartList(miid);
		return cartList;
	}
	public List<OrderCart> getBuyList(String kind,String sql){
		List<OrderCart> buylist = orderDao.getBuyList(kind,sql);
		System.out.println(sql);
		return buylist;
	}
	public List<MemberAddr> getAddrList(String miid){
		List<MemberAddr> addrlist = orderDao.getAddrList(miid);
		return addrlist;
	}
	public String  orderInsert(String kind, OrderInfo oi, String tmep) {
		String result="";
		
		result = orderDao.orderInsert(kind, oi, tmep);
		
		return result;
	}
	public OrderInfo getOrderEndInfo(String miid,String oiid) {
		OrderInfo orderInfo = orderDao.getOrderEndInfo(miid, oiid);
		
		return orderInfo;
	}
	public 	List<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		List<OrderInfo> orderInfo = (List<OrderInfo>) orderDao.getOrderList(miid,cpage,psize);
		return orderInfo;
	}
	public int getOrderCount(String miid) {
		int rcnt = orderDao.getOrderCount(miid);
		
		return rcnt;
	}
	public OrderInfo getOrderInfo (String miid,String oiid) {
		OrderInfo orderInfo = orderDao.getOrderInfo(miid,oiid);
		return orderInfo;
	}
	
}
