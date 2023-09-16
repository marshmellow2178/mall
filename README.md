# Basic mall project
> 기본 쇼핑몰 프로젝트

## 사이트 주소
### 사용자
http://init2178.cafe24.com/demo/index
### 어드민
http://init2178.cafe24.com/demo/super

## 프로젝트 개요
> 기본적인 쇼핑몰의 기능을 스프링 부트를 사용하여 구현합니다.<br>
국비 지원 학원에서 진행되었던 팀 프로젝트를 개인적으로 재작업한 것이므로, <br>
프로젝트의 기본적인 기획과 UI설계는 팀 프로젝트와 동일합니다

## 정보
### 주요 기능
  - 상품 구매/장바구니(실제 결제되지 않습니다)
  - 회원가입/정보수정
  - 이벤트/고객센터 게시판
  - 관리자 상품 및 게시물 등록/수정

 ### 개발 환경
  - HTML/CSS/JavaScript(JQuery)
  - JSP
  - Java 11
  - Spring Boot
  - DB: MySQL
  - 빌드: Gradle
  - 관리: GitHub, 호스팅 서버
  - IDE: 이클립스/STS3
  -
### 요구사항 정의서
![요구사항 정의서](https://github.com/marshmellow2178/mall/assets/115971843/5b80ac08-8061-4e2e-a580-07b39798fc9b)

### Flowchart
![flowchart_user](https://github.com/marshmellow2178/mall/assets/115971843/6dd14dcb-0a98-4dd7-b684-ffc0e2e30319)
![flowchart_admin](https://github.com/marshmellow2178/mall/assets/115971843/596e735f-276d-4144-82b0-c768e6cc65b5)

## 사용자 페이지
### 메인페이지
- 헤더
![헤더](https://github.com/marshmellow2178/mall/assets/115971843/7d0a7513-4b1e-4ff9-af29-eaccf8ce2fde)

- 이벤트 모음 
![main1](https://github.com/marshmellow2178/mall/assets/115971843/b60ea70c-3155-4cd7-a411-8cac56019362)

- 추천상품 모음
![main2](https://github.com/marshmellow2178/mall/assets/115971843/9d5ddca1-baa6-40b7-808c-253184fe0356)

### 상품
- 목록
![pdt_list](https://github.com/marshmellow2178/mall/assets/115971843/6b4c2b59-23e0-49e1-8a4b-35a2cda165b0)

- 상세
![상품상세](https://github.com/marshmellow2178/mall/assets/115971843/d5e87ee1-20fd-408a-9a90-d63e5be8291b)

- 구매
![구매](https://github.com/marshmellow2178/mall/assets/115971843/caa7f66f-ce5c-4d49-bdee-0f7231cd9c60)

### 마이페이지
- 공통메뉴
![mypage_menu](https://github.com/marshmellow2178/mall/assets/115971843/e45147cb-359b-4626-8a17-48edd8b03eaf)

- 회원
![회원](https://github.com/marshmellow2178/mall/assets/115971843/9ccd340f-3fc9-4f69-8488-cb7de50a2d0e)

- 장바구니
![cart](https://github.com/marshmellow2178/mall/assets/115971843/63790491-5566-45da-9a83-925603655cb8)

- 주문내역
![orderinfo](https://github.com/marshmellow2178/mall/assets/115971843/3076a5d3-bc17-4807-81aa-6159f729a149)

### 고객센터
- 문의하기
![문의하기](https://github.com/marshmellow2178/mall/assets/115971843/71a8fcf2-5d37-4c20-81b1-dd9e4523a417)

- 목록
![고객센터](https://github.com/marshmellow2178/mall/assets/115971843/ee2b61b9-bd87-400d-9aae-2b399406e21e)

## 관리자 페이지
- 메뉴
![admin](https://github.com/marshmellow2178/mall/assets/115971843/9d0c5e7b-8a60-461a-8f49-ca5405fe3c0c)

- 각 메뉴의 목록/등록/수정 기능

## 변경점
### 프레임워크/프로그램
Spring -> Spring Boot
Java 1.8 -> Java 11
Tomcat8 -> Tomcat10

### 데이터베이스
- 상품 옵션 테이블 삭제: 본래 옵션을 아티스트 멤버로 계획했으나, 대부분의 상품이 멤버 구분이 없어 삭제
- 이메일 도메인 테이블 추가
- 회원테이블 변경: 아이디 변경 가능

### UI
- 디자인 간소화 및 통일
- 메인페이지 아티스트 목록 삭제: 상품목록으로 대체(아이돌 굿즈는 꾸준히 판매되는 것이 아니므로
아티스트의 판매순위가 전달할 정보가 없다고 판단)
- 아티스트 페이지 삭제: 상품 검색 기능과 중복
- 이미지 대체: 상품 이미지 용량이 매우 커져 공통 이미지로 대체

### 기능
- 관리자 기능 추가: 상품/주문/회원 및 게시판 관리

## 업데이트
### 03-31
  - 스프링 부트 적용
  - 데이터베이스 및 디자인에서 사소한 변경
  - 호스팅 완료
### 07-26
  - 관리자 페이지 완성
  - 기본 데이터 입력 완료
  - 기존의 많은 이미지들을 대체해 용량 줄이기

