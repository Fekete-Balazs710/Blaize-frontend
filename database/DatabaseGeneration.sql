CREATE TABLE site_user
(
  phone VARCHAR(10) NOT NULL,
  password VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  email VARCHAR(30) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE country
(
  country_id INT NOT NULL,
  country_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (country_id)
);

CREATE TABLE payment_type
(
  paytype_id INT NOT NULL,
  value VARCHAR(30) NOT NULL,
  PRIMARY KEY (paytype_id)
);

CREATE TABLE shopping_cart
(
  cart_id INT NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (cart_id),
  FOREIGN KEY (user_id) REFERENCES site_user(user_id)
);

CREATE TABLE shipping_method
(
  shipping_id INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  price FLOAT NOT NULL,
  PRIMARY KEY (shipping_id)
);

CREATE TABLE order_status
(
  status_id INT NOT NULL,
  status VARCHAR(30) NOT NULL,
  PRIMARY KEY (status_id)
);

CREATE TABLE product_category
(
  category_id INT NOT NULL,
  category_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (category_id)
);

CREATE TABLE promotion
(
  promotion_id INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  discount_rate INT NOT NULL,
  code VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (promotion_id)
);

CREATE TABLE address
(
  address_id INT NOT NULL,
  street_number INT NOT NULL,
  street_name VARCHAR(30) NOT NULL,
  apartman INT NOT NULL,
  city VARCHAR(30) NOT NULL,
  postal_code VARCHAR(30) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (address_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE user_address
(
  user_address_id INT NOT NULL,
  is_default BOOLEAN NOT NULL,
  user_id INT NOT NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (user_address_id),
  FOREIGN KEY (user_id) REFERENCES site_user(user_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE shop_order
(
  order_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_total FLOAT NOT NULL,
  shipping_id INT NOT NULL,
  status_id INT NOT NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id),
  FOREIGN KEY (status_id) REFERENCES order_status(status_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE product
(
  product_id INT NOT NULL,
  qty_in_stock INT NOT NULL,
  product_image VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  price FLOAT NOT NULL,
  description VARCHAR(3000) NOT NULL,
  weight FLOAT(2) NOT NULL,
  size INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

CREATE TABLE promotion_category
(
  category_id INT NOT NULL,
  promotion_id INT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES product_category(category_id),
  FOREIGN KEY (promotion_id) REFERENCES promotion(promotion_id)
);

CREATE TABLE favourites
(
  product_id INT NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (user_id) REFERENCES site_user(user_id)
);

CREATE TABLE user_payment_method
(
  paymethod_id INT NOT NULL,
  provider VARCHAR(30) NOT NULL,
  account_number VARCHAR(50) NOT NULL,
  expiry_date DATE NOT NULL,
  is_default BOOLEAN NOT NULL,
  user_id INT NOT NULL,
  paytype_id INT NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (paymethod_id),
  FOREIGN KEY (user_id) REFERENCES site_user(user_id),
  FOREIGN KEY (paytype_id) REFERENCES payment_type(paytype_id),
  FOREIGN KEY (order_id) REFERENCES shop_order(order_id)
);

CREATE TABLE order_line
(
  order_line_id INT NOT NULL,
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (order_line_id),
  FOREIGN KEY (order_id) REFERENCES shop_order(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE shopping_cart_item
(
  cart_item_id INT NOT NULL,
  quantity INT NOT NULL,
  cart_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (cart_item_id),
  FOREIGN KEY (cart_id) REFERENCES shopping_cart(cart_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE user_review
(
  review_id INT NOT NULL,
  rating_value INT NOT NULL,
  comment VARCHAR(1000) NOT NULL,
  user_id INT NOT NULL,
  order_line_id INT NOT NULL,
  PRIMARY KEY (review_id),
  FOREIGN KEY (user_id) REFERENCES site_user(user_id),
  FOREIGN KEY (order_line_id) REFERENCES order_line(order_line_id)
);