package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class MemberLogoutCtrl {
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate(); //로그아웃 세션 날려버리기
		return "redirect:/main";
		// redirect: sendRedirect 방식으로 파일을 이동하는 방법
	}
}
