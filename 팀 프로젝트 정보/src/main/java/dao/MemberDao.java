package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.swing.tree.*;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.*;
import vo.*;


public class MemberDao {
	private JdbcTemplate jdbcTemplate;
	
	public MemberDao(DataSource dateSource) {
		this.jdbcTemplate = new JdbcTemplate(dateSource);
	}

	public  MemberInfo loginProc(LoginInfo li) {
	// 로그인 처리 후 회원정보를 MemberInfo 형 인스턴스로 리턴하는 메소드	
		String sql="select *from t_member_info where mi_id = ? and mi_pw =? ";
		MemberInfo loginInfo = null;
				try{
					loginInfo = jdbcTemplate.queryForObject(sql,
					new RowMapper<MemberInfo>() {
						@Override
						public MemberInfo mapRow(ResultSet rs,int rowNum) 
							throws SQLException{
							MemberInfo mem = new MemberInfo(
								rs.getString("mi_id"),
								rs.getString("mi_pw"),
								rs.getString("mi_name"),
								rs.getString("mi_gender"),
								rs.getString("mi_birth"),
								rs.getString("mi_phone"),
								rs.getString("mi_nickname"),
								rs.getString("mi_email"),
								rs.getString("mi_joindate"),
								rs.getString("mi_lastlogin"),
								rs.getString("mi_status"),
								rs.getInt("mi_point"),
								rs.getInt("mi_bmcount"),
								rs.getInt("mi_couponcount"));
							
							// 쿼리 실행결과로 MemberInfo형 인스턴스 생성
							return mem;
					}
					}, li.getMi_id(),li.getMi_pw());
					// queryForObject()는 반드시 하나의 결과 레코드가 있어야 하며,
					// 만약 업꺼나 ,2개 이상이면 각각
					//EmptyResultDataAccessException와 IncorresctTesultSizeDataAccessException을 발생시키므로
					// 사용시 예외처리(try~catch)를 해야함
	
				}catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
				}
		return loginInfo;
	}
}
