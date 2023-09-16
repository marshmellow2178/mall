package vo;

public class MemberInfo {
	private String mi_id,mi_pw, mi_name, mi_birth,
	mi_gender,mi_phone, mi_nickname, mi_email, mi_status;
	private int mi_point, mi_bmcount, mi_couponcount;
	private String mi_joindate, mi_lastlogin;
	
	public MemberInfo(String mi_id, String mi_pw, String mi_name, 
			String mi_gender,String mi_birth ,String mi_phone,
			String mi_nickname,String mi_email,
			 String mi_joindate, String mi_lastlogin ,
			 String mi_status, int mi_point, int mi_bmcount, int mi_couponcount) {
		super();
		this.mi_id = mi_id;
		this.mi_pw = mi_pw;
		this.mi_name = mi_name;
		this.mi_gender = mi_gender;
		this.mi_birth = mi_birth;
		this.mi_phone = mi_phone;
		this.mi_nickname = mi_nickname;
		this.mi_email = mi_email;
		this.mi_status = mi_status;
		this.mi_point = mi_point;
		this.mi_bmcount = mi_bmcount;
		this.mi_couponcount = mi_couponcount;
		this.mi_joindate = mi_joindate;
		this.mi_lastlogin = mi_lastlogin;
	}
	public String getMi_nickname() {
		return mi_nickname;
	}
	public void setMi_nickname(String mi_nickname) {
		this.mi_nickname = mi_nickname;
	}
	public int getMi_bmcount() {
		return mi_bmcount;
	}
	public void setMi_bmcount(int mi_bmcount) {
		this.mi_bmcount = mi_bmcount;
	}
	public int getMi_couponcount() {
		return mi_couponcount;
	}
	public void setMi_couponcount(int mi_couponcount) {
		this.mi_couponcount = mi_couponcount;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getMi_pw() {
		return mi_pw;
	}
	public void setMi_pw(String mi_pw) {
		this.mi_pw = mi_pw;
	}
	public String getMi_name() {
		return mi_name;
	}
	public void setMi_name(String mi_name) {
		this.mi_name = mi_name;
	}
	public String getMi_gender() {
		return mi_gender;
	}
	public void setMi_gender(String mi_gender) {
		this.mi_gender = mi_gender;
	}
	public String getMi_phone() {
		return mi_phone;
	}
	public void setMi_phone(String mi_phone) {
		this.mi_phone = mi_phone;
	}
	public String getMi_email() {
		return mi_email;
	}
	public void setMi_email(String mi_email) {
		this.mi_email = mi_email;
	}
	public String getMi_status() {
		return mi_status;
	}
	public void setMi_status(String mi_status) {
		this.mi_status = mi_status;
	}
	public int getMi_point() {
		return mi_point;
	}
	public void setMi_point(int mi_point) {
		this.mi_point = mi_point;
	}
	public String getMi_joindate() {
		return mi_joindate;
	}
	public void setMi_joindate(String mi_joindate) {
		this.mi_joindate = mi_joindate;
	}
	public String getMi_lastlogin() {
		return mi_lastlogin;
	}
	public void setMi_lastlogin(String mi_lastlogin) {
		this.mi_lastlogin = mi_lastlogin;
	}
	public String getMi_birth() {
		return mi_birth;
	}
	public void setMi_birth(String mi_birth) {
		this.mi_birth = mi_birth;
	}
}
