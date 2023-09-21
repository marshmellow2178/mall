# Basic mall project

## 팀 프로젝트
> 아이돌 관련상품을 판매하는 모의 쇼핑몰로, 여러 굿즈 판매사이트를 참고하여 작성

### 개발 환경
- jsp, java 1.8, MySQL
- 개발 기간: 1개월
- 개발 인원: 5명
- 담당: 상품/상품 등록

### 주요 기능
  - 상품 구매/장바구니(실제 결제되지 않습니다)
  - 회원가입/정보수정
  - 이벤트/고객센터 게시판
  - 관리자 상품 및 게시물 등록/수정

### 설계도
[바로가기](https://drive.google.com/file/d/1-J3yrv75pvlxHSukakzbzGdLAJgwNnhL/view?usp=drive_link)

## 개인 프로젝트
> 위 팀 프로젝트를 개인적으로 재작업한 것이므로, <br>
프로젝트의 기본적인 기획과 UI설계는 팀 프로젝트와 동일합니다

### 사용자
http://init2178.cafe24.com/demo/index

### 어드민
http://init2178.cafe24.com/demo/super

### 개발 환경
  - HTML/CSS/JavaScript(JQuery)
  - JSP
  - Java 11
  - Spring Boot
  - DB: MySQL
  - 빌드: Gradle
  - 관리: GitHub, 호스팅 서버
  - IDE: 이클립스/STS3
  - 개발 기간: 2023.3월 ~ 현재

### 0331_UPDATE: SPRING BOOT
1. 요구 사항
- 코드 작성의 편의 및 최신 프레임워크의 학습을 위해 스프링 부트로 재작성
2. 설계
  
![springboot-1](https://github.com/marshmellow2178/mall/assets/115971843/1a361ad8-0d54-49c9-a5ba-686fc7339fac)
![springboot-2](https://github.com/marshmellow2178/mall/assets/115971843/1cdebe93-8914-4af4-89ef-fc8d49cbc368)

3. 소스코드: 상품 관련 코드의 일부분

- 상품 객체
```java
package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;
import org.hibernate.annotations.DynamicUpdate;
import lombok.*;

@Entity
@Getter  //get 메소드 자동 생성
@DynamicUpdate  //변경된 부분만 업데이트
@NoArgsConstructor(access = AccessLevel.PROTECTED)  //접근제어
@Table(name = "t_product_info")
public class ProductInfo {
	@Id
	@Column(name = "pi_idx")
	@GeneratedValue(strategy = GenerationType.IDENTITY)  //PK, 수정/신규 구분
	private int idx;
	
	@Column(name = "pi_name")
	private String name;
	
	@Column(name = "pi_price")
	private int price;
	
	@Column(name = "pi_date")
	private LocalDateTime date;

	@Builder    //생성자 패턴
	public ProductInfo(int idx, String name, int price, LocalDateTime date) {
		this.idx = idx;
		this.name = name;
		this.price = price;
		this.date = date;
	}
}
```

- 상품 목록 가져오기
```java
@Controller
@RequiredArgsConstructor  //아래 서비스 객체 생성
public class ProductCtrl {
	
	private final ProductSvc productSvc;  //싱글톤(한 개의 인스턴스만 계속해서 사용하기)
  @RequestMapping(value = "/product_list", method = RequestMethod.GET)
  	public String productList(
  			@RequestParam(value = "key", required = false)String key,
  			Model model, 
  			@PageableDefault(size=20, sort="date", direction = Sort.Direction.DESC)Pageable pageable) {
  		
  		PageInfo pageInfo = new PageInfo();
  		if(key==null){ key = ""; } 
  		List<ProductInfo> productList = productSvc.productList(key, pageable, pageInfo);
  		model.addAttribute("productList", productList);
  		model.addAttribute("pageInfo", pageInfo);
  		return "product/product_list";
  	}
}

@RequiredArgsConstructor
@Service
public class ProductSvc {
	private final ProductRepo productRepo;
  public List<ProductInfo> productList(String key, Pageable pageable, PageInfo pageInfo ) {
  		Page<ProductInfo> productPage = productRepo.findByNameContains(key, pageable);  //조회
  		pageInfo.setPage(productPage);    //자체 페이징 메소드
  		List<ProductInfo> productList = productPage.getContent();
  		return productList;
  	}
}

public interface ProductRepo extends JpaRepository<ProductInfo, Long>{
	Page<ProductInfo> findByNameContains(String name, Pageable pageable);  //상품의 이름으로 검색해오는 커스텀메소드
}
```

- 상품 등록하기
```java
package com.example.demo.vo;
import lombok.Getter;
import java.util.LocalDateTime;

@Getter
public class ProductInfoVo {
	private String name;
	private int price;
  private LocalDateTime date;
	
	public ProductInfoVo(String name, int price, LocalDateTime date) {
		this.name = name;
		this.price = price;
    this.date = date;
	}
}

@Controller
@RequestMapping(value = "/super_product_proc")
public String adminProductProc(
    HttpServletRequest request, 
    ProductInfoVo piv,  //폼 입력 받는 객체
    RedirectAttributes ra  //리다이렉트(컨트롤러 -> 컨트롤러 호출)
    ) {
  ra.addAttribute("piid", piid);
  return "redirect:/super_product_view";
}

@Service
public int productRegister(ProductInfoVo piv) {
  ProductInfo pi = ProductInfo.builder()  //빌더 패턴 사용하기
      .name(piv.getName())
      .price(piv.getPrice())
      .date(LocalDateTime.now())
      .build();
  int idx = productRepo.save(pi).getIdx();  //신규 등록시 idx자동지정
  return idx;  //idx가 지정되었다면 (0이 아니라면: DB기본 키는 1부터 auto increment) 정상 작동된 것
}
```

- 장바구니 등록 AJAX
```java
$.ajax({
  type : "POST",  //get: 쿼리 스트링(전달 가능한 정보에 제약), post: 암호화(보안이 요구되는 정보)
  url : "cart_proc_in",  //작동시킬 컨트롤러
  data : {    //전달할 데이
    "piid" : "<%=pi.getIdx()%>", 
    "cnt" : cnt	
  },
  success : function(){  //작업 성공
    if(confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
      location.href = "cart_view";
    }
  }
});

@RequestMapping(value = "/cart_proc_in", method = RequestMethod.POST)
@ResponseBody
public void CartProcIn(
    HttpServletRequest request,  //세션에 든 로그인 정보
    @RequestParam(value = "piid") Integer piid,  //ajax입력 받기(기본형은 객체형으로 변환)
    @RequestParam(value = "cnt") Integer cnt  
    ){
  HttpSession session = request.getSession();
  MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");  //회원 로그인정보 확인
  cartSvc.cartInsert(mi.getId(), piid, cnt);  //장바구니 객체에 저장
}
```

### 0726_UPDATE: UI
1. 요구 사항
- 서버 용량 문제 해결을 위한 이미지 삭제
- 간소한 디자인을 위한 CSS와 자바스크립트 통합
2. 설계

![ui설계-1](https://github.com/marshmellow2178/mall/assets/115971843/7a648e7a-c889-4e71-a8c0-b95d8059ba09)
![ui설계-2](https://github.com/marshmellow2178/mall/assets/115971843/b06e8bd5-d565-49dc-afc2-405645918fec)
![ui설계-3](https://github.com/marshmellow2178/mall/assets/115971843/31691ad0-7c7a-4f5b-a5ff-50a161adae8e)

### 0920_UPDATE: 출석체크
1. 요구 사항
- 사용자가 하루 첫 로그인 시, 랜덤한 양의 포인트를 지급한다
- 연속 출석 일수에 따라 보상을 증가한다
- 출석과 연속 출석을 달력에 표시한다
2. 설계 및 결과

![attend1](https://github.com/marshmellow2178/mall/assets/115971843/3846bcc4-fe82-4381-be29-951d693feafe)
![attend2](https://github.com/marshmellow2178/mall/assets/115971843/d804f608-fd61-4348-9537-7eb1c8c1e15a)


