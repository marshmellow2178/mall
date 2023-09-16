package ctrl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;
@Controller
public class OrderCtrl {
	private OrderSvc orderSvc;
	public void setOrderSvc(OrderSvc orderSvc) {
		this.orderSvc = orderSvc;
	}

	@PostMapping("order_form")
	public String orderform(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String kind = request.getParameter("kind");
		String miid = loginInfo.getMi_id();
		String select = " select a.pi_id, a.pi_img1, a.pi_name,b.ps_idx,b.ps_stock, b.ps_am_name, a.pi_price, a.pi_dc,";
		String from =" from t_product_info a, t_product_stock b ";
		String where = " where a.pi_id = b.pi_id  and a.pi_isview='y' and b.ps_isview='y' ";
		if(kind.equals("c")) {// 장바구니구매
			select += "  c.oc_cnt cnt, c.oc_idx "; // c.oc_cnt�� cnt�� ����Ͽ� �������ſ� �����Ͽ� �����߻� ���� 
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.ps_idx = c.ps_idx" + 
					" and c.mi_id = '"+miid+"' and (";
			String[] arr = request.getParameterValues("chk");
			for (int i=1; i<arr.length; i++) {
				if (i == 1) where += "c.oc_idx = " + arr[i];
				else		where += " or c.oc_idx = " +arr[i];	
			}
			where +=") order by a.pi_id, c.ps_idx ";
			
		}else { // 직접구매
			String piid = request.getParameter("piid");
			String psidx = request.getParameter("psidx");
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			select +=cnt + " cnt ";
			where += " and a.pi_id = '"+piid+"' and b.ps_idx = " + psidx;
		}
		;
		List<OrderCart> pdtList = orderSvc.getBuyList(kind,select+from+where);
		
		List<MemberAddr> addrList = orderSvc.getAddrList(miid);
		
		request.setAttribute("pdtList", pdtList);
		request.setAttribute("addrList", addrList);
	
		return "order/order_form";
	}
	@PostMapping("order_proc_in")
	public String orderprocin(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		System.out.println(kind);
		int realprice = Integer.parseInt(request.getParameter("realprice"));
		String rname = request.getParameter("oi_name");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String phone = p1 + "-" + p2 + "-" + p3;
	
		String zip = request.getParameter("ma_zip");
		String addr1 = request.getParameter("ma_addr1");
		String addr2 = request.getParameter("ma_addr2");
		String oimemo = request.getParameter("oi_memo");
		String oimemoin = request.getParameter("oi_memo_in");
		String payment = request.getParameter("oi_payment");
		int oiupoint = Integer.parseInt(request.getParameter("oi_upoint"));
		System.out.println(addr1);
		if(oiupoint>0) {
			realprice = realprice-oiupoint;	
		}
	
		OrderInfo oi = new OrderInfo();
		oi.setMi_id(miid); 			oi.setOi_name(rname);//������ �̸�
		oi.setOi_phone(phone); 		oi.setOi_zip(zip);
		oi.setOi_addr1(addr1); 		oi.setOi_addr2(addr2);
		oi.setOi_payment(payment); 	oi.setOi_pay(realprice);
		oi.setOi_status((payment.equals("c")? "a" : "b"));
		oi.setOi_memo(oimemo);		oi.setOi_memo_in(oimemoin);
		oi.setOi_upoint(oiupoint);
		String result = null, temp="";
		if(kind.equals("c")) {	// ��ٱ��ϸ� ���� ������ ���
			temp = request.getParameter("ocidxs");
			// ��ٱ��Ͽ��� ������ ��ǰ���� �ε��� ��ȣ��(��ǥ�� ����)
		}else {	// �ٷα����� ���
			String cnt = request.getParameter("cnt");
			String piid = request.getParameter("piid");
			temp = cnt+","+piid;
		}
		 String id = "";
		result = orderSvc.orderInsert(kind, oi, temp);
		System.out.println(result);
		String[] arr = result.split(",");
		
		if(arr[1].equals(arr[2])) { 
			id=	arr[0];
			}else {}
		return "redirect:order_end?oiid="+id;
	}
	@GetMapping("order_end")
	public String orderend(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException  {
		String oiid = request.getParameter("oiid"); // �ֹ� ��ȣ
		request.setCharacterEncoding("utf-8");
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id(); 
		OrderInfo orderInfo = orderSvc.getOrderEndInfo(miid, oiid);
		if(orderInfo == null) { 
			response.setContentType("text html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다')");
			out.println("location.replace('/make/main');");
			out.println("</script>");
			out.close();
		}
		request.setAttribute("orderInfo", orderInfo);
		return "order/order_end";
	}
	@GetMapping("order_list")
	public String orderList(int cpage,HttpSession session, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException  {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(cpage == 0) {
			cpage=1;
		}
		int psize =10, bsize=10, rcnt=0, pcnt=0, spage=0;
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		if(loginInfo ==null) {	
			response.setContentType("text/html charset=utf-8 ");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하십시오');");
			//out.println("location.replace(login_form.jsp?url=cart_view)");
			out.println("</script>");
			out.close();
		}

		String miid = loginInfo.getMi_id(); 
		rcnt = orderSvc.getOrderCount(miid);
		PageInfo pageInfo = new PageInfo();
		
		pageInfo.setBsize(bsize); 	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt); 	pageInfo.setPsize(psize); 		
		pageInfo.setSpage(spage);	pageInfo.setRcnt(rcnt);
		
	
		List<OrderInfo> orderList = orderSvc.getOrderList(miid,cpage,psize);
		System.out.println("orderList"+orderList);
		request.setAttribute("orderList", orderList);
		request.setAttribute("pageInfo", pageInfo);
		
		return "mypage/mypage_orderlist";
		
	}
	@GetMapping("order_detail")
	public String oirderDetail(String oiid,HttpSession session, HttpServletRequest request, HttpServletResponse response)throws Exception {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(loginInfo ==null) {	
			response.setContentType("text/html charset=utf-8 ");
			PrintWriter out= response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하십시오');");
			//out.println("location.replace(login_form.jsp?url=cart_view)");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		OrderInfo orderInfo = orderSvc.getOrderInfo(miid,oiid);
		request.setAttribute("orderInfo", orderInfo);
		
		return "mypage/mypage_order_detail";
	}
	
}
