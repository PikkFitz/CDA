DROP DATABASE IF EXISTS gescom;

CREATE DATABASE gescom;

USE gescom;

-- TABLE SUPPLIERS ----------------------------------------------------------------------------------------------

CREATE TABLE `suppliers` (
  `sup_id` int NOT NULL,
  `sup_name` varchar(50) NOT NULL,
  `sup_city` varchar(50) NOT NULL,
  `sup_address` varchar(150) NOT NULL,
  `sup_mail` varchar(75),
  `sup_phone` int(10),
  PRIMARY KEY (`sup_id`)
);

-- TABLE CUSTOMERS ----------------------------------------------------------------------------------------------

CREATE TABLE `customers` (
  `cus_id` int NOT NULL,
  `cus_lastname` varchar(50) NOT NULL,
  `cus_firstname` varchar(50) NOT NULL,
  `cus_address` varchar(150) NOT NULL,
  `cus_zipcode` tinyint(5) NOT NULL,
  `cus_city` varchar(50) NOT NULL,
  `cus_mail` varchar(75),
  `cus_phone` int(10),
  PRIMARY KEY (`cus_id`)
);

-- TABLE ORDERS ----------------------------------------------------------------------------------------------

CREATE TABLE `orders` (
  `ord_id` int NOT NULL AUTO_INCREMENT,
  `ord_order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `ord_ship_date` date,
  `ord_bill_date` date,
  `ord_reception_date` date,
  `ord_status` varchar(25) NOT NULL,
  `cus_id` int,
  PRIMARY KEY (`ord_id`),
  FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`)
);

-- TABLE CATEGORIES ----------------------------------------------------------------------------------------------

CREATE TABLE `categories` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(200) NOT NULL,
  `cat_parent_id` int,
  PRIMARY KEY (`cat_id`),
  FOREIGN KEY (`cat_parent_id`) REFERENCES `categories` (`cat_id`)
);

-- TABLE PRODUCTS ----------------------------------------------------------------------------------------------

CREATE TABLE `products` (
  `pro_id` int NOT NULL AUTO_INCREMENT,
  `pro_ref` varchar(10) NOT NULL,
  `pro_name` varchar(200) NOT NULL,
  `pro_desc` text(1000) NOT NULL,
  `pro_price` decimal(6,2) NOT NULL,
  `pro_stock` smallint(4),
  `pro_color` varchar(30),
  `pro_picture` varchar(40),
  `pro_add_date` date NOT NULL DEFAULT current_timestamp(),
  `pro_update_date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pro_publish` tinyint(1) NOT NULL,
  `cat_id` int NOT NULL,
  `sup_id` int NOT NULL,
  PRIMARY KEY (`pro_id`),
  FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`),
  FOREIGN KEY (`sup_id`) REFERENCES `suppliers` (`sup_id`)
);

-- TABLE DETAILS ----------------------------------------------------------------------------------------------

CREATE TABLE `details` (
  `det_id` int NOT NULL AUTO_INCREMENT,
  `det_price` decimal(6,2) NOT NULL,
  `det_quantity` int NOT NULL CHECK (`det_quantity` >=1 AND `det_quantity` <=100),
  `pro_id` int NOT NULL,
  `ord_id` int NOT NULL,
  PRIMARY KEY (`det_id`),
  FOREIGN KEY (`pro_id`) REFERENCES `products` (`pro_id`),
  FOREIGN KEY (`ord_id`) REFERENCES `orders` (`ord_id`)
  );

  -- INDEX ----------------------------------------------------------------------------------------------

CREATE UNIQUE INDEX `product_reference` 
ON `products` (`pro_ref` ASC);
