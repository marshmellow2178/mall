package ctrl;

import java.util.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ProductCtrl {
	private ProductSvc productSvc;

	public void setProductSvc(ProductSvc productSvc) {
		this.productSvc = productSvc;
	}
	
	@GetMapping("productlist")
	public String productlist( HttpServletRequest request) {
		int cpage=1, psize = 8, bsize = 10, rcnt = 0, pcnt = 0, spage = 1;
		//현재페이지 페이지크기 블록크기 레코드(상품)개수 전체페이지수 시작페이지번호
		
		
	
		if(request.getParameter("cpage")!=null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		String where = "";
		String ac = request.getParameter("ac"); //대분류
		String ap = request.getParameter("ap"); //소분류
		String key = request.getParameter("key"); //검색어
		String schtype = request.getParameter("schtype"); //검색조건
		if(ac != null && !ac.equals("")) {
 			where += " and ac.ac_id = '"+ac+"' ";
 		}
 		
 		if(ap != null && !ap.equals("")) {
 			where += " and ap.ap_id = '"+ap+"' ";
 		}
 		if(key != null && !key.equals("")) {
 			key = key.trim();
 			if(schtype!=null && schtype.equals("a")) {
 				where += " and ac.ac_name_k like '%"+key+"%' ";
 			}else if(schtype!=null && schtype.equals("p")) {
 				where += " and pi.pi_name like '%"+key+"%' ";	
 			}else {
 				where += " and ac.ac_name_k like '%"+key+"%' or pi.pi_name like '%"+key+"%' ";
 			}
 		}
 		if(!where.equals("")) {// and를 substring으로 잘라냄
 			where = where.substring(5, where.length());
 			where = " where "+where;
 		}
 		String orderby = ""; //정렬조건
 		String o = request.getParameter("orderby"); 
 		
 		//a: 기본값(등록역순) b: 판매량 c: 낮은가격순 d: 높은가격 
 		if(o==null||o.equals("")) { o = "a"; }
 		if(o!=null && !o.equals("")) {
 			
			switch(o) {
			case "a": 
				orderby += "order by pi.pi_date desc "; break;
			case "b": 
				orderby += "order by pi.pi_sale desc "; break;
			case "c": 
				orderby += "order by pi.pi_price "; break;
			case "d": 
				orderby += "order by pi.pi_price desc "; break;
			}
 		}
		List<ProductInfo> productList = productSvc.getProductList(cpage, psize, where, orderby);
		List<ArtistCode> bigList = productSvc.getBigList();
		List<ArtistProduct> smallList = productSvc.getSmallList();
		System.out.println(where);
		rcnt = productSvc.getProductCount(where);
		pcnt = rcnt/psize;
		if(rcnt%psize > 0) { pcnt++; } //전체 페이지수
		spage = (cpage -1)/psize * psize+1; //블록시작 번호
		
		PageInfo pageInfo = new PageInfo(); //페이지 정보 저장
		pageInfo.setBsize(bsize);
		pageInfo.setCpage(cpage);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setPsize(psize);
		pageInfo.setSpage(spage);
		
		request.setAttribute("rcnt", rcnt);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList); 
		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
	
		return "product/productlist";
	}
	@GetMapping("productview")
	public String productview(String piid, HttpServletRequest request) {
		
		ProductInfo pi = productSvc.getProductView(piid) ;
		productSvc.readUpdate(piid);
		pi.setStockList(productSvc.getProductStock(piid));
		request.setAttribute("pi", pi);
		
		return "product/productview";
	}
	@GetMapping("comming")
	public String comming(int cpage, HttpServletRequest request) {
		
		int rcnt = productSvc.getCommingCount();
		request.setAttribute("rcnt", rcnt);
		
		List<ProductInfo> commingList = productSvc.getCommingList(cpage);
		request.setAttribute("commingList", commingList);
		
		return "product/commingpro";
	}
	
}
