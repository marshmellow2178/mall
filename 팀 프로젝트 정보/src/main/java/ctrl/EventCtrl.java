package ctrl;

import java.awt.Event;
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
public class EventCtrl {
	private EventSvc eventSvc;
	public void setEventSvc(EventSvc eventSvc) {
		this.eventSvc = eventSvc;
	}
	@GetMapping("event_list")
	public String eventList(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException{
		
    	String orderby = ""; //��������	a : �����  , b: ������ , c: �����ӹ� , d :����
		String o = request.getParameter("orderby"); 
		
		if(o==null||o.equals("")) { o = "a"; }
 		if(o!=null && !o.equals("")) 
 		{
 			switch(o) 
 			{
			case "a": 
				orderby += "order by be_status "; break;
			case "b": 
				orderby += " order by be_status desc "; break;
			}
		}
		
		List<EventInfo> eventList = eventSvc.getEventList(orderby);
		int rcnt = eventSvc.getEventListCount();
		request.setAttribute("rcnt", rcnt);
		request.setAttribute("eventList", eventList);
		return "event/event_list";
		
	}
	@GetMapping("event_view")
	public String eventView(int beidx, HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		EventInfo eventview = eventSvc.getEventView(beidx);
		request.setAttribute("eventview", eventview);
		
		return "event/event_view";
	} 
}
