CREATE TABLE connection_order_cart(
cart_No NUMBER REFERENCES cart(cart_no) ON DELETE CASCADE NOT NULL,
buyer varchar2(20) REFERENCES member(member_id) ON DELETE CASCADE NOT NULL,
cnt_payment NUMBER
);
INSERT INTO connection_order_cart(
cart_no, buyer, cnt_payment
) values(
328,'vjaewook',5
);
