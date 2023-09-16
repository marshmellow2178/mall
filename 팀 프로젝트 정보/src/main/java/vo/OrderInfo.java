package vo;

import java.util.ArrayList;

public class OrderInfo { // 주문내역
	private String oi_id, mi_id, oi_name, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_memo_in
	,oi_payment;
	private int oi_pay, oi_upoint, oi_spoint, mc_idx,od_cnt, od_price,od_idx;
	public OrderInfo() {}
	public OrderInfo(String oi_name,String oi_phone,String oi_zip,String oi_addr1,String oi_addr2,String oi_payment,int oi_pay) {
		this.oi_name = oi_name;				this.oi_phone = oi_phone;
		this.oi_zip = oi_zip;				this.oi_addr1 = oi_addr1;
		this.oi_addr2 = oi_addr2;			this.oi_payment = oi_payment;
		this.oi_pay = oi_pay;	
	}
	
	
	public int getOd_idx() {
		return od_idx;
	}
	public void setOd_idx(int od_idx) {
		this.od_idx = od_idx;
	}
	private String oi_invoice, oi_status, oi_date, oi_coupon, oi_coupon_per, pi_name, od_am_name,
	od_img;
	private ArrayList<OrderDetail> detailList;
	public ArrayList<OrderDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(ArrayList<OrderDetail> detailList) {
		this.detailList = detailList;
	}
	
	public int getOd_price() {
		return od_price;
	}
	public void setOd_price(int od_price) {
		this.od_price = od_price;
	}
	public int getOd_cnt() {
		return od_cnt;
	}
	public void setOd_cnt(int od_cnt) {
		this.od_cnt = od_cnt;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getOd_am_name() {
		return od_am_name;
	}
	public void setOd_am_name(String od_am_name) {
		this.od_am_name = od_am_name;
	}
	public String getOd_img() {
		return od_img;
	}
	public void setOd_img(String od_img) {
		this.od_img = od_img;
	}
	public String getOi_id() {
		return oi_id;
	}
	public void setOi_id(String oi_id) {
		this.oi_id = oi_id;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getOi_name() {
		return oi_name;
	}
	public void setOi_name(String oi_name) {
		this.oi_name = oi_name;
	}
	public String getOi_phone() {
		return oi_phone;
	}
	public void setOi_phone(String oi_phone) {
		this.oi_phone = oi_phone;
	}
	public String getOi_zip() {
		return oi_zip;
	}
	public void setOi_zip(String oi_zip) {
		this.oi_zip = oi_zip;
	}
	public String getOi_addr1() {
		return oi_addr1;
	}
	public void setOi_addr1(String oi_addr1) {
		this.oi_addr1 = oi_addr1;
	}
	public String getOi_addr2() {
		return oi_addr2;
	}
	public void setOi_addr2(String oi_addr2) {
		this.oi_addr2 = oi_addr2;
	}
	public String getOi_memo() {
		return oi_memo;
	}
	public void setOi_memo(String oi_memo) {
		this.oi_memo = oi_memo;
	}
	public String getOi_memo_in() {
		return oi_memo_in;
	}
	public void setOi_memo_in(String oi_memo_in) {
		this.oi_memo_in = oi_memo_in;
	}
	public String getOi_payment() {
		return oi_payment;
	}
	public void setOi_payment(String oi_payment) {
		this.oi_payment = oi_payment;
	}
	public int getOi_pay() {
		return oi_pay;
	}
	public void setOi_pay(int oi_pay) {
		this.oi_pay = oi_pay;
	}
	public int getOi_upoint() {
		return oi_upoint;
	}
	public void setOi_upoint(int oi_upoint) {
		this.oi_upoint = oi_upoint;
	}
	public int getOi_spoint() {
		return oi_spoint;
	}
	public void setOi_spoint(int oi_spoint) {
		this.oi_spoint = oi_spoint;
	}
	public int getMc_idx() {
		return mc_idx;
	}
	public void setMc_idx(int mc_idx) {
		this.mc_idx = mc_idx;
	}
	public String getOi_invoice() {
		return oi_invoice;
	}
	public void setOi_invoice(String oi_invoice) {
		this.oi_invoice = oi_invoice;
	}
	public String getOi_status() {
		return oi_status;
	}
	public void setOi_status(String oi_status) {
		this.oi_status = oi_status;
	}
	public String getOi_date() {
		return oi_date;
	}
	public void setOi_date(String oi_date) {
		this.oi_date = oi_date;
	}
	public String getOi_coupon() {
		return oi_coupon;
	}
	public void setOi_coupon(String oi_coupon) {
		this.oi_coupon = oi_coupon;
	}
	public String getOi_coupon_per() {
		return oi_coupon_per;
	}
	public void setOi_coupon_per(String oi_coupon_per) {
		this.oi_coupon_per = oi_coupon_per;
	}
}
