package svc;

import dao.*;
import vo.*;

public class MemberLoginSvc {
private MemberDao memberDao;
	
	public MemberLoginSvc(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	public MemberInfo loginProc(LoginInfo li) {
		MemberInfo loginInfo = memberDao.loginProc(li);
		return loginInfo;
	}
}
