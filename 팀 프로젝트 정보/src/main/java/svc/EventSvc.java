package svc;

import java.awt.Event;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.*;
import vo.*;


public class EventSvc {
	private EventDao eventDao;
	public EventSvc(EventDao eventDao) {
		this.eventDao = eventDao;
	}
	public int getEventListCount() {
		int result = 0;
		result = eventDao.getEventListCount();
		return result ;
	} 
	public List<EventInfo> getEventList(String orderby){
		
		List<EventInfo> eventList = eventDao.getEventList(orderby);
		
		return eventList;
		
	}
	public EventInfo getEventView(int beidx) {
		EventInfo eventView = eventDao.getEventView(beidx);
		return eventView;
		
	}
}
