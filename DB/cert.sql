// 이메일 인증번호 저장 테이블입니다
CREATE TABLE cert(
cert_email varchar2(60) PRIMARY KEY NOT null, 
cert_number char(6) NOT null, 
cert_time DATE DEFAULT sysdate NOT null
);
