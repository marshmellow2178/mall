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

public class OrderDao {
	private JdbcTemplate jdbcTemplate;
	public OrderDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public List<OrderCart> getCartList(String miid){
		ProductDao ppd = ProductDao.getInstance();
		
		String sql = " select a.oc_idx, a.pi_id, a.ps_idx, a.oc_cnt, b.pi_name, b.pi_img1, b.pi_price, b.pi_dc,c.ps_stock ,c.ps_am_name "
				+" from t_order_cart a, t_product_info b,t_product_stock c "
				+" where a.pi_id = b.pi_id and a.pi_id = c.pi_id and  a.ps_idx = c.ps_idx and b.pi_isview ='y' and mi_id ='"+miid+"' ";
		
		List<OrderCart> productList = jdbcTemplate.query(sql,(ResultSet rs, int rowNum)->{
			OrderCart oc = new OrderCart(
				rs.getInt("oc_idx"),rs.getString("pi_id"),rs.getInt("ps_idx"),rs.getInt("oc_cnt"),
				rs.getString("pi_name"),rs.getString("pi_img1"),rs.getInt("pi_price"),rs.getInt("pi_dc"),
				rs.getInt("ps_stock"),rs.getString("ps_am_name"),ppd.getProductStock(rs.getString("pi_id"),jdbcTemplate));
			System.out.println(rs.getInt("pi_dc"));
			return oc;	
		
		});
		return productList;
		
	}
	public int cartUpdate(OrderCart oc) {
		int result = 0;
		String sql = " update t_order_cart set ";
		String where = " where mi_id = '"+oc.getMi_id()+"' ";
		if(oc.getOc_cnt() == 0){
			String sql2 = " select oc_idx, oc_cnt from t_order_cart " + where +
					 		" and ps_idx = " + oc.getPs_idx();
			OrderCart cart = null;
			try {
			cart = jdbcTemplate.queryForObject(sql2 , 
				new RowMapper<OrderCart>(){ 
				@Override
				public OrderCart mapRow(ResultSet rs, int rowNum) throws SQLException{
					OrderCart coc = new OrderCart();
					coc.setOc_idx(rs.getInt("oc_idx"));
					coc.setOc_cnt(rs.getInt("oc_cnt"));
					return coc;
			
				}
			});
			} catch(EmptyResultDataAccessException e) {
				System.out.println("OrderDao의 cartUpdate 메소드 오류");
			}
		
			if(cart!=null){
				
				int idx = cart.getOc_idx();
				
				sql += " ps_idx = " + oc.getPs_idx()+
						" ,oc_cnt=oc_cnt + "+cart.getOc_cnt()+
						where+" and oc_idx = " + oc.getOc_idx();
			
				result =jdbcTemplate.update(sql);//update쿼리
				
				sql = " delete from t_order_cart " + 
						where +" and oc_idx = "+ idx;
			
			}else {
			
				sql += " ps_idx = " + oc.getPs_idx()+
						where+" and oc_idx = " +oc.getOc_idx();		
			}
	
		}else { // ���� ������ ���
			sql += "oc_cnt = "+oc.getOc_cnt() + where 
					+ " and oc_idx = " + oc.getOc_idx();
		}
		result =jdbcTemplate.update(sql);
		return result;
	}
	public int cartInsert(OrderCart oc) {
		int result =0;
		try {
			String sql="update t_order_cart set oc_cnt = oc_cnt + "+oc.getOc_cnt()+" where mi_id = '"+oc.getMi_id()+"' and pi_id = '"+oc.getPi_id()+"' and ps_idx = '"+oc.getPs_idx()+"' ";
			result = jdbcTemplate.update(sql);
			if(result == 0) {
				
					sql=" insert into t_order_cart(mi_id, pi_id, ps_idx, oc_cnt) "
							+ " values( '" + oc.getMi_id() + "', '" + oc.getPi_id() + "', '" + oc.getPs_idx() + "', '" + oc.getOc_cnt() + "' )";
					
					result = jdbcTemplate.update(sql);
				}
		}catch (Exception e) {
			System.out.println("OrderDao 클래스의  cartInsert() 메소드 오류");
			e.printStackTrace();
		}
		return result;
	}
	public int cartDelete(String where) {
		int result=0;
		String sql="delete from t_order_cart "+where;
		result = jdbcTemplate.update(sql);
		
		return result;
	}
	public List<OrderCart> getBuyList(String kind,String sql){
		ProductDao ppd = ProductDao.getInstance();
		System.out.println(sql);
		List<OrderCart> buyList =null;
		if(kind.equals("c")) {
			buyList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					OrderCart oc = new OrderCart(
							rs.getInt("oc_idx"),rs.getString("pi_id"),rs.getInt("ps_idx"),rs.getInt("cnt"),
							rs.getString("pi_name"),rs.getString("pi_img1"),rs.getInt("pi_price"),rs.getInt("pi_dc"),
							rs.getInt("ps_stock"),rs.getString("ps_am_name"),ppd.getProductStock(rs.getString("pi_id"),jdbcTemplate));
					
			return oc;
			});		
		}
		return buyList;
	}
	public List<MemberAddr> getAddrList(String miid){
		String sql ="select * from t_member_addr where mi_id='"+miid+"' "; 
		List<MemberAddr> addrList = jdbcTemplate.query(sql, 
				(ResultSet rs, int rowNum) -> {
					MemberAddr ma = new MemberAddr();
					ma.setMa_idx(rs.getInt("ma_idx"));
					ma.setMi_id(rs.getString("mi_id"));
					ma.setMa_name(rs.getString("ma_name"));
					ma.setMa_phone(rs.getString("ma_phone"));
					ma.setMa_zip(rs.getString("ma_zip"));
					ma.setMa_basic(rs.getString("ma_basic"));
					ma.setMa_date(rs.getString("ma_date"));
					ma.setMa_addr1(rs.getString("ma_addr1"));
					ma.setMa_addr2(rs.getString("ma_addr2"));
					ma.setMa_rname(rs.getString("ma_rname"));
				return ma;
			});		
		return addrList;
	}
	public String getOrderId() {
		String oi_id =null;
		LocalDate today = LocalDate.now();
		String td = (today+"").substring(2).replace("-","");
		String alpha ="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		Random rnd = new Random();
		String id =null;
			String rn = alpha.charAt(rnd.nextInt(26))+"";
		rn += alpha.charAt(rnd.nextInt(26))+"";
		try {
			String sql =" select right(oi_id,4) seq "+// seq ���� ������ ������ �ַλ��
					" from t_order_info where left(oi_id,6) = '"+td+"' "+
					"order by oi_date desc limit 0,1";
			System.out.println(sql);
			id = jdbcTemplate.queryForObject(sql, String.class);
			System.out.println(id);
		}catch(EmptyResultDataAccessException e){
			oi_id = td+rn+"1001";
			return oi_id;
			
		}
		if(id!=null) {
			int num = Integer.parseInt(id)+1;
			oi_id =  td+rn+num;
		}
		return oi_id;
	}
	public String orderInsert(String kind, OrderInfo oi, String temp) {
		String result = "";
		String oi_id = getOrderId();
		result = oi_id+",";
		int rcount=0, target=0;
		int pnt = oi.getOi_pay()*2/100;
		try {
			String sql = "insert into t_order_info (" + 
					"oi_id, mi_id, oi_name, oi_phone, oi_zip, oi_addr1, " + 
					"oi_addr2, oi_payment, oi_pay, oi_status, oi_spoint, oi_upoint) values ('" + 
					oi_id			+ "', '" + oi.getMi_id()	+ "', '" + 
					oi.getOi_name()	+ "', '" + oi.getOi_phone() + "', '" + 
					oi.getOi_zip()	+ "', '" + oi.getOi_addr1()	+ "', '" + 
					oi.getOi_addr2()+ "', '" + oi.getOi_payment()+"', '" + 
					oi.getOi_pay()	+ "', '" + oi.getOi_status() + "', '" +
					pnt +"', '"+ oi.getOi_upoint() + "') ";
					
			target++; 
			rcount = jdbcTemplate.update(sql);
			System.out.println(sql);
			if(kind.equals("c")) { 
				
					sql="select  a.pi_id, a.ps_idx, a.oc_cnt , b.pi_name, b.pi_img1, c.ps_am_name,"+
						" if(b.pi_dc>0, (100-b.pi_dc)/100 * b.pi_price, b.pi_price) price, b.ac_id "
						+" from t_order_cart a, t_product_info b, t_product_stock c "
						+" where a.pi_id = b.pi_id and a.ps_idx = c.ps_idx "
						+" and a.mi_id ='"+oi.getMi_id()+"' and ( ";
						String delWhere = " where mi_id = '"+oi.getMi_id()+"' and (";
						String[] arr = temp.split(",");
						
					
						for(int i= 1; i<arr.length;i++) {
							if( i == 1 ) {
								sql +="a.oc_idx =" + arr[i];
								delWhere += " oc_idx= " + arr[i];
							}else{
								sql += " or a.oc_idx = "	+ arr[i];	
								delWhere += " or oc_idx= " + arr[i];
							}
						}
						sql +=")";
						
						delWhere +=")";
						System.out.println(sql);
						
						List<OrderDetail> orderpr = jdbcTemplate.query(sql, 
								(ResultSet rs, int rowNum) -> {
									OrderDetail od = new OrderDetail();
									od.setOi_id(oi_id);
									od.setPi_id(rs.getString("pi_id"));
									od.setPs_idx(rs.getInt("ps_idx"));
									od.setOd_cnt(rs.getInt("oc_cnt"));
									od.setOd_price(rs.getInt("price"));
									od.setOd_name(rs.getString("pi_name"));
									od.setOd_img(rs.getString("pi_img1"));
									od.setOd_am_name(rs.getString("ps_am_name"));
									od.setAc_id(rs.getString("ac_id"));
								return od;
							});	
							System.out.println(orderpr.size());
						if(orderpr.size() != 0) { 
							for(int i=0;i<orderpr.size();i++) {
								OrderDetail	od = orderpr.get(i);
								if(od !=null) {

									sql="insert into t_order_detail(oi_id, pi_id, ac_id,ps_idx, od_cnt, od_price, od_name, od_img, od_am_name)"
										+"values(?,?,?,?,?,?,?,?,?)";
									System.out.println(sql);
									target++; rcount +=jdbcTemplate.update(sql,
										od.getOi_id(),od.getPi_id(),od.getAc_id(),od.getPs_idx(),od.getOd_cnt(),od.getOd_price(),od.getOd_name(),od.getOd_img(),od.getOd_am_name());
									sql = "update t_product_info set pi_sale = pi_sale + "+od.getOd_cnt()+" where pi_id = '"+od.getPi_id()+"' ";
									target++; rcount +=jdbcTemplate.update(sql);
									sql = "update t_product_stock set ps_stock = ps_stock - "+od.getOd_cnt()+" , ps_sale = ps_sale + "
											  + od.getOd_cnt() + " where ps_idx ="+ od.getPs_idx();
										target++; rcount += jdbcTemplate.update(sql);
									sql= "update t_artist_code set ac_paysum = ac_paysum +"+od.getOd_price()+" where ac_id = '"+od.getAc_id()+"' ";
									target++; rcount += jdbcTemplate.update(sql);
								
								}
								sql = "delete from t_order_cart " + delWhere;
								jdbcTemplate.update(sql);
							}
						}else {
							return result + "1,4";
						}
				}else { //직접구매일 경우
					String[] arr = temp.split(",");
					sql="select  a.pi_id, b.ps_idx, "+arr[0]+" cnt , a.pi_name, a.pi_img1, b.ps_am_name,"+
							" if(a.pi_dc>0, (100-a.pi_dc)/100 * a.pi_price, a.pi_price) price , b.ac_id"
							+" from  t_product_info a, t_product_stock b "
							+" where a.pi_id = b.pi_id and a.pi_id='"+arr[1]+"' ";
					
				}
				if(oi.getOi_upoint()>0) { // 포인트를 사용할 경우
					sql="call sp_member_point_insert('"+oi.getMi_id()+"','u',"+oi.getOi_upoint()+",'상품구매','"+oi_id+"')";
					target++; rcount += jdbcTemplate.update(sql);
				}else { // 포인트를 적립할 경우
					pnt = oi.getOi_pay()*2/100; // ������ ����Ʈ
					sql="call sp_member_point_insert('"+oi.getMi_id()+"','s',"+pnt+",'상품구매','"+oi_id+"')";
					target++; rcount += jdbcTemplate.update(sql);
				}		
			
		}catch(Exception e) {
			System.out.println("OrderDao 클래스 orderInsert() 메소드 오류");
			e.printStackTrace();
		}
		
		return result + rcount + "," + target;
	}public OrderInfo getOrderEndInfo(String miid,String oiid){
		OrderInfo oi = null;
		String sql="select a.oi_name, a.oi_phone, a.oi_zip, a.oi_addr1, a.oi_addr2, a.oi_payment, a.oi_pay, b.od_img, b.od_name, b.od_am_name, b.od_cnt,b.od_price, b.pi_id , c.pi_isview " 
				+ " from t_order_info a, t_order_detail b, t_product_info c "
				+ " where a.oi_id = b.oi_id and b.pi_id=c.pi_id and a.mi_id = '"+miid+"' and a.oi_id = '"+oiid+"' order by c.pi_id, b.od_am_name ";
		oi = jdbcTemplate.queryForObject(sql , new RowMapper<OrderInfo>(){ //RowMapper 인터페이스의 inner 클래스 (익명 inner 클래스)
			@Override
			public OrderInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
				OrderInfo orderend = new OrderInfo(rs.getString("oi_name"),rs.getString("oi_phone"),rs.getString("oi_zip"),
						rs.getString("oi_addr1"),rs.getString("oi_addr2"),rs.getString("oi_payment"),rs.getInt("oi_pay"));
				
				return orderend;
			}
		});
		
		return oi;
	}
	public List<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		String sql="select a.oi_id, b.od_idx, a.oi_date , c.pi_name, b.od_am_name, b.od_img, b.od_cnt, b.od_price, a.oi_pay"
				   +" from t_order_info a, t_order_detail b ,t_product_info c "
				   +" where a.mi_id ='"+miid+"' and  a.oi_id = b.oi_id and b.pi_id =c.pi_id "
				   		+ " order by a.oi_date desc"+ " limit " + ((cpage-1)*psize) + ", " + psize;
		System.out.println(sql);
		List<OrderInfo>	orderList = jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			OrderInfo oi = new OrderInfo();
				oi.setOi_id(rs.getString("oi_id"));
				oi.setOd_idx(rs.getInt("od_idx"));
				oi.setOi_date(rs.getString("oi_date"));
				oi.setPi_name(rs.getString("pi_name"));
				oi.setOd_am_name(rs.getString("od_am_name"));
				oi.setOd_img(rs.getString("od_img"));
				oi.setOd_cnt(rs.getInt("od_cnt"));
				oi.setOd_price(rs.getInt("od_price"));
				oi.setOi_pay(rs.getInt("oi_pay"));
				return oi;
		});
	
		return orderList;
	}
	public int getOrderCount(String miid) {
		String sql = "select  count(*) from t_order_info where mi_id = '"+miid+"'";
		int result = jdbcTemplate.queryForObject(sql, Integer.class);
		
		System.out.println("order count = "+result);
		return result;
	}
	public ArrayList<OrderDetail> orderDetailInfo (String miid, String oiid,JdbcTemplate jdbcTemplate ){
		String sql ="select a.oi_name, a.oi_phone, a.oi_zip, a.oi_addr1, a.oi_addr2, a.oi_payment, a.oi_pay, b.od_img, b.od_name, b.od_am_name, "
			+ "b.od_cnt,b.od_price, b.pi_id , c.pi_isview, a.oi_upoint, a.oi_spoint " 
			+ " from t_order_info a, t_order_detail b, t_product_info c "
			+ " where a.oi_id = b.oi_id and b.pi_id=c.pi_id and a.mi_id = '"+miid+"' and a.oi_id = '"+oiid+"'order by c.pi_id, b.od_am_name ";
		
		ArrayList<OrderDetail> orderDetail = (ArrayList<OrderDetail>)jdbcTemplate.query(sql,(ResultSet rs, int rowNum) -> { // -> : 람다식 기호
			OrderDetail od = new OrderDetail();
				od.setOd_img(rs.getString("od_img"));
				od.setOd_name(rs.getString("od_name"));
				od.setOd_am_name(rs.getString("od_am_name"));
				od.setOd_cnt(rs.getInt("od_cnt"));
				od.setOd_price(rs.getInt("od_price"));
				od.setPi_id(rs.getString("pi_id"));
				od.setPi_isview(rs.getString("pi_isview"));
			return od;
		});
				
		return orderDetail;
	}
	
	public OrderInfo getOrderInfo (String miid,String oiid) {

		OrderInfo	orderInfo=null;
		try {
			String sql ="select a.oi_name, a.oi_phone, a.oi_zip, a.oi_addr1, a.oi_addr2, "
					+"a.oi_payment, a.oi_pay ,  a.oi_upoint, a.oi_spoint "
					+" from t_order_info a"
					+" where a.mi_id = '"+miid+"' and a.oi_id = '"+oiid+"'";
	
			orderInfo = jdbcTemplate.queryForObject(sql , new RowMapper<OrderInfo>(){ //RowMapper 인터페이스의 inner 클래스 (익명 inner 클래스)
				@Override
				public OrderInfo mapRow(ResultSet rs, int rowNum) throws SQLException{
					OrderInfo oi = new OrderInfo();
					oi.setOi_name(rs.getString("oi_name"));
					oi.setOi_phone(rs.getString("oi_phone"));
					oi.setOi_zip(rs.getString("oi_zip"));
					oi.setOi_addr1(rs.getString("oi_addr1"));
					oi.setOi_addr2(rs.getString("oi_addr2"));
					oi.setOi_payment(rs.getString("oi_payment"));
					oi.setOi_pay(rs.getInt("oi_pay"));
					oi.setOi_spoint(rs.getInt("oi_spoint"));
					oi.setOi_upoint(rs.getInt("oi_upoint"));
					oi.setDetailList(orderDetailInfo(miid,oiid,jdbcTemplate));
					System.out.println("oi : "+oi);
					return oi;
				}
			});
			System.out.println(orderInfo);
		}catch (Exception e) {
			System.out.println("OrderDao의 getOrderInfo오류 ");
		}

		return orderInfo;
	}
}
