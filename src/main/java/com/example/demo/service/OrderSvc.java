package com.example.demo.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dto.OrderCartDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.MemberInfo;
import com.example.demo.entity.OrderCart;
import com.example.demo.entity.OrderDetail;
import com.example.demo.entity.OrderInfo;
import com.example.demo.entity.Point;
import com.example.demo.entity.ProductInfo;
import com.example.demo.global.Code_List;
import com.example.demo.repository.MemberRepo;
import com.example.demo.repository.OrderCartRepo;
import com.example.demo.repository.OrderDetailRepo;
import com.example.demo.repository.OrderInfoRepo;
import com.example.demo.repository.PointRepo;
import com.example.demo.repository.ProductRepo;
import com.example.demo.vo.OrderInfoVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderSvc {
	private final OrderCartRepo orderCartRepo;
	private final OrderDetailRepo orderDetailRepo;
	private final ProductRepo productRepo;
	private final MemberRepo memberRepo;
	private final OrderInfoRepo orderInfoRepo;
	private final PointRepo pointRepo;
	
	
	public OrderCartDto getProduct(int idx, String miid, int piid, int cnt) {
		//바로구매 페이지 주문
		ProductInfo pi = productRepo.findByIdxAndIsview(piid, "y");
		OrderCartDto ocd = OrderCartDto.builder()
				.idx(idx)
				.mi_id(miid)
				.pi_id(piid)
				.cnt(cnt)
				.pi_name(pi.getName())
				.pi_img(pi.getImg())
				.price(pi.getPrice())
				.dc(pi.getDc())
				.artist_name(pi.getArtist())
				.build();
		return ocd;
		
	}
	public List<OrderCartDto> getProductList(String[] ocidx){
		//장바구니 페이지 주문
		List<OrderCartDto> ocdList = new ArrayList<OrderCartDto>();
		for(int i = 1;i<ocidx.length;i++) {
			int temp = Integer.parseInt(ocidx[i]);
			OrderCart oc = orderCartRepo.findByIdx(temp);
			ProductInfo pi = productRepo.findByIdxAndIsview(oc.getPiid(), "y");
			OrderCartDto ocd = OrderCartDto.builder()
						.idx(oc.getIdx())
						.cnt(oc.getCnt())
						.pi_id(pi.getIdx())
						.mi_id(oc.getMiid())
						.pi_name(pi.getName())
						.pi_img(pi.getImg())
						.artist_name(pi.getArtist())
						.price(pi.getPrice())
						.dc(pi.getDc())
						.build();
			ocdList.add(ocd);
		}
		return ocdList;
	}
	
	@Transactional
	public int orderInsert(OrderInfoVo oid, List<OrderCartDto> ocdList) {
		MemberInfo mi = memberRepo.findById(oid.getMiid());
		OrderInfo oi = OrderInfo.builder()
				.miid(oid.getMiid())
				.phone(oid.getPhone())
				.name(oid.getName())
				.addr1(oid.getAddr1())
				.addr2(oid.getAddr2())
				.payment(oid.getPayment())
				.pay(Integer.parseInt(oid.getPay()))
				.upoint(Integer.parseInt(oid.getUpoint()))
				.spoint(Integer.parseInt(oid.getSpoint()))
				.status(Code_List.PAID)
				.date(LocalDateTime.now())
				.build();
		int oiidx = orderInfoRepo.save(oi).getIdx();

		for(int i = 0;i<ocdList.size();i++) {
			OrderCartDto ocd = ocdList.get(i);
			OrderDetail od = OrderDetail.builder()
					.oiidx(oiidx)
					.product(ocd.getPi_name())
					.cnt(ocd.getCnt())
					.price(ocd.getRealprice())
					.img(ocd.getPi_img())
					.build();
			ProductInfo pi = productRepo.findByIdxAndIsview(ocd.getPi_id(), "y");
			pi.setSale(ocd.getCnt());
			pi.setStock(ocd.getCnt());
			productRepo.save(pi);
			orderDetailRepo.save(od);
			if(ocd.getIdx()!=0) {
				orderCartRepo.deleteByIdx(ocd.getIdx());
			}
		}
		
		Point save = Point.builder()
				.id(mi.getId())
				.point(oi.getPay()/Code_List.SAVE_RATE)
				.desc(Code_List.SAVE)
				.su("s")
				.date(LocalDateTime.now())
				.build();
		pointRepo.save(save);
		mi.setPoint(mi.getPoint() + save.getPoint());
		memberRepo.save(mi);
		
		Point use = Point.builder()
				.id(mi.getId())
				.point(oi.getUpoint())
				.desc(Code_List.USE)
				.su("u")
				.date(LocalDateTime.now())
				.build();
		pointRepo.save(use);
		mi.setPoint(mi.getPoint() - use.getPoint());
		memberRepo.save(mi);
		
		return oiidx;
	}
	
	public OrderInfo getOrderInfo(int oiidx) {
		return orderInfoRepo.findByIdx(oiidx);
	}
	
	public List<OrderDetail> getOrderDetail(int oiidx){
		return orderDetailRepo.findByOiidx(oiidx);
	}
	
	public List<OrderInfo> getOrderList(String miid, Pageable pageable, PageInfo pageInfo){
		Page<OrderInfo> orderPage = orderInfoRepo.findByMiid(pageable, miid);
		pageInfo.setPage(orderPage);
		return orderPage.getContent();
	}
	
	public List<OrderInfo> getAdminOrderList(Pageable pageable, PageInfo pageInfo){
		Page<OrderInfo> orderPage = orderInfoRepo.findAll(pageable);
		pageInfo.setPage(orderPage);
		return orderPage.getContent();
	}
	
	public void setStatus(int idx, String status) {
		OrderInfo oi = orderInfoRepo.findByIdx(idx);
		oi.setStatus(status);
		orderInfoRepo.save(oi);
	}
}
