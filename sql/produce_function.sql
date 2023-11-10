--có function gọi function
--CREATE FUNCTION func_tinhLuongNV(@thang INT, @nam INT) RETURNS TABLE
--AS RETURN (
--SELECT nv.MaNV,nv.HoNV,nv.TenNV ,nv.SoCa,
--(nv.SoCa*cv.Luong*4 + nv.Thuong*(cv.Luong*2)) +
--CASE WHEN dbo.func_tinhDoanhThuThang(@thang, @nam) > 100000000
--THEN dbo.func_tinhDoanhThuThang(@thang, @nam)*0.01
--ELSE 0
--END AS Luong
--FROM NhanVien nv
--INNER JOIN CongViec cv ON nv.MaCV = cv.MaCV
--)

--function return value
--CREATE FUNCTION [dbo].[SearchTenKHBySDT](@SDT nchar(11))
--RETURNS nvarchar(50)
--AS
--BEGIN
-- DECLARE @TenKH nvarchar(50);
-- SELECT @TenKH = TenKH FROM KhachHang WHERE SDT = @SDT;
-- RETURN @TenKH;
--END

--function return list
--CREATE FUNCTION [dbo].[func_getIngreListByString] (@string NVARCHAR(50))
--RETURNS @IngreList TABLE (MaNL VARCHAR(10), TenNL NVARCHAR(50), MaNCC 
--VARCHAR(10), SoLuong INT, DonVi NVARCHAR(10), TinhTrang NVARCHAR(10))
--AS
--BEGIN
-- INSERT INTO @IngreList
-- SELECT *
-- FROM dbo.NguyenLieu
-- WHERE CONCAT(MaNL, TenNL, MaNCC, DonVi, TinhTrang) LIKE N'%' + @string + '%'
-- RETURN
--END


--Trong đề tài phải áp dụng hết các loại hàm và thủ tục, nên có đa dạng mỗi loại 2 ba cái
--USE HotelManagementSystem;


--1. **Đặt phòng**
--Phần này chưa xong

--CREATE TABLE BOOKING_RECORD (
    

----Thêm hồ sơ đặt phòng

--CREATE or ALTER PROCEDURE proc_insertBookingRecord
--    @expected_checkin_date DATETIME,
--    @expected_checkout_date DATETIME,
--    @actual_checkin_date DATETIME,
--    @actual_checkout_date DATETIME,
--    @deposit FLOAT,
--    @surcharge FLOAT,
--    @note NVARCHAR(255),
--    @status NVARCHAR(25),
--    @customer_name NVARCHAR(50),
--    @gender NVARCHAR(10),
--    @email VARCHAR(255),
--    @birthday DATE,
--    @identify_card VARCHAR(25),
--    @address NVARCHAR(255),
--    @room_name NVARCHAR(25)
--AS
--BEGIN
--	DECLARE @room_id INT, @representative_id INT
--    BEGIN TRANSACTION;
--    BEGIN TRY
--		--Tìm room_id dựa vào room_name đã cung cấp
--		SELECT @room_id = room_id
--		FROM ROOM WHERE room_name = @room_name

--		--Khi thêm hồ sơ đặt phòng vào thì không có mã người đại diện mà chỉ có tên khách hàng thôi nên phải insert vô customer
--		-- Nếu khách hàng đã tồn tại trong danh sách khách hàng thì không insert
--		IF NOT EXISTS (SELECT 1 FROM CUSTOMER WHERE identify_card = @identify_card)
--		BEGIN
--			INSERT INTO CUSTOMER (customer_name, gender, email, birthday, identify_card, address) 
--			values (@customer_name, @gender, @email, @birthday, @identify_card, @address);
--			SELECT  TOP 1 @representative_id = customer_id FROM CUSTOMER ORDER BY customer_id DESC;
--		END
--		ELSE 
--		BEGIN
--			SELECT @representative_id = customer_id FROM CUSTOMER WHERE identify_card = @identify_card;
--		END

--        INSERT INTO BOOKING_RECORD(expected_checkin_date, expected_checkout_date, deposit,
--		surcharge, note, status, actual_checkin_date, actual_checkout_date, room_id, representative_id)
--        VALUES (@expected_checkin_date, @expected_checkout_date, @deposit,
--		@surcharge, @note, @status, @actual_checkin_date, @actual_checkout_date, @room_id, @representative_id);
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
	
--EXEC proc_insertBookingRecord
--    @expected_checkin_date = '2023-11-05',
--    @expected_checkout_date = '2023-11-10',
--    @actual_checkin_date = '2023-11-06',
--    @actual_checkout_date = '2023-11-09',
--    @deposit = 1000000,
--    @surcharge = 20000,
--    @note = N'Additional notes',
--    @status = N'Chờ xác nhận',
--    @customer_name = N'Nguyen Van T',
--    @gender = N'Nam',
--    @email = 'johndoe@gmail.com',
--    @birthday = '1990-01-01',
--    @identify_card = '012345678911',
--    @address = N'123 Main St',
--    @room_name = '105';

--select * from ROOM
--select * from CUSTOMER
--select * from BOOKING_RECORD

------Xóa hồ sơ đặt phòng (hủy đặt phòng) 

--CREATE or ALTER PROCEDURE proc_deleteBookingRecord
--    @booking_record_id INT
--AS
--BEGIN
--	DECLARE @room_id INT, @customer_id INT;
--    BEGIN TRANSACTION;
--    BEGIN TRY
--		--Chuyển trạng thái phòng thành rỗng
--		SELECT @room_id = room_id FROM BOOKING_RECORD
--		UPDATE ROOM SET room_status = N'Trống' WHERE room_id = @room_id;

--		--Xóa hồ sơ đặt phòng
--        UPDATE BOOKING_RECORD SET status = N'Đã hủy' WHERE booking_record_id = @booking_record_id;
--        COMMIT;

--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
 
-- exec proc_deleteBookingRecord @booking_record_id = 1;

---- --Cập nhật hồ sơ đặt phòng



--2. **Dịch vụ**

--Dịch vụ

----Thêm dịch vụ phòng
--CREATE or ALTER PROCEDURE proc_insertServiceRoom
--    @service_room_name NVARCHAR(50),
--    @service_room_price FLOAT,
--    @discount_service FLOAT
--AS
--BEGIN
--    BEGIN TRANSACTION;
--    BEGIN TRY
--        INSERT INTO SERVICE_ROOM (service_room_name, service_room_price, discount_service)
--        VALUES (@service_room_name, @service_room_price, @discount_service);
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;


--EXEC proc_InsertServiceRoom
--    @service_room_name = 'Example Room',
--    @service_room_price = 100000,
--    @discount_service = 0.1;


--SELECT * FROM SERVICE_ROOM;

------Xóa dịch vụ phòng

--CREATE or ALTER PROCEDURE proc_deleteServiceRoom
--    @service_room_id INT
--AS
--BEGIN
--    BEGIN TRANSACTION;
--    BEGIN TRY
--        DELETE FROM SERVICE_ROOM where SERVICE_ROOM.service_room_id = @service_room_id
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
 
-- exec proc_deleteServiceRoom @service_room_id = 1004;

-- SELECT * FROM SERVICE_ROOM;

---- --Cập nhật dịch vụ phòng
--CREATE or ALTER PROCEDURE proc_updateServiceRoom
--	@service_room_id INT,
--	@service_room_name NVARCHAR(50),
--	@service_room_status BIT,
--	@service_room_price FLOAT,
--	@discount_service FLOAT
--AS
--BEGIN
--BEGIN TRANSACTION;
--	BEGIN TRY
--		UPDATE SERVICE_ROOM
--		SET
--			service_room_name = @service_room_name,
--			service_room_status = @service_room_status,
--			service_room_price = @service_room_price,
--			discount_service = @discount_service
--		WHERE service_room_id = @service_room_id;
--		COMMIT;
--	END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;

--exec proc_updateServiceRoom 
--	@service_room_id = 1002,
--	@service_room_name = N'Vay đồ',
--	@service_room_status = 1,
--	@service_room_price = 32943243,
--	@discount_service = 3249333;

--Select * from SERVICE_ROOM;

------Tìm kiếm theo tên dịch vụ 
--Function trả về table không cần định dạng

--CREATE or ALTER FUNCTION func_searchByServiceName (@service_room_name NVARCHAR(50)) 
--RETURNS table
--AS 
--	RETURN ( SELECT * FROM View_Service WHERE service_room_name = @service_room_name);

--SELECT * FROM func_searchByServiceName(N'Giặt ủi, là');

---- Tìm kiếm dịch vụ trong khoảng giá

--CREATE OR ALTER FUNCTION func_searchInPriceRange(@service_room_price1 FLOAT, @service_room_price2 FLOAT)
--	RETURNS table
--AS RETURN ( SELECT * FROM View_Service WHERE service_room_price between @service_room_price1 and @service_room_price2)

--SELECT * FROM func_searchInPriceRange(10000, 15000);

--Mẫu thông tin sử dụng dịch vụ

--Thêm mẫu thông tin sử dụng dịch vụ

--CREATE or ALTER PROCEDURE proc_insertServiceUsageInfor
--	@number_of_service INT,
--	@total_fee FLOAT,
--	@customer_name NVARCHAR(50),
--	@room_name NVARCHAR(25),
--	@service_room_name NVARCHAR(50)
--AS
--BEGIN
--	DECLARE @booking_record_id INT, @service_room_id INT

--    BEGIN TRANSACTION;
--    BEGIN TRY
--		--Khi thêm mẫu thông tin sử dụng dịch vụ vào thì không có booking_record_id nên ta phải tìm
--		--dựa vào tên khách hàng và tên phòng
--		SELECT @booking_record_id = br.booking_record_id
--		FROM BOOKING_RECORD br JOIN CUSTOMER c ON br.representative_id = c.customer_id
--		JOIN ROOM r ON br.room_id = r.room_id
--		WHERE c.customer_name = @customer_name AND r.room_name = @room_name

--		--Tìm service_id dựa vào service_name cung cấp
--		SELECT @service_room_id = service_room_id
--		FROM SERVICE_ROOM WHERE service_room_name = @service_room_name

--        INSERT INTO SERVICE_USAGE_INFOR (number_of_service, total_fee, booking_record_id, service_room_id)
--        VALUES (@number_of_service, @total_fee, @booking_record_id, @service_room_id);
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
	
--EXEC proc_insertServiceUsageInfor
--	@number_of_service = 2,
--	@total_fee = 23241,
--	@customer_name = 'Nguyen Van A',
--	@room_name = '101',
--	@service_room_name = N'Giặt ủi, là'

------Xóa mẫu thông tin sử dụng dịch vụ
--select *from SERVICE_USAGE_INFOR
--CREATE or ALTER PROCEDURE proc_deleteServiceUsageInfor
--    @service_usage_infor_id INT
--AS
--BEGIN
--    BEGIN TRANSACTION;
--    BEGIN TRY
--        DELETE FROM SERVICE_USAGE_INFOR where SERVICE_USAGE_INFOR.service_usage_infor_id = @service_usage_infor_id
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
 
-- exec proc_deleteServiceUsageInfor @service_usage_infor_id = 1;

---- --Cập nhật mẫu thông tin sử dụng dịch vụ

--CREATE or ALTER PROCEDURE proc_updateServiceUsageInfor
--	@service_usage_infor_id INT,
--	@number_of_service INT,
--	@total_fee FLOAT,
--	@customer_name NVARCHAR(50),
--	@room_name NVARCHAR(25),
--	@service_room_name NVARCHAR(50)
--AS
--BEGIN
--	DECLARE @booking_record_id INT, @service_room_id INT
--	BEGIN TRANSACTION;
--	BEGIN TRY
--		--Khi thêm mẫu thông tin sử dụng dịch vụ vào thì không có booking_record_id nên ta phải tìm
--		--dựa vào tên khách hàng và tên phòng
--		SELECT @booking_record_id = br.booking_record_id
--		FROM BOOKING_RECORD br JOIN CUSTOMER c ON br.representative_id = c.customer_id
--		JOIN ROOM r ON br.room_id = r.room_id
--		WHERE c.customer_name = @customer_name AND r.room_name = @room_name

--		--Tìm service_id dựa vào service_name cung cấp
--		SELECT @service_room_id = service_room_id
--		FROM SERVICE_ROOM WHERE service_room_name = @service_room_name
--		UPDATE SERVICE_USAGE_INFOR
--		SET
--			number_of_service = @number_of_service,
--			total_fee = @total_fee, 
--			booking_record_id = @booking_record_id, 
--			service_room_id = @service_room_id
--		WHERE service_usage_infor_id = @service_usage_infor_id;
--		COMMIT;

--	END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;

--exec proc_updateServiceUsageInfor
--	@service_usage_infor_id = 2,
--	@number_of_service = 2,
--	@total_fee = 23241,
--	@customer_name = 'Nguyen Van A',
--	@room_name = '101',
--	@service_room_name = N'Giặt ủi, là'


--Select * from SERVICE_USAGE_INFOR;

------Tìm kiếm mẫu thông tin sử dụng dịch vụ 

--Function trả về table không cần định dạng
--1. Tìm kiếm những mẫu thông tin dịch vụ sử dụng trong tháng (1,2,..)
--CREATE or ALTER FUNCTION func_searchServiceUsageInforByMonth(@month INT)
--RETURNS table
--AS
--	RETURN ( SELECT * FROM View_Service_Usage_Info WHERE month(date_used) = @month);

--SELECT * FROM func_searchServiceUsageInforByMonth('11');
--Select * from View_Service_Usage_Info;
--Select * from SERVICE_USAGE_INFOR;

----2. Tìm kiếm những mẫu thông tin sử dịch vụ của khách hàng A
--CREATE or ALTER FUNCTION func_searchServiceUsageInforByCustomerName(@customer_name NVARCHAR(50))
--RETURNS table
--AS
--	RETURN ( SELECT * FROM View_Service_Usage_Info WHERE customer_name = @customer_name);

--SELECT * FROM func_searchServiceUsageInforByCustomerName('Nguyen Van A');
--Select * from View_Service_Usage_Info;
--Select * from SERVICE_USAGE_INFOR;

----3. Tìm kiếm những mẫu thông tin sử dịch vụ của khách hàng A, phòng B
--CREATE or ALTER FUNCTION func_searchServiceUsageInforByCustomerNameAndRoom(@customer_name NVARCHAR(50), @room_name NVARCHAR(25))
--RETURNS table
--AS
--	RETURN ( SELECT * FROM View_Service_Usage_Info WHERE customer_name = @customer_name AND room_name = @room_name);

--SELECT * FROM func_searchServiceUsageInforByCustomerNameAndRoom('Nguyen Van A', '101');
--Select * from View_Service_Usage_Info;
--Select * from SERVICE_USAGE_INFOR;

--3. **Nhân viên**
--4. **Tài khoản**

--5.Doanh thu:

----5.Doanh thu:

----CREATE OR ALTER FUNCTION f_Calculate_Revenue
----(@StartDay DATETIME, @EndDay DATETIME)
----RETURNS TABLE
----AS
----RETURN (SELECT MONTH(BILL.created_date) AS Month, YEAR(BILL.created_date) AS Year, SUM(BILL.total_cost) AS ToTal 
----		FROM BILL 
----		WHERE BILL.created_date IS NOT NULL AND BILL.created_date >= @StartDay AND BILL.created_date <= @EndDay
----		GROUP BY MONTH(BILL.created_date), YEAR(BILL.created_date));


----3. **Nhân viên**


----4. **Tài khoản**




----1. **Đặt phòng**
----Phần này chưa xong
----Thêm hồ sơ đặt phòng
-- select * from BOOKING_RECORD;
-- select * from View_Booking_Record
-- CREATE or ALTER PROCEDURE proc_insertBookingRecord
--     @expected_checkin_date DATETIME,
--     @expected_checkout_date DATETIME,
--     @actual_checkin_date DATETIME,
--     @actual_checkout_date DATETIME,
--     @deposit FLOAT,
--     @surcharge FLOAT,
--     @note NVARCHAR(255),
--     @status NVARCHAR(25),
--     @representative_name NVARCHAR(50),
--     @gender NVARCHAR(10),
--     @email VARCHAR(255),
--     @birthday DATE,
--     @identify_card VARCHAR(25),
--     @address NVARCHAR(255),
--     @room_id INT
-- AS
-- BEGIN
-- 	DECLARE @representative_id INT
--     BEGIN TRANSACTION;
--     BEGIN TRY
-- 		-- Khi thêm hồ sơ đặt phòng vào thì không có mã người đại diện mà chỉ có tên khách hàng thôi nên phải insert vô bảng customer
-- 		-- để có được mã người đại diện
-- 		-- Nếu khách hàng đã tồn tại trong danh sách khách hàng thì không insert
-- 		IF NOT EXISTS (SELECT 1 FROM CUSTOMER WHERE identify_card = @identify_card)
-- 		BEGIN
-- 			INSERT INTO CUSTOMER (customer_name, gender, email, birthday, identify_card, address) 
-- 			values (@representative_name, @gender, @email, @birthday, @identify_card, @address);
-- 			SELECT  TOP 1 @representative_id = customer_id FROM CUSTOMER ORDER BY customer_id DESC;
-- 		END
-- 		ELSE 
-- 		BEGIN
-- 			SELECT @representative_id = customer_id FROM CUSTOMER WHERE identify_card = @identify_card;
-- 		END

--         INSERT INTO BOOKING_RECORD(expected_checkin_date, expected_checkout_date, deposit,
-- 		surcharge, note, status, actual_checkin_date, actual_checkout_date, room_id, representative_id)
--         VALUES (@expected_checkin_date, @expected_checkout_date, @deposit,
-- 		@surcharge, @note, @status, @actual_checkin_date, @actual_checkout_date, @room_id, @representative_id);
--         COMMIT;
--     END TRY
--    	BEGIN CATCH
-- 		DECLARE @err NVARCHAR(MAX)
-- 		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
-- 		RAISERROR(@err, 16, 1)
-- 	END CATCH
-- END;
	
-- EXEC proc_insertBookingRecord
--     @expected_checkin_date = '2023-11-05',
--     @expected_checkout_date = '2023-11-10',
--     @actual_checkin_date = '2023-11-06',
--     @actual_checkout_date = '2023-11-09',
--     @deposit = 1000000,
--     @surcharge = 20000,
--     @note = N'Additional notes',
--     @status = N'Chờ xác nhận',
--     @representative_name = N'Nguyen Van Be Bas',
--     @gender = N'Nam',
--     @email = 'johndoe@gmail.com',
--     @birthday = '1990-01-01',
--     @identify_card = '012345678001',
--     @address = N'123 Main St',
--     @room_id = 5;

-- select * from ROOM

-- select * from CUSTOMER
-- select * from BOOKING_RECORD

------Xóa hồ sơ đặt phòng (hủy đặt phòng) 

--CREATE or ALTER PROCEDURE proc_deleteBookingRecord
--    @booking_record_id INT
--AS
--BEGIN
--	DECLARE @room_id INT, @customer_id INT;
--    BEGIN TRANSACTION;
--    BEGIN TRY
--		--Chuyển trạng thái phòng thành rỗng
--		SELECT @room_id = room_id FROM BOOKING_RECORD
--		UPDATE ROOM SET room_status = N'Trống' WHERE room_id = @room_id;

--		--Xóa hồ sơ đặt phòng
--        UPDATE BOOKING_RECORD SET status = N'Đã hủy' WHERE booking_record_id = @booking_record_id;
--        COMMIT;

--    END TRY
--   	BEGIN CATCH
--		DECLARE @err NVARCHAR(MAX)
--		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
--		RAISERROR(@err, 16, 1)
--	END CATCH
--END;
 
-- exec proc_deleteBookingRecord @booking_record_id = 1;

---- --Cập nhật hồ sơ đặt phòng


----2. **Khách hàng**

--2.1. **PROCEDURE**
---2.1.1. Add new customer information
-- CREATE PROCEDURE proc_add_customer
--    	@customer_name nvarchar(50),
--    	@gender nvarchar(10),
--    	@birthday date,
--    	@identify_card varchar(25),
--    	@phone_number varchar(15),
--    	@email varchar(255),
--    	@address nvarchar(255),
--    	@status bit
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--           	INSERT INTO
--    	 CUSTOMER(customer_name,gender,birthday,identify_card,email,address,status)
--           	VALUES
--    	 (@customer_name,@gender,@birthday,@identify_card,@email,@address,@status)
--           	DECLARE @id int
--           	SET @id = (SELECT TOP 1 CUSTOMER.customer_id FROM CUSTOMER ORDER BY CUSTOMER.customer_id DESC)
--           	INSERT INTO
--           	PHONE_NUMBER_OF_CUSTOMER(customer_id, phone_number)
--           	VALUES
--           	(@id, @phone_number)
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÁCH HÀNG ĐÃ TỒN TẠI', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_add_customer
--     @customer_name = 'Test name',
--    	@gender = N'Nữ',
--    	@birthday =  '2003-12-10',
--    	@identify_card = '723546235875',
--    	@phone_number = '0123456781',
--    	@email = 'test234@gmail.com',
--    	@address = 'aaaa',
--    	@status = 0

---2.1.2. Remove customer information
-- CREATE PROCEDURE proc_delete_customer
--    	@customer_id int
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--           	DELETE FROM PHONE_NUMBER_OF_CUSTOMER WHERE customer_id=@customer_id --Xoa tat ca sdt cua khach hang do--
--           	DELETE FROM CUSTOMER WHERE customer_id=@customer_id
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG XÓA ĐƯỢC KHÁCH HÀNG', 18, 1)
--    	END CATCH
-- END

-- exec proc_delete_customer @customer_id = 24

---2.1.3. Update customer information (If update phone number of customer, then update in PHONE_NUMBER_OF_CUSTOMER table too)
-- CREATE PROCEDURE proc_update_customer
--    	@customer_id int,
--    	@customer_name nvarchar(50),
--    	@gender nvarchar(10),
--    	@birthday date,
--    	@identify_card varchar(25),
--    	@phone_number varchar(15),
--    	@email varchar(255),
--    	@address nvarchar(255),
--    	@status bit
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--                   	-- Cập nhật thông tin số điện thoại trong bảng PHONE_NUMBER_OF_CUSTOMER --
--           	IF NOT EXISTS (SELECT 1 FROM PHONE_NUMBER_OF_CUSTOMER WHERE customer_id = @customer_id AND phone_number = @phone_number)
--           	BEGIN
--                   	-- Nếu không tồn tại, thực hiện cập nhật
--                   	UPDATE PHONE_NUMBER_OF_CUSTOMER
--                   	SET phone_number = @phone_number
--                   	WHERE customer_id = @customer_id
--           	END
 
--           	-- Cập nhật thông tin khách hàng trong bảng CUSTOMER --
--           	UPDATE CUSTOMER
--           	SET
--                   	customer_name = @customer_name,
--                   	gender = @gender,
--                   	birthday = @birthday,
--                   	identify_card = @identify_card,
--                   	email = @email,
--                   	address = @address,
--                   	status = @status
--           	WHERE CUSTOMER.customer_id = @customer_id
 
--           	COMMIT TRAN  -- Hoàn thành giao dịch cho cả hai lệnh UPDATE
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--              RAISERROR('KHÔNG CẬP NHẬT ĐƯỢC KHÁCH HÀNG', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_update_customer
--    	@customer_id = 1,
--    	@customer_name = 'heheaaa',
--    	@gender = N'Nam',
--    	@birthday =  '2003-12-11',
--    	@identify_card = '723546235875',
--    	@phone_number = '0123456123',
--    	@email = 'test1.2.3@gmail.com',
--    	@address = 'update ne',
--    	@status = 1

--2.2. **FUNCTION**
---2.2.1. Search customer information (NOT AVAILABLE)
-- CREATE FUNCTION func_search_customer(@string nvarchar(50))
-- RETURNS TABLE
-- AS
-- RETURN(
-- SELECT *
-- FROM CUSTOMER
-- WHERE CONCAT(customer_name,
-- 			gender,
-- 			identify_card,
-- 			email,
-- 			address,
-- 			(SELECT STRING_AGG(phone_number, ',') AS phone_numbers
-- 				FROM PHONE_NUMBER_OF_CUSTOMER 
-- 				WHERE customer_id = customer_id)
-- 			) LIKE '%' + @string + '%')

-- SELECT * FROM SEARCH_CUSTOMER('hehe')

--2.2.2. Search customer information by range of birthday
-- CREATE FUNCTION func_search_customer_by_dob
-- (@fromdate DateTime , @todate DateTime)
-- RETURNS TABLE
-- AS RETURN
-- (
-- SELECT *
-- FROM CUSTOMER
-- WHERE birthday BETWEEN @fromdate AND @todate)

-- SELECT * FROM func_search_customer_by_dob('1990-01-15', '2003-12-10')

--3. **HÓA ĐƠN**
---3.1. **PROCEDURE**
----3.1.1. Add new BILL (PENDING)
----3.1.2. Delete BILL
-- CREATE PROCEDURE proc_delete_bill
-- @bill_id VARCHAR(20)
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--           	DELETE FROM BILL WHERE bill_id = @bill_id
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG XÓA ĐƯỢC HÓA ĐƠN!', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_delete_bill @bill_id = 1

----3.1.2. Update BILL information
-- CREATE PROCEDURE proc_update_bill
-- @bill_id int,
-- @costs_incurred float,
-- @content_incurred NVARCHAR(255),
-- @total_cost float,
-- @payment_method NVARCHAR(15),
-- @pay_time DATETIME
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--           	UPDATE BILL
--           	SET
--           	costs_incurred = @costs_incurred,
--           	content_incurred = @content_incurred,
--           	total_cost = @total_cost,
--           	payment_method = @payment_method,
--           	paytime = @pay_time
--           	WHERE bill_id = @bill_id
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG CẬP NHẬT ĐƯỢC HÓA ĐƠN!', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_update_bill
-- @bill_id = 2,
-- @costs_incurred = 2,
-- @content_incurred = N'Hiiii',
-- @total_cost = 811111,
-- @payment_method = N'Tiền mặt',
-- @pay_time = '2023-11-21 11:00:00'

---3.2. **FUNCTION**
----3.2.1. Search BILL information (PENDING)
-- CREATE FUNCTION func_search_bill(@string nvarchar(50))
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT *
-- FROM BILL
-- WHERE CONCAT(content_incurred, payment_method) LIKE '%' + @string + '%'
-- )

-- SELECT * FROM func_search_bill(N'Tiền mặt')

----3.2.2. Search BILL information by customer id
-- CREATE FUNCTION func_search_bill_by_customer
-- (@customer_id int)
-- RETURNS TABLE
-- AS
-- RETURN
-- (
--  SELECT DISTINCT b.*
--  FROM BILL b
--  INNER JOIN BOOKING_RECORD br on b.booking_record_id = br.booking_record_id
--  WHERE br.representative_id = @customer_id
-- )

-- SELECT * FROM func_search_bill_by_customer(1)

----3.2.3. Search BILL information by pay time
-- CREATE FUNCTION func_search_bill_by_paydate
-- (@pay_time DateTime)
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT *
-- FROM BILL
-- WHERE DATEDIFF(day, convert(date, paytime), convert(date, @pay_time)) = 0
-- )

-- SELECT * FROM func_search_bill_by_paydate('2023-11-21 11:00:00')


----4. **PHÒNG**

--4.1. **PROCEDURE**
---4.1.1. Add new room information
-- CREATE PROCEDURE proc_add_room
-- @room_name NVARCHAR(25),
-- @room_capacity INT,
-- @room_status NVARCHAR(20),
-- @room_description NVARCHAR(255),
-- @room_image VARBINARY(MAX),
-- @room_type_id INT
-- AS
-- BEGIN
--    	BEGIN TRAN
--    	BEGIN TRY
--           	INSERT INTO ROOM (room_name, room_capacity, room_status, room_description, room_image, room_type_id)
--           	VALUES (@room_name, @room_capacity, @room_status, @room_description, @room_image, @room_type_id)
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG THÊM ĐƯỢC PHÒNG!', 18, 1);
--    	END CATCH
-- END;

-- EXEC proc_add_room
-- @room_name = '301',
-- @room_capacity = 2,
-- @room_status = N'Trống',
-- @room_description = N'Suite room with a view',
-- @room_image = null,
-- @room_type_id = 5

---4.1.2. Delete room information
-- CREATE PROCEDURE proc_delete_room
-- @room_id int
-- AS
-- BEGIN
--    	BEGIN TRANSACTION
--    	BEGIN TRY
--           	DELETE FROM ROOM WHERE room_id=@room_id
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG XÓA ĐƯỢC PHÒNG', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_delete_room
-- @room_id = 1

---4.1.3. Update room information
-- CREATE PROCEDURE proc_update_room
-- @room_id INT,
-- @room_name NVARCHAR(25),
-- @room_capacity INT,
-- @room_status NVARCHAR(20),
-- @room_description NVARCHAR(255),
-- @room_image VARBINARY(MAX),
-- @room_type_id INT
-- AS
-- BEGIN
-- BEGIN TRANSACTION
--    	BEGIN TRY
--           	UPDATE ROOM
--           	SET
--           	room_name = @room_name,
--           	room_capacity = @room_capacity,
--           	room_status = @room_status,
--           	room_description = @room_description,
--           	room_image = @room_image,
--           	room_type_id = @room_type_id
--           	WHERE room_id = @room_id
--           	COMMIT TRAN
--    	END TRY
--    	BEGIN CATCH
--           	ROLLBACK TRAN
--           	RAISERROR('KHÔNG CẬP NHẬT ĐƯỢC HÓA ĐƠN!', 18, 1)
--    	END CATCH
-- END

-- EXEC proc_update_room
-- @room_id = 1,
-- @room_name = '303',
-- @room_capacity = 4,
-- @room_status = N'Đang sửa',
-- @room_description = 'Family room with a view',
-- @room_image = null,
-- @room_type_id = 3

--4.2. **FUNCTION**
---4.2.1. Search room information
-- CREATE FUNCTION func_search_room(@string nvarchar(50))
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT *
-- FROM ROOM
-- WHERE CONCAT(convert(nvarchar(25),room_id), room_name, room_status, room_description) LIKE '%' + @string + '%'
-- )

-- SELECT * FROM func_search_room(N'Đang cho thuê')

---4.2.2. Search room information by room type
-- CREATE FUNCTION func_search_room_by_type(@string nvarchar(50))
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT ROOM.*
-- FROM ROOM INNER JOIN ROOM_TYPE ON ROOM.room_type_id = ROOM_TYPE.room_type_id
-- WHERE ROOM_TYPE.room_type_name LIKE '%' + @string + '%'
-- )

-- SELECT * FROM func_search_room_by_type(N'Superior')


----5. **LOẠI PHÒNG**

--5.1. **PROCEDURE**
---5.1.1. Add new room type information
-- CREATE PROCEDURE proc_add_room_type
-- @room_type_name NVARCHAR(25),
-- @price float,
-- @discount_room float
-- AS
-- BEGIN
-- 	BEGIN TRAN
-- 	BEGIN TRY
--        	INSERT INTO ROOM_TYPE(room_type_name, price, discount_room)
--        	VALUES (@room_type_name, @price, @discount_room)
--        	COMMIT TRAN
-- 	END TRY
-- 	BEGIN CATCH
--        	ROLLBACK
--        	RAISERROR('KHÔNG THỂ THÊM LOẠI PHÒNG MỚI!', 18, 1)
-- 	END CATCH
-- END

-- EXEC proc_add_room_type
-- @room_type_name = 'Family of 5',
-- @price = 3200000,
-- @discount_room = 0.2

---5.1.2. Delete room type information
-- CREATE PROCEDURE proc_delete_room_type
-- @room_type_id int
-- AS
-- BEGIN
-- 	BEGIN TRANSACTION
-- 	BEGIN TRY
--        	DELETE FROM ROOM_TYPE WHERE room_type_id=@room_type_id
--        	COMMIT TRAN
-- 	END TRY
-- 	BEGIN CATCH
--        	ROLLBACK TRAN
--        	RAISERROR('KHÔNG XÓA ĐƯỢC LOẠI PHÒNG!', 18, 1)
-- 	END CATCH
-- END

-- EXEC proc_delete_room_type
-- @room_type_id = 6

---5.1.3. Update room type information
-- CREATE PROCEDURE proc_delete_room_type
-- CREATE PROCEDURE proc_update_room_type
-- @room_type_id INT,
-- @room_type_name NVARCHAR(25),
-- @price FLOAT,
-- @discount_room FLOAT
-- AS
-- BEGIN
-- BEGIN TRANSACTION
-- 	BEGIN TRY
--        	UPDATE ROOM_TYPE
--        	SET
--        	room_type_name = @room_type_name,
--        	price = @price,
--        	discount_room = @discount_room
--        	WHERE room_type_id = @room_type_id
--        	COMMIT TRAN
-- 	END TRY
-- 	BEGIN CATCH
--        	ROLLBACK TRAN
--        	RAISERROR('KHÔNG CẬP NHẬT ĐƯỢC THÔNG TIN LOẠI PHÒNG!', 16, 1)
-- 	END CATCH
-- END

-- EXEC proc_update_room_type
-- @room_type_id = 7,
-- @room_type_name = 'Family of 6',
-- @price = 6655443,
-- @discount_room = 0.15

--5.2. **FUNCTION**
---5.2.1. Search room type information
-- CREATE FUNCTION func_search_room_type(@string nvarchar(50))
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT *
-- FROM ROOM_TYPE
-- WHERE CONCAT(convert(nvarchar(25),room_type_id), room_type_name, discount_room) LIKE '%' + @string + '%'
-- )

-- SELECT * FROM func_search_room_type(N'0.1')

---5.2.1. Search room type by price range
-- CREATE FUNCTION func_search_room_type_by_price
-- (@fromprice float,
-- @toprice float
-- )
-- RETURNS TABLE
-- AS
-- RETURN
-- (
-- SELECT *
-- FROM ROOM_TYPE
-- WHERE ROOM_TYPE.price >= @fromprice AND ROOM_TYPE.price <= @toprice
-- )

-- SELECT * FROM func_search_room_type_by_price(1, 400000)