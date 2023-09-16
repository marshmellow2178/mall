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
public class MypageCtrl {
	private MypageSvc mypageSvc;
	public void setMypageSvc(MypageSvc mypageSvc) {
		this.mypageSvc = mypageSvc;
	}
	@RequestMapping("chkpw")
	public String chkpw(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		return "/chkpwpage";
	}
	@PostMapping("mypage")
	public String mypage(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		System.out.println("이름 : "+loginInfo.getMi_name());
		String pw = request.getParameter("mi_pw");
		
		int result = mypageSvc.getMiList(miid,pw);
		if(result==0) {
			//비밀번호가 틀리다면
		}else {
			MemberAddr maList = mypageSvc.getMaList(miid);
			request.setAttribute("maList", maList);
		}
		return "/mypage/mypage";
	}
	//@GetMapping("mypage")
	@GetMapping("point_list")
	public String pointList (int cpage ,HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException {
		int  psize =10, bsize=10, rcnt=0, pcnt=0, spage=0;
		
		if (request.getParameter("cpage") != null) {
    		cpage = Integer.parseInt(request.getParameter("cpage"));
    	}
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
			

		String miid = loginInfo.getMi_id();
		
		rcnt =  mypageSvc.getPointListCount(miid);
		List<PointInfo> pointList = mypageSvc.getPointList(miid,cpage,psize);
		
		PointInfo pointtotal = mypageSvc.getPointSum(miid);
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize); 	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt); 	pageInfo.setPsize(psize); 		
		pageInfo.setSpage(spage);	pageInfo.setRcnt(rcnt);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("pointList", pointList);
		request.setAttribute("pointtotal", pointtotal);
		
		
		return "mypage/mypage_point";
	}
	@GetMapping("coupon_list")
	public String coupon(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		int cpage = 1, psize =10, bsize=10, rcnt=0, pcnt=0, spage=0;
		if (request.getParameter("cpage") != null) {
    		cpage = Integer.parseInt(request.getParameter("cpage"));
    	}
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize); 	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt); 	pageInfo.setPsize(psize); 		
		pageInfo.setSpage(spage);	pageInfo.setRcnt(rcnt);

		String miid = loginInfo.getMi_id();
		int pointListCount = mypageSvc.getCouponListCount(miid);
		List<Coupon> CouponList = mypageSvc.getCouponList(miid,cpage,psize);
		
		request.setAttribute("pointList", pointListCount);
		request.setAttribute("pointtotal", CouponList);
		
				
		
		return"/mypage/mypage_coupon";
	}
	
	
}
