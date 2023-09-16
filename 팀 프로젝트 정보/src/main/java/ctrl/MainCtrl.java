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
public class MainCtrl {
	private MainSvc mainSvc;
	public void setMainSvc(MainSvc mainSvc) {
		this.mainSvc = mainSvc;
	}
	@GetMapping("main")
	public String main(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		
		List<ProductInfo> mdpr = mainSvc.getMDProduct();
		List<ArtistCode> weekList = mainSvc.getWeekBest();
		List<ArtistCode> AlList = mainSvc.getAlBest();
		List<ArtistCode> productList = mainSvc.getProductBest();
		
		request.setAttribute("mdpr", mdpr);
		request.setAttribute("weekList", weekList);
		request.setAttribute("AlList", AlList);
		request.setAttribute("productList", productList);
		return "/main";
	}
}
