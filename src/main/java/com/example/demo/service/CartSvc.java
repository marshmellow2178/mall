package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.example.demo.dto.OrderCartDto;
import com.example.demo.entity.OrderCart;
import com.example.demo.entity.ProductInfo;
import com.example.demo.repository.OrderCartRepo;
import com.example.demo.repository.ProductRepo;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CartSvc {

	private final OrderCartRepo orderCartRepo;
	private final ProductRepo productRepo;
	
	public void cartInsert(String miid, int piid, int cnt) {
		OrderCart oc = orderCartRepo.findByMiidAndPiid(miid, piid);
		if(oc == null) {
			oc = OrderCart.builder()
					.miid(miid)
					.piid(piid)
					.cnt(cnt)
					.build();
			orderCartRepo.save(oc);
		}else {
			oc.setCnt(oc.getCnt()+cnt);
			orderCartRepo.save(oc);
		}
	}
	
	public void cartUpdate(int oc_idx, int cnt) {
		OrderCart oc = orderCartRepo.findByIdx(oc_idx);
		oc.setCnt(cnt);
		orderCartRepo.save(oc);
	}
	
	@Transactional
	public void cartDelete(String ocidx) {
		String[] s = ocidx.split(",");
		for(int i= 0;i<s.length;i++) {
			orderCartRepo.deleteByIdx(Integer.parseInt(s[i]));
		} 
	}
	
	public List<OrderCartDto> cartView(String miid){
		List<OrderCart> temp = orderCartRepo.findByMiid(miid);
		List<OrderCartDto> cartList = new ArrayList<OrderCartDto>();
		for(int i = 0;i< temp.size();i++) {
			OrderCart oc = temp.get(i);
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
			cartList.add(ocd);
		}
		return cartList;
	}
}
