CREATE TABLE connection_order_cart(
cart_No NUMBER REFERENCES cart(cart_no) ON DELETE CASCADE NOT NULL PRIMARY key,
order_detail_no NUMBER references order_detail(order_detail_no) ON DELETE CASCADE NOT NULL
);
