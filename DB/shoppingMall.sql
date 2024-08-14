CREATE TABLE orders (
	orders_no	number		primary key,
	orders_member_id	varchar2(20)		NOT NULL,
	orders_cart_no	number		NOT NULL,
	orders_price	number	DEFAULT 0	NOT NULL,
	orders_day	Date	DEFAULT sysdate	NOT NULL,
	orders_status	varchar2(12)		NOT NULL
);
CREATE sequence order_seq;


CREATE TABLE item (
	item_no	number		primary key,
	cate_no	number		NULL,
	item_name	varchar2(300)		NOT NULL,
	item_price	number		NOT NULL,
	item_sale_price	number		NOT NULL,
	item_date	Date	DEFAULT sysdate	NOT NULL,
	item_cnt	number	DEFAULT 1	NULL,
	item_size	varchar2(3)		NOT NULL
);
create sequence item_seq;



CREATE TABLE category (
	cate_no	number		 primary key,
	cate_no2	number		NULL,
	cate_name	varchar2(30)		NOT NULL
);
create sequence category_seq;


CREATE TABLE order_detail (
	order_detail_no	number		primary key,
	order_detail_item_no	number		NOT NULL,
	order_detail_order_no	number		NOT NULL,
	order_detail_price	number		NOT NULL,
	order_detail_cnt	number	DEFAULT 1	NOT NULL
);
CREATE sequence order_detail_seq;

CREATE TABLE member (
	member_id	varchar2(20)		 primary key,
	member_pw	varchar2(16)		not null,
	member_name	varchar2(21)		NOT NULL,
	member_nickname	varchar2(30)		NOT NULL,
	member_block	char(1)		NULL,
	member_rank	varchar2(12)	DEFAULT '일반회원'	NOT NULL,
	member_point	number	DEFAULT 0	NULL,
	member_join	date	DEFAULT sysdate	NULL,
	member_login	date		NULL,
	member_post	number		NOT NULL,
	member_address1	varchar2(300)		NOT NULL,
	member_address2	varchar2(300)		NOT NULL,
	member_height	number		NULL,
	member_weight	number		NULL
);
create sequence member_seq;

CREATE TABLE cart (
	cart_no	number		 primary key,
	cart_item_no	number		not NULL,
	cart_count	number	DEFAULT 1	NOT NULL,
	item_attach_no	number		NOT NULL,
	cart_total_price	number		NOT NULL
);
create sequence cart_seq;


CREATE TABLE attach (
	attach_no	number		 primary key,
	attach_name	varchar2(255)		NOT NULL,
	attach_type	varchar2(90)		NOT NULL,
	arrach_size	number		NOT NULL
);
create sequence attach_seq;


CREATE TABLE image (
	item_no	number		not null,
	attach_no	number		not null
);



CREATE TABLE block (
	block_no	number		primary key,
	block_member_id	varchar2(20)		NOT NULL,
	block_type	char(6)		NOT NULL,
	block_memo	varchar2(300)		NOT NULL,
	block_time	date	DEFAULT sysdate	NOT NULL
);
create sequence block_seq;


CREATE TABLE refund (
	refund_order_no	number		NOT NULL,
	refund_memo	varchar2(300)		NOT NULL,
	refund_date	date		NOT NULL
);



CREATE TABLE qna (
	qna_no	number		 primary key,
	qna_writer	varchar2(20)		NOT NULL,
	qna_title	varchar2(90)		NOT NULL,
	qna_content	varchar2(3000)		NOT NULL,
	qna_time	date	DEFAULT sysdate	NOT NULL
);
create sequence qna_seq;


CREATE TABLE review (
	review_no	number		 primary key,
	review_item_no	number		not NULL,
	review_writer	varchar2(20)		NOT NULL,
	review_content	varchar2(1500)		NOT NULL,
	review_score	number		NOT NULL
);
create sequence review_seq;


CREATE TABLE review_image (
	review_no	number		NOT NULL,
	attach_no	number		NOT NULL
);



ALTER TABLE orders ADD CONSTRAINT PK_ORDERS PRIMARY KEY (
	orders_no
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

ALTER TABLE qna ADD CONSTRAINT PK_QNA PRIMARY KEY (
	qna_no
);

ALTER TABLE review ADD CONSTRAINT PK_REVIEW PRIMARY KEY (
	review_no
);

