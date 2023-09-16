package dao;


import java.time.LocalDate;
import java.awt.Event;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import dao.*;
import vo.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.*;
import javax.swing.tree.*;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.*;
import vo.*;

public class MainDao {
	private JdbcTemplate jdbcTemplate;
	public MainDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public List<ProductInfo>  getMDProduct(){
		String sql = "select * from t_product_info where pi_special='y'";
		List<ProductInfo> productList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ProductInfo pi = new ProductInfo();
				return pi;
			});		
		return productList;
	}
	public List<ArtistCode>  getWeekBest(){
		String sql = "select b.ac_id ,sum(c.od_price) sum, e.ac_img,e.ac_name_k from t_order_info a, t_product_info b, t_order_detail c,t_artist_product d, t_artist_code e "
				+ " where a.oi_id =c.oi_id and b.pi_id = c.pi_id and b.ap_id=d.ap_id and b.ac_id= e.ac_id  "
				+ " and a.oi_date between adddate(now(), interval-7 day )and now() group by ac_id"
				+" order by sum desc limit 0,4 ";
		List<ArtistCode> artistList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ArtistCode ac = new ArtistCode();
					ac.setAc_id(rs.getString("ac_id"));
					ac.setAc_img(rs.getString("ac_img"));
					ac.setAc_name_k(rs.getString("ac_name_k"));
				return ac;
			});	
		System.out.println(artistList);
		return artistList;
		
	}
	public List<ArtistCode>  getAlBest(){
		String sql = "select b.ac_id ,sum(c.od_price) sum, e.ac_img,e.ac_name_k "
				+ "from t_order_info a, t_product_info b, t_order_detail c,t_artist_product d, t_artist_code e where a.oi_id =c.oi_id "
				+ "and b.pi_id = c.pi_id and b.ap_id=d.ap_id and b.ac_id= e.ac_id and b.ap_id  in (select ap_id from t_product_info where ap_id ='1001') "
				+ "group by ac_id order by sum desc limit 0,4";
		List<ArtistCode> artistList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ArtistCode ac = new ArtistCode();
					ac.setAc_id(rs.getString("ac_id"));
					ac.setAc_img(rs.getString("ac_img"));
					ac.setAc_name_k(rs.getString("ac_name_k"));
				return ac;
			});	
		System.out.println("getAlBest : "+artistList);
		return artistList;
	}
	public List<ArtistCode>  getProductBest(){
		String sql ="select* "
				+ "from t_artist_code order by ac_paysum desc limit 0,4 ";
		List<ArtistCode> artistList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					ArtistCode ac = new ArtistCode();
					ac.setAc_name_k(rs.getString("ac_name_k"));
					ac.setAc_paysum(rs.getInt("ac_paysum"));
					ac.setAc_img(rs.getString("ac_img"));
					ac.setAc_id(rs.getString("ac_id"));
				return ac;
			});		
		return artistList;	
	}
}
