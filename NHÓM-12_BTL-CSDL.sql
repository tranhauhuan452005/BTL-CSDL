-- Tạo cơ sở dữ liệu LaundryService
CREATE DATABASE LaundryService;
GO

-- Sử dụng cơ sở dữ liệu LaundryService
USE LaundryService;
GO

-- Bảng Customers (Khách hàng)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(100) NOT NULL, 
    phone BIGINT UNIQUE NOT NULL,  
    email VARCHAR(255) UNIQUE,     
    address TEXT NOT NULL          
);

-- Bảng Orders (Đơn hàng)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'cancelled')),
    total_price DECIMAL(10,2) DEFAULT 0 CHECK (total_price >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Bảng Services (Dịch vụ)
CREATE TABLE Services (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    price_per_kg DECIMAL(10,2) NOT NULL CHECK (price_per_kg >= 0),
    description TEXT
);

-- Bảng Order_Details (Chi tiết đơn hàng)
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    service_id INT,
    weight_kg DECIMAL(5,2) CHECK (weight_kg > 0) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Bảng Payments (Thanh toán)
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('cash', 'credit_card', 'e-wallet')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Bảng Employees (Nhân viên)
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'staff', 'delivery'))
);

-- Bảng Deliveries (Giao hàng)
CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    employee_id INT,
    delivery_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'delivered', 'failed')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
-- Chèn dữ liệu vào bảng Customers
INSERT INTO Customers (name, phone, email, address) VALUES
('Nguyen Van A', '0987654321', 'nguyenvana@gmail.com', 'Ha Noi'),
('Tran Thi B', '0976543210', 'tranthib@gmail.com', 'Ho Chi Minh'),
('Le Van C', '0965432109', 'levanc@gmail.com', 'Da Nang'),
('Pham Minh D', '0954321098', 'phamminhd@gmail.com', 'Hai Phong'),
('Hoang Thi E', '0943210987', 'hoangthie@gmail.com', 'Can Tho'),
('Do Quoc F', '0932109876', 'doquocf@gmail.com', 'Binh Duong'),
('Bui Thanh G', '0921098765', 'buithanhg@gmail.com', 'Quang Ninh'),
('Ngo Van H', '0910987654', 'ngovanh@gmail.com', 'Nghe An'),
('Duong Thi I', '0909876543', 'duongthii@gmail.com', 'Hue'),
('Ly Hai K', '0898765432', 'lyhaik@gmail.com', 'Thanh Hoa'),
('Vu Van L', '0887654321', 'vuvanl@gmail.com', 'Vinh Long'),
('Ta Minh M', '0876543210', 'taminhm@gmail.com', 'Dak Lak'),
('Phan Thanh N', '0865432109', 'phanthanhn@gmail.com', 'Phu Yen'),
('Cao Quoc O', '0854321098', 'caoquoco@gmail.com', 'Bac Giang'),
('Luong Huu P', '0843210987', 'luonghuup@gmail.com', 'Lam Dong');

--Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (customer_id, status, total_price) VALUES
(1, 'pending', 150000),
(2, 'completed', 250000),
(3, 'processing', 180000),
(4, 'cancelled', 0),
(5, 'completed', 300000),
(6, 'pending', 120000),
(7, 'processing', 200000),
(8, 'completed', 270000),
(9, 'pending', 90000),
(10, 'completed', 310000),
(11, 'processing', 230000),
(12, 'cancelled', 0),
(13, 'pending', 40000),
(14, 'completed', 450000),
(15, 'processing', 60000);

--  Chèn dữ liệu vào bảng Service
INSERT INTO Services (name, price_per_kg, description) VALUES
('Giat thuong', 20000, 'Giat và say kho'),
('Giat hap', 50000, 'Giat bang cong nghe hap hoi'),
('Giat trang', 25000, 'Tay trang quan ao'),
('Giat đo len', 40000, 'Cham soc đac biet cho len'),
('Giat đo long vu', 60000, 'Danh rieng cho ao long vu'),
('Giat nhanh', 70000, 'Hoan thanh trong 1 gio'),
('Giat chan', 80000, 'Giat sach chan men lon'),
('Giat rem cua', 90000, 'Lam sach rem cua chuyen sau'),
('Giat tham', 150000, 'Dich vu giat tham cao cap'),
('Giat giay', 50000, 'Ve sinh giay dep'),
('Giat thu bong', 30000, 'Giat sach gau bong, thu nhoi bong'),
('Giat đo da', 100000, 'Bao duong do da cao cap'),
('Giat sofa', 200000, 'Ve sinh sofa tai nha'),
('Giat nem', 250000, 'Dich vu giat nem chuyen nghiep'),
('Giat vali', 70000, 'Lam sach vali du lich');

 --Chèn dữ liệu vào bảng Order_Details
 INSERT INTO Order_Details (order_id, service_id, weight_kg, subtotal) VALUES
(1, 1, 5, 100000),
(2, 2, 2, 100000),
(3, 3, 4, 100000),
(4, 4, 1, 40000),
(5, 5, 3, 180000),
(6, 6, 1, 70000),
	(7, 7, 2, 160000),
(8, 8, 3, 270000),
(9, 9, 1, 150000),
(10, 10, 3, 150000),
(11, 11, 4, 120000),
(12, 12, 2, 200000),
(13, 13, 1, 200000),
(14, 14, 2, 500000),
(15, 15, 1, 70000);

--Chèn dữ liệu vào bảng Payments
INSERT INTO Payments (order_id, amount, payment_method) VALUES
(1, 150000, 'cash'),
(2, 250000, 'credit_card'),
(3, 180000, 'e-wallet'),
(4, 0, 'cash'),
(5, 300000, 'credit_card'),
(6, 120000, 'e-wallet'),
(7, 200000, 'cash'),
(8, 270000, 'credit_card'),
(9, 90000, 'e-wallet'),
(10, 310000, 'cash'),
(11, 230000, 'credit_card'),
(12, 0, 'cash'),
(13, 40000, 'e-wallet'),
(14, 450000, 'credit_card'),
(15, 60000, 'cash');

-- Chèn dữ liệu vào bảng Employees
INSERT INTO Employees (name, phone, role) VALUES
('Nguyen Van An', '0912345678', 'admin'),
('Tran Thi Binh', '0923456789', 'staff'),
('Le Van Cuong', '0934567890', 'staff'),
('Pham Minh Duc', '0945678901', 'delivery'),
('Hoang Thi Duyen', '0956789012', 'delivery'),
('Đo Quoc Hung', '0967890123', 'staff'),
('Bui Thanh Hai', '0978901234', 'delivery'),
('Ngo Van Hoa', '0989012345', 'admin'),
('Duong Thi Lan', '0990123456', 'staff'),
('Ly Hai Nam', '0901234567', 'delivery'),
('Vu Van Khoa', '0892345678', 'staff'),
('Ta Minh Lam', '0883456789', 'delivery'),
('Phan Thanh Tung', '0874567890', 'staff'),
('Cao Quoc Phong', '0865678901', 'delivery'),
('Luong Huu Hau', '0856789012', 'staff');

-- Chèn dữ liệu vào bảng Deliveries
INSERT INTO Deliveries (order_id, employee_id, status) VALUES
(1, 4, 'delivered'),
(2, 5, 'delivered'),
(3, 7, 'failed'),
(4, 10, 'pending'),
(5, 12, 'delivered'),
(6, 14, 'failed'),
(7, 3, 'pending'),
(8, 5, 'delivered'),
(9, 7, 'pending'),
(10, 9, 'delivered'),
(11, 10, 'failed'),
(12, 12, 'pending'),
(13, 14, 'delivered'),
(14, 1, 'pending'),
(15, 3, 'delivered');
-- Xây dựng các VIEW
-- Danh sách khách hàng và số lượng đơn hàng đã đặt
CREATE VIEW CustomerOrders AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Tổng doanh thu từ mỗi dịch vụ
CREATE VIEW ServiceRevenue AS
SELECT s.service_id, s.name, SUM(od.subtotal) AS total_revenue
FROM Services s
JOIN Order_Details od ON s.service_id = od.service_id
GROUP BY s.service_id, s.name;

-- Chi tiết đơn hàng với thông tin khách hàng
CREATE VIEW OrderDetailsView AS
SELECT o.order_id, o.order_date, o.status, o.total_price,
       c.name AS customer_name, c.phone AS customer_phone
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Danh sách đơn hàng chưa hoàn thành
CREATE VIEW PendingOrders AS
SELECT order_id, customer_id, order_date, status
FROM Orders
WHERE status IN ('pending', 'processing');

-- Lịch sử thanh toán theo đơn hàng
CREATE VIEW PaymentHistory AS
SELECT p.payment_id, p.order_id, p.payment_date, p.amount, p.payment_method, o.customer_id
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id;

-- Tổng doanh thu theo từng khách hàng
CREATE VIEW CustomerRevenue AS
SELECT c.customer_id, c.name, SUM(o.total_price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Đơn hàng và trạng thái giao hàng
CREATE VIEW OrderDeliveryStatus AS
SELECT o.order_id, o.customer_id, d.employee_id, d.status AS delivery_status, d.delivery_date
FROM Orders o
LEFT JOIN Deliveries d ON o.order_id = d.order_id;

-- Nhân viên và số lần giao hàng
CREATE VIEW EmployeeDeliveries AS
SELECT e.employee_id, e.name, COUNT(d.delivery_id) AS total_deliveries
FROM Employees e
LEFT JOIN Deliveries d ON e.employee_id = d.employee_id
WHERE e.role = 'delivery'
GROUP BY e.employee_id, e.name;

-- Dịch vụ có tổng doanh thu cao nhất
CREATE VIEW TopService AS
SELECT TOP 1 s.service_id, s.name, SUM(od.subtotal) AS revenue
FROM Services s
JOIN Order_Details od ON s.service_id = od.service_id
GROUP BY s.service_id, s.name
ORDER BY revenue DESC;

-- Tổng số đơn hàng theo trạng thái
CREATE VIEW OrderStatusCount AS
SELECT status, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY status;

--Xây dựng các Procedure
-- Thêm khách hàng mới
CREATE PROCEDURE AddCustomer
    @name VARCHAR(100),
    @phone BIGINT,
    @email VARCHAR(255),
    @address TEXT
AS
BEGIN
    INSERT INTO Customers (name, phone, email, address)
    VALUES (@name, @phone, @email, @address);
END;

-- Cập nhật thông tin khách hàng
CREATE PROCEDURE UpdateCustomer
    @customer_id INT,
    @name VARCHAR(100),
    @phone BIGINT,
    @email VARCHAR(255),
    @address TEXT
AS
BEGIN
    UPDATE Customers
    SET name = @name, phone = @phone, email = @email, address = @address
    WHERE customer_id = @customer_id;
END;

-- Xóa khách hàng
CREATE PROCEDURE DeleteCustomer
    @customer_id INT
AS
BEGIN
    DELETE FROM Customers WHERE customer_id = @customer_id;
END;

-- Thêm đơn hàng mới
CREATE PROCEDURE AddOrder
    @customer_id INT,
    @total_price DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Orders (customer_id, total_price)
    VALUES (@customer_id, @total_price);
END;

-- Cập nhật trạng thái đơn hàng
CREATE PROCEDURE UpdateOrderStatus
    @order_id INT,
    @status VARCHAR(20)
AS
BEGIN
    UPDATE Orders
    SET status = @status
    WHERE order_id = @order_id;
END;

-- Lấy danh sách đơn hàng theo khách hàng
CREATE PROCEDURE GetOrdersByCustomer
    @customer_id INT
AS
BEGIN
    SELECT * FROM Orders WHERE customer_id = @customer_id;
END;

-- Thêm dịch vụ mới
CREATE PROCEDURE AddService
    @name VARCHAR(100),
    @price_per_kg DECIMAL(10,2),
    @description TEXT
AS
BEGIN
    INSERT INTO Services (name, price_per_kg, description)
    VALUES (@name, @price_per_kg, @description);
END;

-- Cập nhật thông tin dịch vụ
CREATE PROCEDURE UpdateService
    @service_id INT,
    @name VARCHAR(100),
    @price_per_kg DECIMAL(10,2),
    @description TEXT
AS
BEGIN
    UPDATE Services
    SET name = @name, price_per_kg = @price_per_kg, description = @description
    WHERE service_id = @service_id;
END;

-- Xóa dịch vụ
CREATE PROCEDURE DeleteService
    @service_id INT
AS
BEGIN
    DELETE FROM Services WHERE service_id = @service_id;
END;

-- Lấy danh sách tất cả dịch vụ
CREATE PROCEDURE GetAllServices
AS
BEGIN
    SELECT * FROM Services;
END;
-- Thêm khách hàng mới
EXEC AddCustomer @name = 'Nguyen Van A', @phone = 123456789, @email = 'a@gmail.com', @address = 'Hanoi';

-- Xem danh sách khách hàng
SELECT * FROM Customers;

-- Thêm đơn hàng mới
EXEC AddOrder @customer_id = 1, @total_price = 500.00;

-- Lấy danh sách đơn hàng theo khách hàng
EXEC GetOrdersByCustomer @customer_id = 1;

-- Thêm dịch vụ mới
EXEC AddService @name = 'Giat kho', @price_per_kg = 10.50, @description = 'Dich vu giat kho cao cap';

-- Lấy tất cả dịch vụ
EXEC GetAllServices;

--Xây dựng các Trigger 
-- Tự động cập nhật tổng giá trị đơn hàng khi có dịch vụ được thêm vào
CREATE TRIGGER trg_UpdateTotalPrice
ON Order_Details
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Orders
    SET total_price = (SELECT SUM(price) FROM OrderDetails WHERE order_id = i.order_id)
    FROM inserted i
    WHERE Orders.order_id = i.order_id;
END;

-- Không cho phép xóa khách hàng nếu có đơn hàng liên quan
CREATE TRIGGER trg_PreventCustomerDelete
ON Customers
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE customer_id IN (SELECT customer_id FROM deleted))
    BEGIN
        RAISERROR ('Không thể xóa khách hàng vì có đơn hàng liên quan.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Customers WHERE customer_id IN (SELECT customer_id FROM deleted);
    END
END;

-- Cập nhật trạng thái đơn hàng khi tất cả dịch vụ trong đơn đã hoàn thành
CREATE TRIGGER trg_UpdateOrderStatus
ON Order_Details
AFTER UPDATE
AS
BEGIN
    UPDATE Orders
    SET status = 'completed'
    WHERE order_id IN (SELECT order_id FROM inserted)
    AND NOT EXISTS (SELECT 1 FROM OrderDetails WHERE order_id = inserted.order_id AND status != 'completed');
END;

-- Tạo bản ghi log khi có khách hàng mới
CREATE TRIGGER trg_LogNewCustomer
ON Customers
AFTER INSERT
AS
BEGIN
    INSERT INTO Logs (log_message, log_date)
    SELECT 'Khách hàng mới: ' + name, GETDATE() FROM inserted;
END;

-- Tạo bản ghi log khi xóa dịch vụ
CREATE TRIGGER trg_LogDeleteService
ON Services
AFTER DELETE
AS
BEGIN
    INSERT INTO Logs (log_message, log_date)
    SELECT 'Xóa dịch vụ: ' + name, GETDATE() FROM deleted;
END;

-- Không cho phép đặt hàng với giá trị âm
CREATE TRIGGER trg_PreventNegativeOrder
ON Orders
AFTER INSERT, UPDATE  -- Sửa 'BEFORE' thành 'AFTER'
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE total_price < 0)
    BEGIN
        RAISERROR ('Giá trị đơn hàng không thể âm.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- Tự động đặt trạng thái đơn hàng thành 'processing' khi có dịch vụ đầu tiên được thêm vào
CREATE TRIGGER trg_AutoProcessingOrder
ON Order_Details
AFTER INSERT
AS
BEGIN
    UPDATE Orders
    SET status = 'processing'
    WHERE order_id IN (SELECT order_id FROM inserted) AND status = 'pending';
END;

-- Không cho phép cập nhật giá dịch vụ nếu có đơn hàng sử dụng dịch vụ đó
CREATE TRIGGER trg_PreventServicePriceUpdate
ON Services
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM OrderDetails WHERE service_id IN (SELECT service_id FROM inserted))
    BEGIN
        RAISERROR ('Không thể cập nhật giá dịch vụ do đã có đơn hàng sử dụng.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        UPDATE Services
        SET name = inserted.name, price_per_kg = inserted.price_per_kg
        FROM inserted
        WHERE Services.service_id = inserted.service_id;
    END
END;

-- Tạo bản ghi log khi cập nhật trạng thái đơn hàng
CREATE TRIGGER trg_LogOrderStatusChange
ON Orders
AFTER UPDATE
AS
BEGIN
    INSERT INTO Logs (log_message, log_date)
    SELECT 'Cập nhật trạng thái đơn hàng: ' + CAST(order_id AS VARCHAR) + ' -> ' + status, GETDATE()
    FROM inserted;
END;

-- Tự động cập nhật số lượng đơn hàng của khách hàng
SELECT Customers.customer_id, Customers.name, COUNT(Orders.order_id) AS order_count
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.customer_id, Customers.name;

--Xây dựng câu lệnh phân quyền cấp đối tượng 
-- Tạo người dùng mới
CREATE LOGIN laundry_admin WITH PASSWORD = 'SecurePass123';
CREATE LOGIN laundry_staff WITH PASSWORD = 'StaffPass123';
CREATE LOGIN laundry_customer WITH PASSWORD = 'CustomerPass123';

-- Tạo người dùng trong cơ sở dữ liệu
USE LaundryService;
CREATE USER laundry_admin FOR LOGIN laundry_admin;
CREATE USER laundry_staff FOR LOGIN laundry_staff;
CREATE USER laundry_customer FOR LOGIN laundry_customer;

-- Cấp quyền cho admin (quản trị viên toàn quyền)
GRANT CONTROL ON DATABASE::LaundryService TO laundry_admin;

-- Cấp quyền cho nhân viên (chỉ quản lý đơn hàng và khách hàng)
GRANT SELECT, INSERT, UPDATE, DELETE ON Customers TO laundry_staff;
GRANT SELECT, INSERT, UPDATE, DELETE ON Orders TO laundry_staff;

-- Cấp quyền cho khách hàng (chỉ xem và đặt đơn hàng)
GRANT SELECT, INSERT ON Orders TO laundry_customer;
GRANT SELECT ON Services TO laundry_customer;

SELECT name FROM sys.sql_logins;


-- Chạy kết quả của các view (tùy chọn)
SELECT * FROM CustomerOrders;
SELECT * FROM ServiceRevenue;
SELECT * FROM OrderDetailsView;
SELECT * FROM PendingOrders;
SELECT * FROM PaymentHistory;
SELECT * FROM CustomerRevenue;
SELECT * FROM OrderDeliveryStatus;
SELECT * FROM EmployeeDeliveries;
SELECT * FROM TopService;
SELECT * FROM OrderStatusCount;
