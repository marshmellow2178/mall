package dao;

import java.time.LocalDate;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import dao.*;
import vo.*;
import javax.sql.*;
import javax.swing.tree.*;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.*;
import vo.*;

public class MypageDao {
	private JdbcTemplate jdbcTemplate;
	public MypageDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public int getMiList(String miid,String pw){
		String sql = "select count(*) from t_member_info where mi_id = '"+miid+"' and mi_pw = '"+pw+"' ";
		int result = jdbcTemplate.queryForObject(sql, int.class);
		return result;
	}
	public MemberAddr getMaList(String miid){
		String sql = "select * from t_member_addr where mi_id=? ";
		MemberAddr maList = jdbcTemplate.queryForObject(sql , new RowMapper<MemberAddr>(){ //RowMapper 인터페이스의 inner 클래스 (익명 inner 클래스)
			@Override
			public MemberAddr mapRow(ResultSet rs, int rowNum) throws SQLException{
				MemberAddr ma = new MemberAddr();
				ma.setMa_addr1(rs.getString("ma_addr1"));
				ma.setMa_addr2(rs.getString("ma_addr2"));
				return ma;
			}
		},miid );
		return maList;
	}
	public int getPointListCount(String miid) {
		String sql = "select count(*) from t_member_point where mi_id = '"+miid+"' ";
		int result = jdbcTemplate.queryForObject(sql, Integer.class);
		return result;
	}
	public List<PointInfo> getPointList(String miid,int cpage,int psize){
		String sql="select mp_idx, mp_point, mp_su, mp_desc, mp_detail, mi_id ,"+
				"if(curdate()=date(mp_date), right(mp_date, 8), replace(mid(mp_date,3,8), '-',' .')) wdate"+
				" from t_member_point where mi_id = '"+miid +"' order by mp_idx desc  limit " + ((cpage-1)*psize) + ", " + psize;
		System.out.println(sql);
		List<PointInfo>	pointInfo = jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			PointInfo pl = new PointInfo();
				pl.setMp_idx(rs.getInt("mp_idx"));
				pl.setMp_point(rs.getInt("mp_point"));
				pl.setMp_su(rs.getString("mp_su"));
				pl.setMp_desc(rs.getString("mp_desc"));
				pl.setMp_detail(rs.getString("mp_detail"));
				pl.setMp_date(rs.getString("wdate"));
				pl.setMi_id(rs.getString("mi_id"));
			return pl;
		});
		return pointInfo;
		
	}
	public PointInfo getPointSum(String miid) {
		String sql = "select sum(mp_point) sum from t_member_point where if(mp_su='s',mp_point=mp_point, mp_point=mp_point*-1) and mi_id = '"+miid+"' ";
		
		PointInfo  pointSum = jdbcTemplate.queryForObject(sql , new RowMapper<PointInfo>(){ //RowMapper 인터페이스의 inner 클래스 (익명 inner 클래스)
					@Override
					public PointInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
						PointInfo mp = new PointInfo();
						mp.setPtotal(rs.getInt("sum"));
						return mp;
					}
				} );
		
		return pointSum ;
	}
	public int getCouponListCount(String miid) {
		int result = 0;
		String sql = "select count(*) from t_member_coupon where mi_id='"+miid+"'";	
		result = jdbcTemplate.queryForObject(sql, Integer.class);
		return result;
	} 
	public List<Coupon> getCouponList(String miid, int cpage, int psize){
		 List<Coupon> couponList =null;
		 String sql="select mc_idx, mc_name, mc_kind, mc_status, if(curdate()=date(mc_sdate), right(mc_sdate, 8), replace(mid(mc_sdate,3,8), '-',' .')) sdate, "+
					"if(curdate()=date(mc_edate), right(mc_edate, 8), replace(mid(mc_edate,3,8), '-',' .')) edate"+
					" from t_member_coupon where mi_id = '"+miid +"' order by mc_idx desc  limit " + ((cpage-1)*psize) + ", " + psize;
		 couponList = jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			Coupon mc = new Coupon();
				mc.setMc_idx(rs.getInt("mc_idx"));
				mc.setMc_name(rs.getString("mc_name"));
				mc.setMc_kind(rs.getString("mc_kind"));
				mc.setMc_status(rs.getString("mc_status"));
				mc.setMc_sdate(rs.getString("sdate"));
				mc.setMc_edate(rs.getString("edate"));
			return mc;
			});
		 
		 return couponList;
	}
}
