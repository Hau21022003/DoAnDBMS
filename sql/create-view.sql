﻿
USE HotelManagementSystem;

-- 2.5.1. View khách hàng
-- View 1: Xem thông tin danh sách khách hàng
-- Sửa lại view khách hàng (có join với bảng số điên thoại)
CREATE VIEW View_Customer AS
SELECT * 
FROM CUSTOMER;

-- View 2: Tạo view cho tên và ID của khách hàng
CREATE VIEW View_Customer_Name AS
SELECT customer_id, customer_name
FROM CUSTOMER;

-- View 3: Tạo view cho số điện thoại của khách hàng
CREATE VIEW View_Customer_Phone AS
SELECT CUSTOMER.customer_id, customer_name, phone_number
FROM CUSTOMER
JOIN PHONE_NUMBER_OF_CUSTOMER ON CUSTOMER.customer_id = PHONE_NUMBER_OF_CUSTOMER.customer_id;

-- View 4: Xem thông tin danh sách khách hàng chính thức
CREATE VIEW View_Official_Customer AS
SELECT * 
FROM CUSTOMER
WHERE status = 1;

-- View 5: Xem thông tin danh sách khách hàng không chính thức
CREATE VIEW View_Non_Official_Customer AS
SELECT * 
FROM CUSTOMER
WHERE status = 0;

-- 2.5.2. View hóa đơn
-- View 6: Xem danh sách hóa đơn
CREATE VIEW View_Bill AS 
SELECT bill_id, costs_incurred, content_incurred, total_cost, created_date, payment_method, paytime, BILL.booking_record_id, CUSTOMER.customer_name, EMPLOYEE.employee_id,EMPLOYEE.employee_name  
FROM BILL
JOIN EMPLOYEE ON BILL.employee_id = EMPLOYEE.employee_id
JOIN BOOKING_RECORD ON BILL.booking_record_id = BOOKING_RECORD.booking_record_id
JOIN CUSTOMER ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id

-- View 7: Xem danh sách hóa đơn chưa thanh toán
CREATE VIEW View_Unpaid_Bill AS
SELECT bill_id, costs_incurred, content_incurred, total_cost, created_date, payment_method, paytime, BILL.booking_record_id, CUSTOMER.customer_name, EMPLOYEE.employee_id, EMPLOYEE.employee_name  
FROM BILL
JOIN EMPLOYEE ON BILL.employee_id = EMPLOYEE.employee_id
JOIN BOOKING_RECORD ON BILL.booking_record_id = BOOKING_RECORD.booking_record_id
JOIN CUSTOMER ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id
WHERE paytime IS NULL;

-- View 8: Xem danh sách hóa đơn đã thanh toán
CREATE VIEW View_Paid_Bill AS
SELECT bill_id, costs_incurred, content_incurred, total_cost, created_date, payment_method, paytime, BILL.booking_record_id, CUSTOMER.customer_name, EMPLOYEE.employee_id, EMPLOYEE.employee_name  
FROM BILL
JOIN EMPLOYEE ON BILL.employee_id = EMPLOYEE.employee_id
JOIN BOOKING_RECORD ON BILL.booking_record_id = BOOKING_RECORD.booking_record_id
JOIN CUSTOMER ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id
WHERE paytime IS NOT NULL;

-- 2.5.3. View phòng, loại phòng
-- View 9: Xem danh sách phòng
CREATE VIEW View_Room AS
SELECT
    ROOM.room_id,
    ROOM.room_name,
    ROOM.room_capacity,
    ROOM.room_status,
    ROOM.room_description,
    ROOM.room_image,
    ROOM.room_update,
    ROOM_TYPE.room_type_name,
    ROOM.room_type_id
FROM
    (ROOM INNER JOIN ROOM_TYPE
    ON ROOM.room_type_id = ROOM_TYPE.room_type_id);


--View bổ sung Room_type

CREATE VIEW View_Room_Type AS
SELECT *
FROM ROOM_TYPE

-- View 10: Tạo view cho tên và ID của phòng
CREATE VIEW View_Room_Name AS
SELECT room_id, room_name
FROM ROOM;

-- 2.5.4. View hồ sơ đặt phòng
-- View 11: Xem danh sách hồ sơ đặt phòng
CREATE VIEW View_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id;

-- View 12: Xem danh sách hồ sơ đặt phòng đã check-in
CREATE VIEW View_Confirmed_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id
WHERE BOOKING_RECORD.status = 'Confirmed';

-- View 13: Xem danh sách hồ sơ đặt phòng chưa check-in
CREATE VIEW View_Pending_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id
WHERE BOOKING_RECORD.status = 'Pending';

-- View 14: Xem danh sách hồ sơ đặt phòng đã bị hủy
CREATE VIEW View_Canceled_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id
WHERE BOOKING_RECORD.status = 'Canceled';

-- View 15: Xem danh sách hồ sơ đặt phòng đã đặt cọc
CREATE VIEW View_Deposit_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id
WHERE BOOKING_RECORD.deposit != 0;

-- View 16: Xem danh sách hồ sơ đặt phòng chưa đặt cọc
CREATE VIEW View_No_Deposit_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
    BOOKING_RECORD.booking_time,
    BOOKING_RECORD.expected_checkin_date,
    BOOKING_RECORD.expected_checkout_date,
    BOOKING_RECORD.actual_checkin_date,
    BOOKING_RECORD.actual_checkout_date,
    BOOKING_RECORD.deposit,
    BOOKING_RECORD.surcharge,
    BOOKING_RECORD.note,
    BOOKING_RECORD.status,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
    ROOM.room_name
FROM
    (BOOKING_RECORD INNER JOIN CUSTOMER
    ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id)
    INNER JOIN ROOM
    ON BOOKING_RECORD.room_id = ROOM.room_id
WHERE BOOKING_RECORD.deposit = 0;

-- View 17: Tạo view cho tên và ID của khách hàng trong hồ sơ đặt phòng
CREATE VIEW View_Customer_Of_Booking_Record AS
SELECT
    BOOKING_RECORD.booking_record_id,
	ROOM.room_id,
    ROOM.room_name,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name
FROM
    CUSTOMER_OF_BOOKING_RECORD
    JOIN BOOKING_RECORD ON BOOKING_RECORD.booking_record_id = CUSTOMER_OF_BOOKING_RECORD.booking_record_id
    JOIN ROOM ON BOOKING_RECORD.room_id = ROOM.room_id
    JOIN CUSTOMER ON CUSTOMER_OF_BOOKING_RECORD.customer_id = CUSTOMER.customer_id;

-- 2.5.5. View dịch vụ
-- View 18: Xem danh sách các dịch vụ
CREATE VIEW View_Service AS 
SELECT *
FROM SERVICE_ROOM;


--VIEW bổ sung
CREATE VIEW View_Service_Name AS
SELECT service_room_id, service_room_name
FROM SERVICE_ROOM

-- View 19: Tạo view cho tên và số điện thoại của khách hàng sử dụng dịch vụ
CREATE VIEW View_Customer_Service AS
SELECT CUSTOMER.customer_id, CUSTOMER.customer_name, phone_number
FROM CUSTOMER
JOIN PHONE_NUMBER_OF_CUSTOMER ON CUSTOMER.customer_id = PHONE_NUMBER_OF_CUSTOMER.customer_id;

-- View 20: Xem danh sách mẫu thông tin sử dụng dịch vụ
CREATE VIEW View_Service_Usage_Info AS   
SELECT
    SERVICE_USAGE_INFOR.service_usage_infor_id,
    SERVICE_USAGE_INFOR.number_of_service,
    SERVICE_USAGE_INFOR.date_used,
    SERVICE_USAGE_INFOR.total_fee,
	SERVICE_USAGE_INFOR.booking_record_id,
	CUSTOMER.customer_id,
    CUSTOMER.customer_name,
	ROOM.room_id,
	ROOM.room_name,
	SERVICE_ROOM.service_room_id,
    SERVICE_ROOM.service_room_name
FROM
    SERVICE_USAGE_INFOR
    JOIN SERVICE_ROOM ON SERVICE_ROOM.service_room_id = SERVICE_USAGE_INFOR.service_room_id
    JOIN BOOKING_RECORD ON BOOKING_RECORD.booking_record_id = SERVICE_USAGE_INFOR.booking_record_id 
    JOIN CUSTOMER ON BOOKING_RECORD.representative_id = CUSTOMER.customer_id
	JOIN ROOM ON BOOKING_RECORD.room_id = ROOM.room_id;

-- 2.5.6. View nhân viên
-- View 21: Xem danh sách nhân viên lễ tân
CREATE VIEW View_Front_Desk_Employee AS
SELECT *
FROM EMPLOYEE;

-- View 22: Tạo view cho tên và ID của nhân viên
CREATE VIEW View_Employee_Name AS
SELECT employee_id, employee_name
FROM EMPLOYEE;

-- 2.5.7. View tài khoản
-- View 23: Xem danh sách thông tin tài khoản của nhân viên lễ tân
CREATE VIEW View_Front_Desk_Account AS
SELECT
    ACCOUNT.account_id,
    ACCOUNT.username,
    ACCOUNT.password,
	EMPLOYEE.employee_id,
    EMPLOYEE.employee_name
FROM
    (ACCOUNT INNER JOIN EMPLOYEE
    ON ACCOUNT.employee_id = EMPLOYEE.employee_id);

-- View 24: Tạo view cho tên và số điện thoại của khách hàng
CREATE VIEW View_Employee_Phone AS
SELECT EMPLOYEE.employee_id, employee_name, phone_number
FROM EMPLOYEE
JOIN PHONE_NUMBER_OF_EMPLOYEE ON EMPLOYEE.employee_id= PHONE_NUMBER_OF_EMPLOYEE.employee_id;
