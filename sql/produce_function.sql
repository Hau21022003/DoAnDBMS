
----function return value
----CREATE FUNCTION [dbo].[SearchTenKHBySDT](@SDT nchar(11))
----RETURNS nvarchar(50)
----AS
----BEGIN
---- DECLARE @TenKH nvarchar(50);
---- SELECT @TenKH = TenKH FROM KhachHang WHERE SDT = @SDT;
---- RETURN @TenKH;
----END

----function return list has custom đầu ra
----CREATE FUNCTION [dbo].[func_getIngreListByString] (@string NVARCHAR(50))
----RETURNS @IngreList TABLE (MaNL VARCHAR(10), TenNL NVARCHAR(50), MaNCC 
----VARCHAR(10), SoLuong INT, DonVi NVARCHAR(10), TinhTrang NVARCHAR(10))
----AS
----BEGIN
---- INSERT INTO @IngreList
---- SELECT *
---- FROM dbo.NguyenLieu
---- WHERE CONCAT(MaNL, TenNL, MaNCC, DonVi, TinhTrang) LIKE N'%' + @string + '%'
---- RETURN
----END


----Trong đề tài phải áp dụng hết các loại hàm và thủ tục, nên có đa dạng mỗi loại 2 ba cái


----USE HotelManagementSystem;

----2. **Dịch vụ**

----Dịch vụ

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
 
-- exec proc_deleteServiceRoom @service_room_id = 6;

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
----Function trả về table không custom đầu ra

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

----Mẫu thông tin sử dụng dịch vụ

----Thêm mẫu thông tin sử dụng dịch vụ


--CREATE or ALTER PROCEDURE proc_insertServiceUsageInfor
--	@number_of_service INT,
--	@total_fee FLOAT,
--	@booking_record_id INT,
--	@service_room_id INT
--AS
--BEGIN
--    BEGIN TRANSACTION;
--    BEGIN TRY
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
	
--exec proc_insertServiceUsageInfor
--	@number_of_service = 2,
--	@total_fee = 23241,
--	@booking_record_id = 1,
--	@service_room_id = 2

--select * from View_Service_Usage_Info;

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
--	@booking_record_id INT,
--	@service_room_id INT
--AS
--BEGIN
--	BEGIN TRANSACTION;
--	BEGIN TRY
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
--	@booking_record_id = 1,
--	@service_room_id = 2


--Select * from SERVICE_USAGE_INFOR;

------Tìm kiếm mẫu thông tin sử dụng dịch vụ 

----Function trả về table không có custom đầu ra
----1. Tìm kiếm những mẫu thông tin dịch vụ sử dụng trong tháng (1,2,..)

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
select * from BOOKING_RECORD;
select * from View_Booking_Record
CREATE or ALTER PROCEDURE proc_insertBookingRecord
    @expected_checkin_date DATETIME,
    @expected_checkout_date DATETIME,
    @actual_checkin_date DATETIME,
    @actual_checkout_date DATETIME,
    @deposit FLOAT,
    @surcharge FLOAT,
    @note NVARCHAR(255),
    @status NVARCHAR(25),
    @representative_name NVARCHAR(50),
    @gender NVARCHAR(10),
    @email VARCHAR(255),
    @birthday DATE,
    @identify_card VARCHAR(25),
    @address NVARCHAR(255),
    @room_id INT
AS
BEGIN
	DECLARE @representative_id INT
    BEGIN TRANSACTION;
    BEGIN TRY
		-- Khi thêm hồ sơ đặt phòng vào thì không có mã người đại diện mà chỉ có tên khách hàng thôi nên phải insert vô bảng customer
		-- để có được mã người đại diện
		-- Nếu khách hàng đã tồn tại trong danh sách khách hàng thì không insert
		IF NOT EXISTS (SELECT 1 FROM CUSTOMER WHERE identify_card = @identify_card)
		BEGIN
			INSERT INTO CUSTOMER (customer_name, gender, email, birthday, identify_card, address) 
			values (@representative_name, @gender, @email, @birthday, @identify_card, @address);
			SELECT  TOP 1 @representative_id = customer_id FROM CUSTOMER ORDER BY customer_id DESC;
		END
		ELSE 
		BEGIN
			SELECT @representative_id = customer_id FROM CUSTOMER WHERE identify_card = @identify_card;
		END

        INSERT INTO BOOKING_RECORD(expected_checkin_date, expected_checkout_date, deposit,
		surcharge, note, status, actual_checkin_date, actual_checkout_date, room_id, representative_id)
        VALUES (@expected_checkin_date, @expected_checkout_date, @deposit,
		@surcharge, @note, @status, @actual_checkin_date, @actual_checkout_date, @room_id, @representative_id);
        COMMIT;
    END TRY
   	BEGIN CATCH
		DECLARE @err NVARCHAR(MAX)
		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
		RAISERROR(@err, 16, 1)
	END CATCH
END;
	
EXEC proc_insertBookingRecord
    @expected_checkin_date = '2023-11-05',
    @expected_checkout_date = '2023-11-10',
    @actual_checkin_date = '2023-11-06',
    @actual_checkout_date = '2023-11-09',
    @deposit = 1000000,
    @surcharge = 20000,
    @note = N'Additional notes',
    @status = N'Chờ xác nhận',
    @representative_name = N'Nguyen Van Be Bas',
    @gender = N'Nam',
    @email = 'johndoe@gmail.com',
    @birthday = '1990-01-01',
    @identify_card = '012345678001',
    @address = N'123 Main St',
    @room_id = 5;

select * from ROOM

select * from CUSTOMER
select * from BOOKING_RECORD

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