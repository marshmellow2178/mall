create table domain (  -- 이메일 도메인 목록
	idx int auto_increment primary key,
    id varchar(20) unique
);

create table t_member_info ( -- 회원정보테이블
	mi_idx int auto_increment primary key,
	mi_id varchar(20) unique, 			-- 회원 ID
	mi_pw varchar(20) not null, 			-- 비밀번호
	mi_name varchar(20) not null, 			-- 이름
	mi_phone char(8) not null, 	-- 휴대폰
	mi_email varchar(50) unique not null, 			-- 이메일
    mi_domain varchar(20), 
    mi_addr1 varchar(20) not null,
    mi_addr2 varchar(20),
	mi_point int default 0, 				-- 보유포인트
	mi_lastlogin datetime, 					-- 최종로그인일자
	mi_joindate datetime default now(), 	-- 가입일
	mi_status char(1),	-- 상태
    foreign key(mi_domain) references domain(id)
);

create table t_member_point ( -- 회원 포인트 내역 테이블
	mp_idx int auto_increment primary key, 	-- 일련번호
	mi_id varchar(20), 						-- 회원 ID
	mp_su char(1) default 's', 				-- 사용/적립
	mp_point int default 0, 				-- 포인트
	mp_desc varchar(20) not null, 			-- 사용/적립 내용
	mp_date datetime default now(), 		-- 사용/적립일
    foreign key(mi_id) references t_member_info(mi_id)
);	

create table artist( 
	artist_idx int auto_increment primary key, 			
	artist_name varchar(20) not null unique
);

create table product_type( 
	type_idx int auto_increment primary key,				
	type_name varchar(20) not null unique				
);

create table t_product_info ( 
	pi_idx int auto_increment primary key,
	pi_name varchar(50) not null,				-- 상품명
	pi_price int default 0,						-- 가격
	pi_dc int default 0 ,						-- 할인율
    artist_name varchar(20) not null,
    type_name varchar(20) not null,
	pi_img varchar(50) not null, 				-- 상품이미지
	pi_desc varchar(50) default '',				-- 설명 이미지
    pi_stock int default 0,
	pi_isview char(1), 				-- 게시여부
	pi_date datetime default now() , 			-- 등록일
    pi_sale int default 0,
	foreign key(artist_name) references artist(artist_name),
	foreign key(type_name) references product_type(type_name)
);

create table t_order_cart( -- 장바구니
	oc_idx int auto_increment primary key,			-- 일련번호
	mi_id varchar(20) ,								-- 회원아이디
	pi_id int, 								-- 상품아이디									-- 
	oc_cnt int default 0, 							-- 상품개수
    
    foreign key(mi_id) references t_member_info(mi_id),
    foreign key(pi_id) references t_product_info(pi_idx)
);

create table t_order_info( -- 주문정보 테이블
	oi_idx int auto_increment primary key,
	mi_id varchar(20) , 					-- 회원아이디
	oi_name varchar(20) not null, 			-- 수취인명
	oi_phone varchar(13) not null,			-- 배송지 전화번호
	oi_addr1 varchar(50) not null, 			-- 배송지주소1
	oi_addr2 varchar(50) not null,			-- 배송지주소2
	oi_payment char(1) default 'a',			-- 결제수단
	oi_pay int default 0,					-- 결제액
	oi_upoint int default 0, 				-- 포인트 사용
	oi_spoint int default 0,				-- 포인트 적립
	oi_status varchar(10) default "결제완료",		-- 주문상태
	oi_date datetime default now() ,		-- 주문일

	foreign key(mi_id) references t_member_info(mi_id)
);

create table t_order_detail (				-- 주문상세정보	
	od_idx int  auto_increment primary key,	-- 일련번호
	oi_idx int, 						-- 주문번호
	od_name varchar(50) not null ,			-- 상품명
    od_ps varchar(20),
	od_cnt int default 0, 					-- 개수
	od_price int default 0 ,				-- 단가
	od_img varchar(50) not null ,			-- 상품이미지
    
    foreign key(oi_idx) references t_order_info(oi_idx)   
);		

create table t_bbs_event(  -- 이벤트			
	be_idx int primary key auto_increment,				-- 글번호
	be_title varchar(100) not null, 	-- 이벤트제목
	be_img1 varchar(50), 				-- 이미지1
	be_img2 varchar(50), 				-- 이미지2
	be_date datetime default now(),		-- 작성일
	be_sdate datetime not null,			-- 이벤트 시작일
	be_edate datetime, 					-- 이벤트 종료일
	be_status varchar(10)				-- 이벤트 상태
);

create table t_admin_info ( --  관리자 정보
	ai_idx int auto_increment primary key, 	
	ai_id varchar(20), 		-- 아이디
	ai_pw varchar(20) not null, 		-- 비밀번호
	ai_name varchar(20) not null, 		-- 이름
	ai_use char(1) default 'y', 		-- 사용여부
	ai_date datetime default now()		-- 등록일
);

create table t_bbs_notice( -- 공지사항
	bn_idx int primary key auto_increment,					-- 글번호
	bn_ctgr varchar(10) not null, 			-- 분류
	bn_title varchar(100) not null,			-- 제목
	bn_content text not null ,				-- 내용
	bn_date datetime default now() 		-- 작성일
);

create table t_bbs_faq( -- faq 테이블
	bf_idx int primary key auto_increment,				-- 글번호
	bf_ctgr varchar(10) default 'a',		-- 질문분류
	bf_content text,			-- 질문내용
	bf_answer text,					-- 답변 내용
    bf_date datetime default now()
);

create table t_bbs_mantoman (--  : 1:1문의			
	bm_idx int primary key auto_increment,				-- 글번호
	mi_id varchar(20), 					-- fk 회원아이디
	bm_ctgr char(1) default 'a',		-- 질문분류
	bm_title varchar(100) not null,		-- 질문제목
	bm_content text not null, 			-- 질문내용
	bm_date datetime default now()	,	-- 질문일자
	bf_isend char(1) default 'n', 		-- 답변완료여부
    
	foreign key(mi_id) references t_member_info(mi_id)
);

create table t_bbs_mantoman_answer( -- : 1:1문의_답변			
	bma_idx	int auto_increment primary key,			-- 답변 글번호
	bm_idx int,	 									-- fk 문의 글번호
	bma_coment text not null,						-- 답변내용
	bma_date datetime default now(),				-- 답변일자

	foreign key(bm_idx) references t_bbs_mantoman(bm_idx)
);
