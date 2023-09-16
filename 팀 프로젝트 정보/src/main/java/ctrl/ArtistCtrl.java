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
public class ArtistCtrl {
	private ArtistSvc artistSvc;
	public void setArtistSvc(ArtistSvc artistSvc) {
		this.artistSvc = artistSvc;
	}
	@GetMapping("artist_list")
	public String artistList(String orderby,HttpSession session, HttpServletRequest request) {
		String o = "";
		if(orderby == null|| orderby.equals("")) { orderby = "a"; }
 		if(orderby!=null && !orderby.equals("")) {
			switch(orderby) {
			case "a": 
				o += "order by ac_date desc "; break;
			case "b": 
				o += "order by ac_name_k "; break;
			}
		}
		List<ArtistCode> artistList = artistSvc.getArtistList(o);
		
		request.setAttribute("artistList", artistList);
		
		return "artist/artist_list";
		
	}
	
}
