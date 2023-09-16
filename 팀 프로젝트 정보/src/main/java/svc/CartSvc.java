package svc;

import java.util.*;
import dao.*;
import vo.*;

public class CartSvc {
	private OrderDao orderDao;
	
	public CartSvc(OrderDao orderDao) {
	this.orderDao = orderDao;
	}
	public List<OrderCart> getcartList(String miid){
		List<OrderCart> cartList = orderDao.getCartList(miid);
		
		return cartList;	
	}
	public int cartUpdate(OrderCart oc) {
		int result =0;
		result = orderDao.cartUpdate(oc);
		
		return result;
	}
	public int cartDelete(String where) {
		int result = 0;
		result = orderDao.cartDelete(where);
		
		return result;
	}
	public int cartInsert(OrderCart oc) {
		int result =0;
		result = orderDao.cartInsert(oc);
		
		return result;
	}
}
