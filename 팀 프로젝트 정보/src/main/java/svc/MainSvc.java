package svc;


import java.awt.Event;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.*;
import vo.*;


public class MainSvc {
	private MainDao mainDao;
	public MainSvc(MainDao mainDao) {
		this.mainDao = mainDao;
	}
	public List<ProductInfo>  getMDProduct(){
		List<ProductInfo> eventList = mainDao.getMDProduct();
		return eventList;
	} 
	public List<ArtistCode>  getWeekBest(){
		List<ArtistCode> weekList = mainDao.getWeekBest();
		return weekList;
	} 
	public List<ArtistCode>  getAlBest(){
		List<ArtistCode> AlList = mainDao.getAlBest();
		return AlList;
	} 
	public List<ArtistCode>  getProductBest(){
		List<ArtistCode> ProductList = mainDao.getProductBest();
		return ProductList;
	} 
}
