package config;


import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
	@Autowired
	private MemberLoginSvc memberLoginSvc;
	@Autowired
	private ProductSvc productSvc;
	@Autowired
	private OrderSvc orderSvc;
	@Autowired
	private CartSvc cartSvc;
	@Autowired
	private MypageSvc mypageSvc;
	@Autowired
	private EventSvc eventSvc;
	@Autowired
	private MainSvc mainSvc;
	@Autowired
	private ArtistSvc artistSvc;
	@Autowired
	private NoticeSvc noticeSvc;
	@Bean
	public MemberLoginCtrl memberLoginCtrl() {
		MemberLoginCtrl ctrl = new MemberLoginCtrl();
		ctrl.setMemberLoginSvc(memberLoginSvc);
		return ctrl;
	}
	@Bean
	public MemberLogoutCtrl  memberLogoutCtrl() {
		MemberLogoutCtrl ctrl =  new MemberLogoutCtrl();
		return ctrl;
	}
	@Bean
	public ProductCtrl  productCtrl() {
		ProductCtrl ctrl =  new ProductCtrl();
		ctrl.setProductSvc(productSvc);
		return ctrl;
	}
	@Bean
	public OrderCtrl  orderCtrl() {
		OrderCtrl ctrl =  new OrderCtrl();
		ctrl.setOrderSvc(orderSvc);
		return ctrl;
	}
	@Bean
	public CartCtrl  cartCtrl() {
		CartCtrl ctrl =  new CartCtrl();
		ctrl.setCartSvc(cartSvc);
		return ctrl;
	}
	@Bean
	public MypageCtrl  mypageCtrl() {
		MypageCtrl ctrl =  new MypageCtrl();
		ctrl.setMypageSvc(mypageSvc);
		return ctrl;
	}
	@Bean 
	public EventCtrl eventCtrl() {
		EventCtrl ctrl =  new EventCtrl();
		ctrl.setEventSvc(eventSvc);
		return ctrl;
	}
	@Bean 
	public MainCtrl mainCtrl() {
		MainCtrl ctrl =  new MainCtrl();
		ctrl.setMainSvc(mainSvc);
		return ctrl;
	}
	@Bean 
	public ArtistCtrl artistCtrl() {
		ArtistCtrl ctrl =  new ArtistCtrl();
		ctrl.setArtistSvc(artistSvc);
		return ctrl;
	}
	@Bean 
	public NoticeCtrl noticeCtrl() {
		NoticeCtrl ctrl =  new NoticeCtrl();
		ctrl.setNoticeSvc(noticeSvc);
		return ctrl;
	}


}
