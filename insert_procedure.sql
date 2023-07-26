delimiter $$
create procedure add_domain(id varchar(20))
begin
	 insert into domain(id) values (concat(id, '.com'));
end $$
delimiter ;

call add_domain('naver');
call add_domain('gmail');

delimiter $$
create procedure sign_in(mi_id varchar(20), mi_pw varchar(20), mi_name varchar(20),
mi_phone char(8), mi_email varchar(50), mi_domain VARCHAR(20), mi_addr1 varchar(20))
begin
declare sign_point int;
declare mp_desc varchar(20);

set sign_point = 1000;
set mp_desc = '회원가입';
insert into t_member_info(mi_id, mi_pw, mi_name, mi_phone, mi_email, mi_domain, mi_addr1, mi_point) 
values (mi_id, mi_pw, mi_name, mi_phone, mi_email, mi_domain, mi_addr1, sign_point);

insert into t_member_point(mi_id, mp_su, mp_point, mp_desc)
values(mi_id, 's', sign_point, mp_desc);

end $$
delimiter ;

drop procedure sign_in;
call sign_in('test1', '1234', '홍길동', '12345678', 'test1', 'gmail.com', 'test_addr');
call sign_in('test2', '1234', '전우치', '12345679', 'test2', 'naver.com', 'test_addr');
call sign_in('test3', '1234', '한유진', '12345680', 'test3', 'naver.com', 'test_addr');

insert into product_type(type_name) values('CD');
insert into product_type(type_name) values('패키지');
insert into product_type(type_name) values('의류');
insert into product_type(type_name) values('문구류');
insert into product_type(type_name) values('포토카드');
insert into product_type(type_name) values('응원봉');

delimiter $$
create procedure insert_event()
begin
declare val int default 1;
declare title varchar(50) default '이벤트 제목';
while(val <= 50) do
	insert into t_bbs_event(be_title, be_img1, be_img2, be_sdate, be_edate, be_status)
    values(title, 'event.png', 'info.png', '2023-04-01', '2023-07-01', 'n');
set val = val + 1;
end while;
end $$
delimiter ;

call insert_event();

INSERT INTO t_admin_info(ai_id, ai_pw, ai_name)
VALUES("admin01", '1234', '관리자1');

insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('앨범6', 10000, 0, "뉴진스", "CD", "CD.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('앨범7', 10000, 0, "뉴진스", "CD", "CD.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('앨범8', 10000, 0, "뉴진스", "CD", "CD.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('앨범9', 10000, 0, "뉴진스", "CD", "CD.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('앨범10', 10000, 0, "뉴진스", "CD", "CD.png", "info.png", 100, 'y');

insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('패키지 2022', 20000, 10, "뉴진스", "패키지", "gift.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('패키지 2023', 20000, 10, "뉴진스", "패키지", "gift.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('포토카드_1', 5000, 0, "뉴진스", "포토카드", "photocard.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('포토카드_2', 5000, 0, "뉴진스", "포토카드", "photocard.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('포토카드_3', 5000, 0, "뉴진스", "포토카드", "photocard.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('포토카드_4', 5000, 0, "뉴진스", "포토카드", "photocard.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('포토카드_5', 5000, 0, "뉴진스", "포토카드", "photocard.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('의류', 30000, 0, "뉴진스", "의류", "clothes.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('문구', 10000, 20, "뉴진스", "문구류", "stationary.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('응원봉', 20000, 30, "뉴진스", "응원봉", "lightstick.png", "info.png", 100, 'y');
	
delimiter $$
CREATE PROCEDURE insert_product(aname VARCHAR(20))
BEGIN
DECLARE val INT DEFAULT 1;
while(val <=10) DO
	insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
	pi_img, pi_desc, pi_stock, pi_isview) 
	VALUES(CONCAT('앨범', val), 10000, 0, aname, "CD", "CD.png", "info.png", 100, 'y');
SET val = val +1;
END while;
SET val = 1;
while(val <=5) DO
	insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
	pi_img, pi_desc, pi_stock, pi_isview) 
	VALUES('포토카드_1', 5000, 0, aname, "포토카드", "photocard.png", "info.png", 100, 'y');
SET val = val +1;
END while;
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('의류', 30000, 0, aname, "의류", "clothes.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('문구', 10000, 20, aname, "문구류", "stationary.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('응원봉', 20000, 30, aname, "응원봉", "lightstick.png", "info.png", 100, 'y');
END $$
delimiter ;

CALL insert_product('(여자)아이들');
CALL insert_product('르세라핌');
CALL insert_product('에스파');
CALL insert_product('임영웅');
CALL insert_product('엔시티');
CALL insert_product('세븐틴');
CALL insert_product('방탄소년단');
CALL insert_product('찰리 푸스');
CALL insert_product('아이브');

delimiter $$
CREATE PROCEDURE insert_package(aname VARCHAR(20))
BEGIN
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('패키지 2022', 20000, 10, aname, "패키지", "gift.png", "info.png", 100, 'y');
insert into t_product_info(pi_name, pi_price, pi_dc, artist_name, type_name, 
pi_img, pi_desc, pi_stock, pi_isview) 
VALUES('패키지 2023', 20000, 10, aname, "패키지", "gift.png", "info.png", 100, 'y');
END $$
delimiter ;

CALL insert_package('(여자)아이들');
CALL insert_package('르세라핌');
CALL insert_package('에스파');
CALL insert_package('임영웅');
CALL insert_package('엔시티');
CALL insert_package('세븐틴');
CALL insert_package('방탄소년단');
CALL insert_package('찰리 푸스');
CALL insert_package('아이브');

UPDATE t_bbs_event SET be_status ='e';