# Basic mall project

## 팀 프로젝트

## 개요
> 아이돌 관련상품을 판매하는 모의 쇼핑몰로, 여러 굿즈 판매사이트를 참고하여 작성

## 개발 환경
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
![바로가기](https://drive.google.com/file/d/1-J3yrv75pvlxHSukakzbzGdLAJgwNnhL/view?usp=drive_link)


## 개인 프로젝트
위 팀 프로젝트를 개인적으로 재작업한 것이므로, <br>
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
2. ![설계서}(https://drive.google.com/file/d/1Fyqv0SovRHhIs6CNP9aJh4b9ah05JlU9/view?usp=drive_link)
3. 소스 코드

### 0726_UPDATE: UI
1. 요구 사항
- 서버 용량 문제 해결을 위한 이미지 삭제
- 간소한 디자인을 위한 CSS와 자바스크립트 통합
2. ![설계서](https://drive.google.com/file/d/1I79g4WbxSPPoTd3-25Z91N6-gQzJNr8m/view?usp=drive_link)
3. 소스코드

<<<<<<< HEAD
### 0920_UPDATE: 출석체크
1. 요구 사항
- 사용자가 하루 첫 로그인 시, 랜덤한 양의 포인트를 지급한다
- 연속 출석 일수에 따라 보상을 증가한다
- 출석과 연속 출석을 달력에 표시한다
2. 설계서

3. 소스코드
=======
- 이벤트 모음 
![main1](https://github.com/marshmellow2178/mall/assets/115971843/b60ea70c-3155-4cd7-a411-8cac56019362)

- 추천상품 모음
![main2](https://github.com/marshmellow2178/mall/assets/115971843/9d5ddca1-baa6-40b7-808c-253184fe0356)

### 상품
![상품](https://github.com/marshmellow2178/mall/assets/115971843/d9772e10-27d1-4766-b118-d0ced220fe75)

### 마이페이지
- 공통메뉴
![mypage_menu](https://github.com/marshmellow2178/mall/assets/115971843/e45147cb-359b-4626-8a17-48edd8b03eaf)

- 회원
![회원](https://github.com/marshmellow2178/mall/assets/115971843/9ccd340f-3fc9-4f69-8488-cb7de50a2d0e)

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
### 09-20
- 사용자 페이지 오류 수정
- 출석체크 기능 추가
>>>>>>> 32b79f37de329951033127dd1eba4e9c3b5e4fe8
