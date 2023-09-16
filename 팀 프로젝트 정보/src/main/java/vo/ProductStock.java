package vo;

public class ProductStock {
	//옵션별 재고량
	private int ps_idx, ps_stock, ps_sale;
	private String pi_id, ps_isview, ps_am_name, ac_id;
	
	//일련번호, 재고량, 판매량, 상품명, 게시여부, 옵션(멤버)이름
	
	public ProductStock(
		String pi_id, int ps_idx, int ps_stock,int ps_sale,
		String ps_isview,String ps_am_name,String ac_id ) {
		super();
		this.pi_id = pi_id; 			this.ps_idx = ps_idx;
		this.ps_stock = ps_stock;		this.ps_sale = ps_sale;
		this.ps_isview = ps_isview;		this.ps_am_name = ps_am_name;
		this.ac_id = ac_id;
		
		
	}
	public int getPs_idx() {
		return ps_idx;
	}
	public void setPs_idx(int ps_idx) {
		this.ps_idx = ps_idx;
	}
	public int getPs_stock() {
		return ps_stock;
	}
	public void setPs_stock(int ps_stock) {
		this.ps_stock = ps_stock;
	}
	public int getPs_sale() {
		return ps_sale;
	}
	public void setPs_sale(int ps_sale) {
		this.ps_sale = ps_sale;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPs_isview() {
		return ps_isview;
	}
	public void setPs_isview(String ps_isview) {
		this.ps_isview = ps_isview;
	}
	public String getPs_am_name() {
		return ps_am_name;
	}
	public void setPs_am_name(String ps_am_name) {
		this.ps_am_name = ps_am_name;
	}
	public String getAc_id() {
		return ac_id;
	}
	public void setAc_id(String ac_id) {
		this.ac_id = ac_id;
	}
}
