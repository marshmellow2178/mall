package vo;

import java.util.*;


public class ProductInfo {
	
	
	//사용자뷰에서 처리할 정보만
	private Integer pi_price, pi_dc, pi_read; //가격, 할인율, 조회수
	private Integer pi_sale, stock; //판매량, 재고량
	private String pi_id, pi_name, ac_id, ac_name, ap_id, ap_name; 
	//상품코드, 상품이름, 대분류코드, 대분류이름, 소분류코드, 소분류이름
	private String pi_img1, pi_img2, pi_img3, pi_desc, pi_text, pi_special; 
	//이미지주소, 설명이미지, 설명글, 특별상품여부
	private String pi_sdate, pi_isview; 
	//판매개시일자, 게시여부
	private ArrayList<ProductStock> stockList = new ArrayList<ProductStock>();
	//옵션정보 목록 Integer
	public ProductInfo(String pi_id, String pi_name, String ac_id, String pi_img1, String pi_img2, String pi_img3, 
		String pi_special, Integer pi_dc,Integer pi_price, String ac_name, String ap_id, String ap_name, String pi_isview) {
		super();
		this.pi_id = pi_id;				this.pi_name = pi_name;
		this.ac_id = ac_id;				this.pi_img1 = pi_img1;
		this.pi_img3 = pi_img2;			this.pi_img3 = pi_img3;
		this.pi_special = pi_special;	this.pi_dc = pi_dc;
		this.pi_price = pi_price;		this.ac_name = ac_name;
		this.ap_id = ap_id;				this.ap_name = ap_name;
		this.pi_isview = pi_isview;		
	}
	
	public ProductInfo() {
		// TODO Auto-generated constructor stub
	}

	public int getPi_price() {
		return pi_price;
	}

	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}

	public int getPi_dc() {
		return pi_dc;
	}

	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}

	public int getPi_read() {
		return pi_read;
	}

	public void setPi_read(int pi_read) {
		this.pi_read = pi_read;
	}

	public int getPi_sale() {
		return pi_sale;
	}

	public void setPi_sale(int pi_sale) {
		this.pi_sale = pi_sale;
	}

	public String getPi_id() {
		return pi_id;
	}

	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}

	public String getPi_img1() {
		return pi_img1;
	}

	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}

	public String getPi_img2() {
		return pi_img2;
	}

	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}

	public String getPi_img3() {
		return pi_img3;
	}

	public void setPi_img3(String pi_img3) {
		this.pi_img3 = pi_img3;
	}

	public String getPi_desc() {
		return pi_desc;
	}

	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}

	public String getPi_special() {
		return pi_special;
	}

	public void setPi_special(String pi_special) {
		this.pi_special = pi_special;
	}

	public String getPi_isview() {
		return pi_isview;
	}

	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}

	public ArrayList<ProductStock> getStockList() {
		return stockList;
	}

	public void setStockList(ArrayList<ProductStock> stockList) {
		this.stockList = stockList;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getAc_id() {
		return ac_id;
	}

	public void setAc_id(String ac_id) {
		this.ac_id = ac_id;
	}

	public String getAc_name() {
		return ac_name;
	}

	public void setAc_name(String ac_name) {
		this.ac_name = ac_name;
	}

	public String getAp_id() {
		return ap_id;
	}

	public void setAp_id(String ap_id) {
		this.ap_id = ap_id;
	}

	public String getAp_name() {
		return ap_name;
	}

	public void setAp_name(String ap_name) {
		this.ap_name = ap_name;
	}

	public String getPi_name() {
		return pi_name;
	}

	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}

	public String getPi_text() {
		return pi_text;
	}

	public void setPi_text(String pi_text) {
		this.pi_text = pi_text;
	}

	public String getPi_sdate() {
		return pi_sdate;
	}

	public void setPi_sdate(String pi_sdate) {
		this.pi_sdate = pi_sdate;
	}	
}
