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


public class NoticeDao {
	private JdbcTemplate jdbcTemplate;
	public NoticeDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public int getNoticeCount(String where) {
		int result = 0;
		String sql="select count(*) from t_bbs_notice "+where;
		result =  jdbcTemplate.queryForObject(sql,Integer.class);
		return result;
	}
	public List<NoticeInfo> getNoticeList(String where,int cpage,int psize){
		String sql="select a.* ,b.ai_name from t_bbs_notice a, t_admin_info b "+where+" order by bn_date desc limit " + ((cpage-1)*psize) + ", " + psize+"  ";
		List<NoticeInfo> noticeList = jdbcTemplate.query(sql,
				new RowMapper<NoticeInfo>(){
					@Override
					public NoticeInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
						NoticeInfo bn = new NoticeInfo();
						bn.setAi_idx(rs.getInt("ai_idx"));
						bn.setBn_content(rs.getString("bn_content"));
						bn.setBn_ctgr(rs.getString("bn_ctgr"));
						bn.setBn_date(rs.getString("bn_date"));
						bn.setBn_idx(rs.getInt("bn_idx"));
						bn.setBn_isview(rs.getString("bn_isview"));
						bn.setBn_read(rs.getInt("bn_read"));
						bn.setBn_title(rs.getString("bn_title"));
						bn.setAi_name(rs.getString("ai_name"));
					return bn;
				}
			});
		return noticeList;
	}
	public int updateRead(int bnidx) {
		String sql = " update t_bbs_notice set bn_read =bn_read+1  where bn_idx = "+bnidx;
		int result =jdbcTemplate.update(sql);
		
		return result;
	}
	public NoticeInfo getNoticeView(int bnidx) {
		String sql ="select a.* ,b.ai_name from t_bbs_notice a, t_admin_info b where bn_idx = " + bnidx;
		NoticeInfo noticeView = jdbcTemplate.queryForObject(sql , new RowMapper<NoticeInfo>(){ //RowMapper 인터페이스의 inner 클래스 (익명 inner 클래스)
			@Override
			public NoticeInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
				NoticeInfo bn = new NoticeInfo();
					bn.setAi_idx(rs.getInt("ai_idx"));
					bn.setBn_content(rs.getString("bn_content"));
					bn.setBn_ctgr(rs.getString("bn_ctgr"));
					bn.setBn_date(rs.getString("bn_date"));
					bn.setBn_idx(rs.getInt("bn_idx"));
					bn.setBn_isview(rs.getString("bn_isview"));
					bn.setBn_read(rs.getInt("bn_read"));
					bn.setBn_title(rs.getString("bn_title"));
					bn.setAi_name(rs.getString("ai_name"));
				return bn;
			}
		});
		return noticeView;
	}
	public List<FaqInfo>getfaqList(String kind){
		String sql = "select a.*, b.ai_name  from t_bbs_faq a, t_admin_info b  where a.ai_idx = b.ai_idx and a.bf_idx='y' "
				+ "and bf_ctgr = "+kind;
		List<FaqInfo> faqList = jdbcTemplate.query(sql,
				new RowMapper<FaqInfo>(){
			@Override
			public FaqInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
				FaqInfo fa = new FaqInfo();
					fa.setAi_name(rs.getString("ai_name"));
					fa.setBf_idx(rs.getInt("bf_idx"));
					fa.setBf_ctgr(rs.getString("bf_ctgr"));
					fa.setBf_title(rs.getString("bf_title"));
					fa.setBf_content(rs.getString("bf_content"));
			return fa;
			}
		});
		return faqList;
	}	
	public int mantomanInsert(String kind,String title,String cont,String miid) {
		String sql = "insert into t_bbs_mantoman(mi_id,bm_ctgr,bm_title,bm_content,bm_img1,bm_img2,bm_ip)"
				+ "values('"+miid+"','"+kind+"','"+title+"','"+cont+"','','','')"; 
		int result = jdbcTemplate.update(sql);
		return result;
	}
	
}
