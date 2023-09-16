package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.dao.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.core.support.*;
import vo.*;

public class ProductDao {
	private static ProductDao productDao;
	public ProductDao() {}
	public static ProductDao getInstance() {
		if(productDao==null) { productDao = new ProductDao(); }
		return productDao;
	}
	private JdbcTemplate jdbcTemplate;

	public ProductDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public int getProductListCount(String where) {
		String sql = "select count(*) from t_product_info as pi join t_artist_code as ac "+
				" on pi.ac_id = ac.ac_id join t_artist_product as ap on pi.ap_id = ap.ap_id "+where;
		System.out.println(sql);
		int rcnt = jdbcTemplate.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	public List<ProductInfo> getProductList(int cpage, int psize, String where,String orderby){
		String sql = "select pi.pi_id, pi.pi_name, pi.pi_img1,pi.pi_img2,pi.pi_img3, pi.pi_dc, "+
				" pi.pi_special, pi.pi_price, pi_isview, ac.ac_id, ac.ac_name_k, "+
				" ap.ap_id, ap.ap_name from t_product_info as pi join t_artist_code as ac join "+
				"t_artist_product as ap on pi.ac_id = ac.ac_id and pi.ap_id = ap.ap_id "+
				where + orderby+" limit "+((cpage-1)*psize)+","+psize;
		System.out.println(sql);	
				List<ProductInfo> productList = jdbcTemplate.query(sql, 
					(ResultSet rs, int rowNum) -> {
						ProductInfo pi = new ProductInfo(
						rs.getString("pi_id"),rs.getString("pi_name"),rs.getString("ac_id"),
						rs.getString("pi_img1"),rs.getString("pi_img2"),rs.getString("pi_img3"),rs.getString("pi_special")
						,rs.getInt("pi_dc"),rs.getInt("pi_price"),
						rs.getString("ac_name_k"),rs.getString("ap_id"),rs.getString("ap_name"),
						rs.getString("pi_isview")
					);
					return pi;
					
			});

		return productList;
	}
	public ProductInfo getProductView(String piid) {
		String sql ="select pi.pi_id, pi.pi_name, ac.ac_id, pi.pi_img1, pi.pi_img2, pi.pi_img3, pi.pi_dc, "+
			" pi.pi_special, pi.pi_price, pi.pi_desc,pi_isview, ap.ap_id, ap.ap_name, ac.ac_name_k " + 
			" from t_product_info as pi join t_artist_product as ap join t_artist_code as ac on "+ 
			" pi.ap_id = ap.ap_id and pi.ac_id = ac.ac_id where pi.pi_id = '" + piid + "' ";
		
		ProductInfo productView= null;
		try {
			productView = jdbcTemplate.queryForObject(sql, 
				new RowMapper<ProductInfo>() {
				@Override
				public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
					ProductInfo pi = new ProductInfo(
						rs.getString("pi_id"), rs.getString("pi_name"), rs.getString("ac_id"), rs.getString("pi_img1"), 
						rs.getString("pi_img2"), rs.getString("pi_img3"), rs.getString("pi_special"), rs.getInt("pi_dc"), 
						rs.getInt("pi_price"), rs.getString("ac_name_k"), rs.getString("ap_id"), rs.getString("ap_name"), rs.getString("pi_isview")
					);
					pi.setPi_desc(rs.getString("pi.pi_desc"));
					return pi;
				}
			});
		} catch(EmptyResultDataAccessException e) {
			System.out.println("ProductDao의 getProductView 메소드 오류");
		}
		return productView;
	}
	public int readUpdate(String piid) {
		int result=0;
		String sql =  "update t_product_info set pi_read = pi_read+1 where pi_id = '"+piid+"'";
		result = jdbcTemplate.update(sql);
		return result;
	}
	public ArrayList<ProductStock> getProductStock(String piid, JdbcTemplate jdbcTemplate2){
		ArrayList<ProductStock> psList = new ArrayList<ProductStock>();
		if (jdbcTemplate2==null) {
			
		}else {
			jdbcTemplate =jdbcTemplate2;
		} 
		String sql = "select * from t_product_stock where ps_isview='y' and pi_id = '"+piid+"'";
		

		psList = (ArrayList<ProductStock>)jdbcTemplate.query(sql, (ResultSet rs, int rowNum) -> {
			ProductStock ps = new ProductStock(
				rs.getString("pi_id"),rs.getInt("ps_idx"),rs.getInt("ps_stock"),
				rs.getInt("ps_sale"),rs.getString("ps_isview"),rs.getString("ps_am_name"),"");
			return ps;
		});

		
		return psList;
	}
	public List<ProductInfo>getCommingList(int cpage){
		String sql = "select pi.pi_id, pi.pi_name, pi.pi_img1,pi.pi_img2,pi.pi_img3, pi.pi_dc, "+
				" pi.pi_special, pi.pi_price, pi_isview, ac.ac_id, ac.ac_name_k, "+
				" ap.ap_id, ap.ap_name from t_product_info as pi join t_artist_code as ac join "+
				"t_artist_product as ap on pi.ac_id = ac.ac_id and pi.ap_id = ap.ap_id "+
				"where pi.pi_isview = 'n' and pi_date > date(now()) "+
				" limit " + ((cpage - 1) * 10) + ", 10";
		
		List<ProductInfo> commingtList = jdbcTemplate.query(sql, 
			(ResultSet rs, int rowNum) -> {
				ProductInfo pi = new ProductInfo(
				rs.getString("pi_id"),rs.getString("pi_name"),rs.getString("ac_id"),
				rs.getString("pi_img1"),rs.getString("pi_img2"),rs.getString("pi_img3"),rs.getString("pi_special")
				,rs.getInt("pi_dc"),rs.getInt("pi_price"),
				rs.getString("ac_name_k"),rs.getString("ap_id"),rs.getString("ap_name"),
				rs.getString("pi_isview")
			);
			return pi;
			
		});
		return commingtList;
	}
	public int getCommingCount() {
		String sql = "select count(*) from t_product_info where pi_isview='n'";
		int rcnt = jdbcTemplate.queryForObject(sql, Integer.class);
		return rcnt;
	}
	public List<ArtistCode> getBigList(){
		String sql ="select * from t_artist_code";
		List<ArtistCode> bigList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ArtistCode ac = new ArtistCode();
					ac.setAc_id(rs.getString("ac_id"));
					ac.setAc_name_k(rs.getString("ac_name_k"));
				return ac;
				
			});
		return bigList;
	}
	public List<ArtistProduct> getSmallList(){
		String sql ="select * from t_artist_product ";
		List<ArtistProduct> smallList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ArtistProduct ap = new ArtistProduct();
					ap.setAp_id(rs.getString("ap_id"));
					ap.setAp_name(rs.getString("ap_name"));
				return ap;
				
			});
		return smallList;
	}
	
}
