package ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;
@Controller
public class NoticeCtrl {
	private NoticeSvc noticeSvc;
	public void setNoticeSvc(NoticeSvc noticeSvc) {
		this.noticeSvc = noticeSvc;
	}
	@GetMapping("notice")
	public String noticeList( HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		request.setCharacterEncoding("utf-8");
		int cpage=1, psize=10, bsize=10, rcnt=0, pcnt=0, spage=0;
		if(request.getParameter("cpage")!=null) cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where  = " where bn_isview ='y' "; 
		if(schtype == null || keyword == null) {
			schtype = "";
			keyword = "";
		}else if(!schtype.equals("") && !keyword.equals("") ){// ���ڿ��� ������ �ʱ⿡ else if �����Ͽ� ������ �ٽðǴ�	
		// �˻����ǰ� �˻�� ��� ���� ���
			URLEncoder.encode(keyword, "UTF-8");
			
			if(schtype.equals("tc")) {//확인후 손볼것
				where += " and (bn_"+schtype+ " like '%"+keyword+"%' or bn_content like '%"+keyword+"%') ";
			}else { 			
				where += " and bn_"+schtype+ " like '%"+keyword+"%' ";
			}
		}
		rcnt = noticeSvc.getNoticeCount(where);
		where  = " where a.ai_idx = b.ai_idx and bn_isview ='y' "; 
		List<NoticeInfo> noticeList = noticeSvc.getNoticeList(where,cpage,psize);

		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize); 	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt); 	pageInfo.setPsize(psize); 		
		pageInfo.setSpage(spage);	pageInfo.setRcnt(rcnt);
		pageInfo.setSchtype(schtype); pageInfo.setKeyword(keyword);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("noticeList", noticeList);
		
		return "bbs/notice_list";
	}
	@GetMapping("notice_view")
	public String noticeView( HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		int bnidx = Integer.parseInt(request.getParameter("bnidx"));
		int noticeRead = noticeSvc.updateRead(bnidx);
		NoticeInfo noticeView = noticeSvc.getNoticeView(bnidx);
		PageInfo pageInfo = new PageInfo();
	 	pageInfo.setCpage(cpage);	pageInfo.setSchtype(schtype); 
	 	pageInfo.setKeyword(keyword);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("noticeView", noticeView);
		
		return "bbs/notice_view";
	}
	
	@GetMapping("faq")
	public String faqList(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		String kind ="";
		
		List<FaqInfo> faqList = noticeSvc.getfaqList(kind);
		request.setAttribute("faqList", faqList);
		return "bbs/faq_view";
	}
	
	@PostMapping("mantoman_proc_in")
	public String mantomaninsert(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		request.setCharacterEncoding("utf-8");
		
		String kind= request.getParameter("kind");
		String title = request.getParameter("title");
		String cont	= request.getParameter("cont");
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String miname= loginInfo.getMi_name();
		int manInfo = noticeSvc.mantomanInsert(kind,title,cont,miid);
		//이미지 받아오기 만들것
		return "redirect:bbs/mantoman_view";
	}
	
	@GetMapping("mantoman_list")
	public String mantomanList(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		
		return "bbs/mantoman_list";
	}
	
	@GetMapping("mantoman_view")
	public String mantomanView(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		
		return "bbs/mantoman_view";
	}
	@GetMapping("mantoman_q")
	public String mantomanQ(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException  {
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(loginInfo == null) { 
			response.setContentType("text html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다')");
			out.println("location.replace('/make/main');");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		
		
		
		return "bbs/mantoman_q";
	}
}
