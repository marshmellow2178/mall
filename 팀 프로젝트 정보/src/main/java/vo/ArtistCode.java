package vo;

import java.util.*;

public class ArtistCode {
	/*��ǰ ��з� ����
	t_artist_code ���̺�
	 */
	private String ac_id, ac_name_k, ac_img,ac_name_e , ac_date; //�ڵ�, �ѱ� �̸�
	private int ac_idx , ac_paysum;
	public String getAc_date() {
		return ac_date;
	}

	public int getAc_idx() {
		return ac_idx;
	}

	public void setAc_idx(int ac_idx) {
		this.ac_idx = ac_idx;
	}

	public void setAc_date(String ac_date) {
		this.ac_date = ac_date;
	}

	public String getAc_name_e() {
		return ac_name_e;
	}

	public void setAc_name_e(String ac_name_e) {
		this.ac_name_e = ac_name_e;
	}

	public String getAc_img() {
		return ac_img;
	}

	public void setAc_img(String ac_img) {
		this.ac_img = ac_img;
	}

	public String getAc_id() {
		return ac_id;
	}

	public void setAc_id(String ac_id) {
		this.ac_id = ac_id;
	}

	public String getAc_name_k() {
		return ac_name_k;
	}

	public void setAc_name_k(String ac_name_k) {
		this.ac_name_k = ac_name_k;
	}

	public int getAc_paysum() {
		return ac_paysum;
	}

	public void setAc_paysum(int ac_paysum) {
		this.ac_paysum = ac_paysum;
	}

	
}
