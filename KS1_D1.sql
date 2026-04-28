CREATE DATABASE dtb_KS1_D1;
USE dtb_KS1_D1;


CREATE TABLE Product (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    product_brand VARCHAR(100),
    quantity INT NOT NULL,
    rental_price DECIMAL(15,2) DEFAULT 0
);


CREATE TABLE Customer (
    customer_ID VARCHAR(20) PRIMARY KEY,
    customer_FullName VARCHAR(100) NOT NULL,
    customer_Email VARCHAR(100),
    customer_Address VARCHAR(255),
    phone_number CHAR(11)
);


CREATE TABLE Orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_price DECIMAL(15,2) DEFAULT 0,
    customer_ID VARCHAR(20),
    CONSTRAINT fk_customer FOREIGN KEY(customer_ID) REFERENCES Customer(customer_ID)
);


CREATE TABLE Order_detail (
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT NOT NULL,
    rental_price DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

ALTER TABLE Orders ADD GhiChu VARCHAR(150);
ALTER TABLE Product RENAME COLUMN product_brand TO NhaSanXuat;


INSERT INTO Product VALUES 
('P001','Macbook','Apple',10,45000000),
('P002','Iphone 15','Apple',29,32000000),
('P003','Card RTX 5060','Nvidia',9,8500000),
('P004','Màn hình Oled','Samsung',5,12000000),
('P005','Bàn phím cơ Akko','Akko',7,1500000);

INSERT INTO Customer VALUES
('C001','Tran Thi B','B@gmail.com','Ha Noi','0123456789'), 
('C002','Nguyen Van A','A@gmail.com','Ha Noi','0432156789'),
('C003','Ngoc Man Nhi','N@gmail.com','Ha Noi','0123459876'),
('C004','Nguyen Huy','H@gmail.com','TP.HCM','0123465789'),
('C005','Dao Kim Cuong','C@gmail.com','TP.HCM',NULL);

INSERT INTO Orders (order_id, order_date, order_price, customer_ID) VALUES 
('DH001','2026-04-20',77000000,'C001'),
('DH002','2026-03-21',12000000,'C002'),
('DH003','2026-04-29',8500000,'C004'),
('DH004','2026-01-24',1500000,'C005'),
('DH005','2026-04-20',32000000,'C001');

INSERT INTO Order_detail VALUES 
('DH001','P001',1,45000000),
('DH001','P002',1,32000000),
('DH002','P004',1,12000000),
('DH003','P003',1,8500000),
('DH004','P005',1,1500000);


UPDATE Product 
SET rental_price = rental_price * 1.1 
WHERE NhaSanXuat = 'Apple';


DELETE FROM Customer WHERE phone_number IS NULL;


SELECT * FROM Product WHERE rental_price BETWEEN 10000000 AND 20000000;

SELECT * FROM Order_detail WHERE order_id = 'DH001';

SELECT o.order_id, o.order_date 
FROM Orders o 
INNER JOIN Customer c ON o.customer_ID = c.customer_ID
WHERE c.customer_Address LIKE N'%TP.HCM%';