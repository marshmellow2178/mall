package ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller

public class CartCtrl {
	private CartSvc cartSvc;
	public void setCartSvc(CartSvc cartSvc) {
		this.cartSvc = cartSvc;
	}
	@GetMapping("cart_view")
	public String cartview(HttpSession session, HttpServletRequest request) {
		
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		List<OrderCart> cartList = cartSvc.getcartList(miid);
	
		request.setAttribute("cartList", cartList);
		return "order/cart_view";
	}
	@PostMapping("cart_proc_in")
	public void cartprocin(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		int psidx = Integer.parseInt(request.getParameter("psidx"));
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		OrderCart oc = new OrderCart();
		oc.setMi_id(miid); 		oc.setPi_id(piid);
		oc.setPs_idx(psidx); 	oc.setOc_cnt(cnt);
		
		
		int result = cartSvc.cartInsert(oc);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}		
	@PostMapping("cart_proc_up")
	public void cartprocup(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		
		int result=0;
		int ocidx = Integer.parseInt(request.getParameter("ocidx"));
		// ����� where������ �������� ���� �ڹٱ��� ���̺��� pk
		int opt = Integer.parseInt(request.getParameter("opt"));
		// opt : ������ �ɼ� �ε���
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		OrderCart oc = new OrderCart();
		oc.setMi_id(miid);
		oc.setOc_idx(ocidx);
		oc.setPs_idx(opt);
		oc.setOc_cnt(cnt);
		
		result = cartSvc.cartUpdate(oc);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println(result);
	}
	@PostMapping("cart_proc_del")
	public void cartprocdel(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		int result=0;
		String ocidx = request.getParameter("ocidx");
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String where = "where mi_id = '"+miid+"' ";
		
		if(ocidx.indexOf(',')>0) {
			String[] arr = ocidx.split(",");
			for(int i=0;i<arr.length;i++) {
				if(i==0) 	where +=" and(oc_idx = " + arr[i];
				else  		where += " or oc_idx = " + arr[i];
			}
			where += ")";
		}else {
			where +=" and oc_idx="+ocidx;
		}
		result = cartSvc.cartDelete(where);
		
		PrintWriter out = response.getWriter();
		out.println(result);
		
	}
		
}
