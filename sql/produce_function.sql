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

--CREATE FUNCTION f_Calculate_Revenue
--(@StartDay DATETIME, @EndDay DATETIME)
--RETURNS TABLE
--AS
--RETURN (SELECT MONTH(BILL.created_date) AS Month, YEAR(BILL.created_date) AS Year, SUM(BILL.total_cost) AS ToTal 
--		FROM BILL 
--		WHERE BILL.created_date IS NOT NULL AND BILL.created_date >= @StartDay AND BILL.created_date <= @EndDay
--		GROUP BY MONTH(BILL.created_date), YEAR(BILL.created_date));
