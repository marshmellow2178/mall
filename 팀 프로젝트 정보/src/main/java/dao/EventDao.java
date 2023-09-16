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


public class EventDao {
	private JdbcTemplate jdbcTemplate;
	public EventDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public int getEventListCount() {
		int result = 0;
		String sql = "select count(*) from t_bbs_event ";
		result = jdbcTemplate.queryForObject(sql, Integer.class);
		return result ;
	} 
	public List<EventInfo> getEventList(String orderby){
		String sql = "select * from t_bbs_event " + orderby;

		List<EventInfo> eventList = jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			EventInfo el = new EventInfo();
			el.setBe_title(rs.getString("be_title"));
			el.setBe_img1(rs.getString("be_img1"));
			el.setBe_img2(rs.getString("be_img2"));
			el.setBe_sdate(rs.getString("be_sdate"));
			el.setBe_edate(rs.getString("be_edate"));
			el.setBe_status(rs.getString("be_status"));
			el.setBe_idx(rs.getInt("be_idx"));
			
		return el;
		});
		
		
		return eventList;
		
	}
	public EventInfo getEventView(int beidx) {
		String sql = "select * from t_bbs_event where be_idx = "+beidx;

		EventInfo eventView = jdbcTemplate.queryForObject(sql, 
				new RowMapper<EventInfo>() {
				@Override
				public EventInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
					EventInfo ev = new EventInfo();
					ev.setBe_idx(beidx);				
					ev.setBe_title(rs.getString("be_title"));
					ev.setBe_img2(rs.getString("be_img2"));
					ev.setBe_sdate(rs.getString("be_sdate"));
					ev.setBe_edate(rs.getString("be_edate"));
					ev.setBe_status(rs.getString("be_status"));
					return ev;
				}
			});
		return eventView;
	}
}
