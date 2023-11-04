--USE HotelMangementSystem;

--CREATE TABLE SERVICE_ROOM (
--    service_room_id INT IDENTITY(1, 1) CONSTRAINT PK_SERVICE_ROOM PRIMARY KEY,
--    service_room_name NVARCHAR(50) NOT NULL,
--    service_room_status BIT DEFAULT 1 NOT NULL, -- 1: AVAILABLE; 0: UNAVAILABLE;
--    service_room_price FLOAT NOT NULL,
--    discount_service FLOAT
--);


----Thêm dịch vụ phòng
--CREATE PROCEDURE InsertServiceRoom
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
--          	ROLLBACK TRAN
--          	RAISERROR('DỊCH VỤ ĐÃ TỒN TẠI', 25, 1)
--   	END CATCH
--END;


--EXEC InsertServiceRoom
--    @service_room_name = 'Example Room',
--    @service_room_price = 100.0,
--    @discount_service = 10.0;


--SELECT * FROM SERVICE_ROOM;

----Xóa dịch vụ phòng

--CREATE PROCEDURE DeleteServiceRoom
--    @service_room_id INT
--AS
--BEGIN
--    BEGIN TRANSACTION;

--    BEGIN TRY
--        DELETE FROM SERVICE_ROOM where SERVICE_ROOM.service_room_id = @service_room_id
--        COMMIT;
--    END TRY
--   	BEGIN CATCH
--          	ROLLBACK TRAN
--          	RAISERROR('KHÔNG XÓA ĐƯỢC DỊCH VỤ', 25, 1)
--   	END CATCH
--END;
 
-- exec DeleteServiceRoom @service_room_id = 1;

-- SELECT * FROM SERVICE_ROOM;

-- --Cập nhật dịch vụ phòng
-- CREATE PROCEDURE UpdateServiceRoom
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
--	BEGIN CATCH
--		ROLLBACK TRAN
--        RAISERROR('KHÔNG CẬP NHẬT ĐƯỢC DỊCH VỤ', 25, 1)
--	END CATCH
--END;

--exec UpdateServiceRoom 
--	@service_room_id = 2,
--	@service_room_name = 'Vay đồ',
--	@service_room_status = 1,
--	@service_room_price = 32943243,
--	@discount_service = 3249333;

--Select * from SERVICE_ROOM;

----Tìm kiếm theo tên dịch vụ

CREATE FUNCTION searchByServiceName(@service_room_price NVARCHAR(50))
	RETURNS table
AS RETURN ( SELECT * FROM SERVICE_ROOM WHERE service_room_name = @service_room_name)

SELECT * FROM serchByServiceName(N'Giặt ủi, là');

-- Tìm kiếm dịch vụ trong khoảng giá

CREATE FUNCTION searchInPriceRange(@service_room_price1 FLOAT, @service_room_price2 FLOAT)
	RETURNS table
AS RETURN ( SELECT * FROM SERVICE_ROOM WHERE service_room_price between @service_room_price1 and @service_room_price2)

SELECT * FROM searchInPriceRange(10000, 15000);