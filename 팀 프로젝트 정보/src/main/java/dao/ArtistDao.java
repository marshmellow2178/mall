package dao;

import javax.sql.DataSource;

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
public class ArtistDao {
	private JdbcTemplate jdbcTemplate;
	public ArtistDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public List<ArtistCode> getArtistList(String o){
		String sql ="select * from t_artist_code "+o;
		List<ArtistCode> artistinfo = jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			ArtistCode ac = new ArtistCode();
				ac.setAc_id(rs.getString("ac_id"));
				ac.setAc_idx(rs.getInt("ac_idx"));
				ac.setAc_img(rs.getString("ac_img"));
				ac.setAc_date(rs.getString("ac_date"));
				ac.setAc_name_e(rs.getString("ac_name_e"));
				ac.setAc_name_k(rs.getString("ac_name_k"));
			return ac;
		});
	return artistinfo;
	}
	
}
