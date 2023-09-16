package vo;

public class ArtistMember {
   private int am_idx;
   private String am_name_k, am_name_e, ac_id, ac_name;
   
   public String getAm_name_e() {
      return am_name_e;
   }
   public void setAm_name_e(String am_name_e) {
      this.am_name_e = am_name_e;
   }
   public int getAm_idx() {
      return am_idx;
   }
   public void setAm_idx(int am_idx) {
      this.am_idx = am_idx;
   }
   public String getAm_name_k() {
      return am_name_k;
   }
   public void setAm_name_k(String am_name_k) {
      this.am_name_k = am_name_k;
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
   
}