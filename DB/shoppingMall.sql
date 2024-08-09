CREATE TABLE order (
	order_no	number		NOT NULL,
	item_no	number		NOT NULL,
	member_no	number		NOT NULL,
	order_price	number		NULL,
	order_day	Date		NULL,
	order_status	varchar2(12)		NULL,
	order_refund	varchar2(150)		NULL,
	order-post	varchar2(6)		NULL,
	order_address1	varchar2(300)		NULL,
	order_address2	varchar2(300)		NULL,
	order_name	varchar2(21)		NULL,
	order_contact	char(11)		NULL,
	order_item_cnt	number		NULL
);

CREATE TABLE item (
	item_no	number		NOT NULL,
	cate_no	number		NOT NULL,
	item_name	varchar2(300)		NULL,
	item_price	number		NULL,
	item_sale_price	number		NULL,
	item_date	Date		NULL,
	item_cnt	number		NULL
);

CREATE TABLE category (
	cate_no	number		NOT NULL,
	cate_no2	number		NOT NULL,
	cate_name	varchar2(30)		NULL
);

CREATE TABLE order_detail (
	order_detail_no	number		NOT NULL,
	item_no	number		NOT NULL,
	order_no	number		NOT NULL,
	order_detail_price	number		NULL,
	order_detail_cnt	number		NULL
);

CREATE TABLE member (
	member_no	number		NOT NULL,
	member_name	varchar2(21)		NULL,
	member_id	varchar2()		NULL,
	member_pw	varchar2()		NULL,
	member_block	char(1)		NULL,
	member_rank	varchar2(12)		NULL
);

CREATE TABLE shipping (
	shipping_no	number		NOT NULL,
	member_no	number		NOT NULL,
	shipping_name	varhar2(21)		NULL,
	shipping_contact	char(11)		NULL,
	shipping_post	varchar2(6)		NULL,
	shipping_address1	varchar2(300)		NULL,
	shipping_address2	varchar2(300)		NULL
);

CREATE TABLE cart (
	cart_no	number		NOT NULL,
	member_no	number		NOT NULL,
	item_no	number		NOT NULL,
	cart_count	number		NULL,
	item_attach_no	number		NULL
);

CREATE TABLE attach (
	attach_no	number		NOT NULL,
	attach_name	varchar2		NULL,
	attach_type	varchar2		NULL,
	arrach_size	number		NULL
);

CREATE TABLE item_image (
	item_no	number		NOT NULL,
	attach_no	number		NOT NULL
);

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
	member_no
);

ALTER TABLE shipping ADD CONSTRAINT PK_SHIPPING PRIMARY KEY (
	shipping_no
);

ALTER TABLE cart ADD CONSTRAINT PK_CART PRIMARY KEY (
	cart_no
);

ALTER TABLE attach ADD CONSTRAINT PK_ATTACH PRIMARY KEY (
	attach_no
);
