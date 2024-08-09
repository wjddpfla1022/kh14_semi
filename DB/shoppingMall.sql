CREATE TABLE order (
	order_no	number		NOT NULL,
	order_member_id	varchar2(20)		NOT NULL,
	order_cart_no	number		NOT NULL,
	order_price	number	DEFAULT 0	NOT NULL,
	order_day	Date	DEFAULT sysdate	NOT NULL,
	order_status	varchar2(12)		NOT NULL,
	order_name	varchar2(21)		NOT NULL,
	order_contact	char(11)		NOT NULL
);

COMMENT ON COLUMN order.order_no IS 'primary key';

COMMENT ON COLUMN order.order_member_id IS '회원 member 테이블에 member_id 외래키

on delete cascade 추가';

COMMENT ON COLUMN order.order_cart_no IS '기본키
on delete cascade';

COMMENT ON COLUMN order.order_price IS 'not null
기본 0';

COMMENT ON COLUMN order.order_day IS '기본 sysdate not null';

COMMENT ON COLUMN order.order_status IS 'not null';

COMMENT ON COLUMN order.order_name IS 'not null';

COMMENT ON COLUMN order.order_contact IS 'not null';

CREATE TABLE item (
	item_no	number		NULL,
	cate_no	number		NULL,
	item_name	varchar2(300)		NOT NULL,
	item_price	number		NOT NULL,
	item_sale_price	number		NOT NULL,
	item_date	Date	DEFAULT sysdate	NOT NULL,
	item_cnt	number	DEFAULT 1	NULL
);

COMMENT ON COLUMN item.item_no IS '기본키';

COMMENT ON COLUMN item.cate_no IS '필수입력항목';

COMMENT ON COLUMN item.item_name IS '필수입력항목';

COMMENT ON COLUMN item.item_price IS '필수입력항목
미입력시 최소 값 0원 이상';

COMMENT ON COLUMN item.item_sale_price IS '필수입력항목
미입력시 최소 값 0원 이상';

COMMENT ON COLUMN item.item_date IS '필수입력항목
미입력시 현재시각으로 설정';

COMMENT ON COLUMN item.item_cnt IS '미입력 시 최소 값 1개 이상';

CREATE TABLE category (
	cate_no	number		NULL,
	cate_no2	number		NULL,
	cate_name	varchar2(30)		NOT NULL
);

COMMENT ON COLUMN category.cate_no IS '기본키';

COMMENT ON COLUMN category.cate_no2 IS '필수입력항목';

COMMENT ON COLUMN category.cate_name IS '중복불가
필수입력항목';

CREATE TABLE order_detail (
	order_detail_no	number		NOT NULL,
	order_detail_item_no	number		NOT NULL,
	order_detail_order_no	number		NOT NULL,
	order_detail_price	number		NOT NULL,
	order_detail_cnt	number	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN order_detail.order_detail_no IS 'primary key';

COMMENT ON COLUMN order_detail.order_detail_item_no IS '상품  item 테이블  상품번호 item_no 외래키
on delete cascade 붙이기';

COMMENT ON COLUMN order_detail.order_detail_order_no IS '주문 order 테이블 order_no 왜래키
on delete cascade 붙이기';

COMMENT ON COLUMN order_detail.order_detail_price IS '가격은 0 이상  not null';

COMMENT ON COLUMN order_detail.order_detail_cnt IS '기본 1 ( > 0)  not null';

CREATE TABLE member (
	member_id	varchar2(20)		NOT NULL,
	member_name	varchar2(21)		NOT NULL,
	member_pw	varchar2()		NULL,
	member_block	char(1)		NULL,
	member_rank	varchar2(12)	DEFAULT '일반회원'	NOT NULL,
	member_point	number	DEFAULT 0	NULL,
	member_join	date	DEFAULT sysdate	NULL,
	member_login	date		NULL,
	member_post	number		NOT NULL,
	member_address1	varchar2(300)		NOT NULL,
	member_address2	varchar2(300)		NOT NULL
);

COMMENT ON COLUMN member.member_id IS '기본키';

COMMENT ON COLUMN member.member_name IS '필수입력항목';

COMMENT ON COLUMN member.member_pw IS '필수입력항목';

COMMENT ON COLUMN member.member_rank IS '필수입력항목
'일반회원', '우수회원', '관리자'로 구분
미입력시 '일반회원'';

COMMENT ON COLUMN member.member_point IS '필수입력항목
미입력시 기본값 0
포인트는 0 이상';

COMMENT ON COLUMN member.member_join IS '필수입력항목
미입력시 현재시각으로 설정';

COMMENT ON COLUMN member.member_post IS '필수입력항목
숫자 5-6글자';

COMMENT ON COLUMN member.member_address1 IS '필수입력항목';

COMMENT ON COLUMN member.member_address2 IS '필수입력항목';

CREATE TABLE cart (
	cart_no	number		NOT NULL,
	cart_item_no	number		NULL,
	cart_count	number	DEFAULT 1	NOT NULL,
	item_attach_no	number		NOT NULL
);

COMMENT ON COLUMN cart.cart_no IS '기본키';

COMMENT ON COLUMN cart.cart_item_no IS '기본키
on delete cascade';

COMMENT ON COLUMN cart.cart_count IS '필수입력항목
1이상';

COMMENT ON COLUMN cart.item_attach_no IS '필수 입력항목';

CREATE TABLE attach (
	attach_no	number		NULL,
	attach_name	varchar2(255)		NOT NULL,
	attach_type	varchar2(90)		NOT NULL,
	arrach_size	number		NOT NULL
);

COMMENT ON COLUMN attach.attach_no IS '기본키';

COMMENT ON COLUMN attach.attach_name IS '필수입력항목
unique';

COMMENT ON COLUMN attach.attach_type IS '필수입력항목';

COMMENT ON COLUMN attach.arrach_size IS '필수입력항목';

CREATE TABLE image (
	item_no	number		NULL,
	attach_no	number		NULL
);

COMMENT ON COLUMN image.item_no IS '필수입력항목';

COMMENT ON COLUMN image.attach_no IS '필수입력항목';

CREATE TABLE block (
	block_no	number		NOT NULL,
	block_member_id	varchar2(20)		NOT NULL,
	block_type	char(6)		NOT NULL,
	block_memo	varchar2(300)		NOT NULL,
	block_time	date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN block.block_no IS '기본키';

COMMENT ON COLUMN block.block_member_id IS '회원 탈퇴시  차단내역에서도 삭제';

COMMENT ON COLUMN block.block_type IS '필수입력항목
'차단,' 해제'로 구분';

COMMENT ON COLUMN block.block_memo IS '필수입력항목';

COMMENT ON COLUMN block.block_time IS '필수입력항목
미입력시 현재시각으로 설정';

CREATE TABLE refund (
	refund_order_no	number		NOT NULL,
	refund_memo	varchar2(300)		NOT NULL,
	refund_date	date		NOT NULL
);

COMMENT ON COLUMN refund.refund_order_no IS 'primary key';

COMMENT ON COLUMN refund.refund_date IS '필수입력항목
미입력시 현재 시각으로 설정';

ALTER TABLE order ADD CONSTRAINT PK_ORDER PRIMARY KEY (
	order_no
);

ALTER TABLE item ADD CONSTRAINT PK_ITEM PRIMARY KEY (
	item_no
);

ALTER TABLE category ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	cate_no
);

ALTER TABLE order_detail ADD CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (
	order_detail_no
);

ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_id
);

ALTER TABLE cart ADD CONSTRAINT PK_CART PRIMARY KEY (
	cart_no
);

ALTER TABLE attach ADD CONSTRAINT PK_ATTACH PRIMARY KEY (
	attach_no
);

ALTER TABLE block ADD CONSTRAINT PK_BLOCK PRIMARY KEY (
	block_no
);
