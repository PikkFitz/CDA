DROP DATABASE IF EXISTS gescom_export_looping;

CREATE DATABASE gescom_export_looping;

USE gescom_export_looping;


CREATE TABLE suppliers(
   sup_id INT,
   sup_name VARCHAR(50)  NOT NULL,
   sup_city VARCHAR(50)  NOT NULL,
   sup_address VARCHAR(150)  NOT NULL,
   sup_mail VARCHAR(75) ,
   sup_phone INT,
   PRIMARY KEY(sup_id)
);

CREATE TABLE products(
   pro_id INT AUTO_INCREMENT,
   pro_ref VARCHAR(10)  NOT NULL,
   pro_name VARCHAR(200)  NOT NULL,
   pro_desc TEXT NOT NULL,
   pro_price DECIMAL(6,2)   NOT NULL,
   pro_stock SMALLINT,
   pro_color VARCHAR(30) ,
   pro_picture VARCHAR(40) ,
   pro_add_date DATE NOT NULL DEFAULT current_timestamp(),
   pro_update_date DATETIME NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
   pro_publish TINYINT NOT NULL,
   cat_id INT NOT NULL,
   sup_id INT NOT NULL,
   PRIMARY KEY(pro_id)
);

CREATE TABLE categories(
   cat_id INT AUTO_INCREMENT,
   cat_name VARCHAR(200)  NOT NULL,
   PRIMARY KEY(cat_id)
);

CREATE TABLE details(
   det_id INT AUTO_INCREMENT,
   det_price DECIMAL(6,2)   NOT NULL,
   det_quantity INT NOT NULL,
   pro_id INT NOT NULL,
   ord_id INT NOT NULL , CHECK (`det_quantity` >=1 AND `det_quantity` <=100),
   PRIMARY KEY(det_id)
);

CREATE TABLE customers(
   cus_id INT,
   cus_lastname VARCHAR(50)  NOT NULL,
   cus_firstname VARCHAR(50)  NOT NULL,
   cus_address VARCHAR(150)  NOT NULL,
   cus_zipcode TINYINT NOT NULL,
   cus_city VARCHAR(50)  NOT NULL,
   cus_mail VARCHAR(75) ,
   cus_phone INT,
   PRIMARY KEY(cus_id)
);

CREATE TABLE orders(
   ord_id INT AUTO_INCREMENT,
   ord_order_date DATETIME NOT NULL DEFAULT current_timestamp(),
   ord_ship_date DATE,
   ord_bill_date DATE,
   ord_reception_date DATE,
   ord_status VARCHAR(25)  NOT NULL,
   cus_id INT,
   cus_id_1 INT NOT NULL,
   PRIMARY KEY(ord_id),
   FOREIGN KEY(cus_id_1) REFERENCES customers(cus_id)
);

CREATE TABLE fournit(
   sup_id INT,
   pro_id INT,
   PRIMARY KEY(sup_id, pro_id),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id)
);

CREATE TABLE appartient(
   pro_id INT,
   cat_id INT,
   PRIMARY KEY(pro_id, cat_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id),
   FOREIGN KEY(cat_id) REFERENCES categories(cat_id)
);

CREATE TABLE a(
   pro_id INT,
   det_id INT,
   PRIMARY KEY(pro_id, det_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id),
   FOREIGN KEY(det_id) REFERENCES details(det_id)
);

CREATE TABLE contient(
   det_id INT,
   ord_id INT,
   PRIMARY KEY(det_id, ord_id),
   FOREIGN KEY(det_id) REFERENCES details(det_id),
   FOREIGN KEY(ord_id) REFERENCES orders(ord_id)
);
