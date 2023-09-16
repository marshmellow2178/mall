package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;


@Controller
@RequestMapping("login") // 동일한 매핑을 사용
public class MemberLoginCtrl {
	private MemberLoginSvc memberLoginSvc;
	
	public void setMemberLoginSvc(MemberLoginSvc memberLoginSvc) {
		this.memberLoginSvc = memberLoginSvc;
	}
	
	
	@GetMapping // get 방식으로 /login을 부를 경우
	public String login() {
		return "/login";
	}
	@PostMapping // post방식으로 /login을 부를 경우(로그인 처리)
	public String loginProc(LoginInfo li,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
	// 	HttpServletRequest를 파라미터로 받아 세션 객체를 생성할 수 있음(필요한 경우에만 생성)
	// 	HttpSession을 직접 파라미터로 받아 세션 객체를 생성없이 사용할 수 있음(무조건 생성)
		MemberInfo loginInfo = memberLoginSvc.loginProc(li);
		if(loginInfo == null) { // 로그인 실패시
			response.setContentType("text/html charset=utf-8");
 			PrintWriter out = response.getWriter();
 			out.println("<script>");
 			out.println("alert('1234');");
 			out.println("history.back();");
 			out.println("</script>");
 			out.close();
			return "/login";
		}else { // 로그인 성공시
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
			return "redirect:/main";
		}
	}
}
