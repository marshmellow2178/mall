package svc;


import java.util.*;
import dao.*;
import vo.*;

public class ProductSvc {
	private ProductDao productDao;
	

	public ProductSvc(ProductDao productDao) {
		this.productDao = productDao;
	}

	public int getProductCount(String where) {
		int rcnt = productDao.getProductListCount(where);
		return rcnt;
	}
	public List<ProductInfo> getProductList(int cpage, int psize, String where,String orderby){
		List<ProductInfo> productList = productDao.getProductList(cpage, psize, where, orderby);
		return productList;
	}
	public ProductInfo getProductView(String piid) {
		ProductInfo pi = productDao.getProductView(piid);
		return pi;
	}
	public void readUpdate(String piid) {
		productDao.readUpdate(piid);
	}
	public ArrayList<ProductStock> getProductStock(String piid) {
		ArrayList<ProductStock> psList = new ArrayList<ProductStock>();
		psList = productDao.getProductStock(piid,null);
		
		return psList;
	}
	public List<ProductInfo>getCommingList(int cpage){
		List<ProductInfo> commingList = productDao.getCommingList(cpage);
		return commingList;
	}
	public int getCommingCount() {
		int result =  productDao.getCommingCount();
		return result;
	}
	public List<ArtistCode> getBigList(){
		List<ArtistCode> bigList = productDao.getBigList();
		return bigList;
	}
	public List<ArtistProduct> getSmallList(){
		List<ArtistProduct> smallList = productDao.getSmallList();
		return smallList;
	}
}
