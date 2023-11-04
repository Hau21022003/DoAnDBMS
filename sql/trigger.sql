-- 2.6.1. Trigger when adding a new booking record to update room status to 'Onrent'
CREATE OR ALTER TRIGGER Update_status_room_reserved
ON BOOKING_RECORD
AFTER INSERT
AS
BEGIN
    UPDATE ROOM
    SET room_status = 'Onrent'
    FROM ROOM
    WHERE ROOM.room_id = (SELECT room_id FROM inserted);
END;

-- 2.6.2. Trigger when adding a new booking record to insert a new bill
CREATE OR ALTER TRIGGER Insert_bill_on_booking_record
ON BOOKING_RECORD
AFTER INSERT
AS
BEGIN
    INSERT INTO BILL (booking_record_id)
    SELECT booking_record_id
    FROM inserted;
END;

-- 2.6.3. Trigger when adding a new booking record to check room availability and roll back if not available
CREATE OR ALTER TRIGGER Check_room_to_insert_booking
ON BOOKING_RECORD
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM ROOM
        INNER JOIN inserted I ON ROOM.room_id = I.room_id
        WHERE ROOM.room_status = 'Available'
    )
    BEGIN
        INSERT INTO BOOKING_RECORD (
            booking_record_id,
            booking_time,
            expected_checkin_date,
            expected_checkout_date,
            deposit,
            surcharge,
            note,
            status,
            actual_checkin_date,
            actual_checkout_date,
            room_id,
            representative_id
        )
        SELECT 
            I.booking_record_id,
            I.booking_time,
            I.expected_checkin_date,
            I.expected_checkout_date,
            I.deposit,
            I.surcharge,
            I.note,
            I.status,
            I.actual_checkin_date,
            I.actual_checkout_date,
            I.room_id,
            I.representative_id
        FROM inserted I;
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'No suitable room available, the transaction has been rolled back.';
    END;
END;

-- 2.6.4. Trigger to delete a booking record if the deposit is not paid after 30 minutes
CREATE OR ALTER TRIGGER Delete_booking_record_not_deposited
ON BOOKING_RECORD
AFTER INSERT
AS
BEGIN
    -- Delete from the BOOKING_RECORD table
    DELETE FROM BOOKING_RECORD
    WHERE GETDATE() > DATEADD(MINUTE, 30, booking_time)
    AND deposit = 0 
    AND booking_time <> actual_checkin_date;
END;

-- 2.6.5. Trigger to update room status to 'Available' after 30 minutes if deposit is not paid
CREATE OR ALTER TRIGGER Update_status_room
ON BOOKING_RECORD
AFTER DELETE
AS
BEGIN
    UPDATE ROOM
    SET room_status = 'Available'
    FROM ROOM
    JOIN deleted ON ROOM.room_id = deleted.room_id
    WHERE ROOM.room_id = deleted.room_id;
END;
-- 2.6.6. Trigger to update actual checkout date in the booking record after payment
CREATE OR ALTER TRIGGER UpdateActualCheckoutDate
ON BILL
AFTER UPDATE
AS
BEGIN
    IF UPDATE(paytime)
    BEGIN
        UPDATE BOOKING_RECORD
        SET actual_checkout_date = i.paytime
        FROM inserted i
        JOIN BOOKING_RECORD br ON i.booking_record_id = br.booking_record_id;
    END
END;

-- 2.6.7. Trigger to update incurred cost based on late check-out in the booking record
-- Additional charges for late check-out:
-- - From 12:00 PM to 3:00 PM: 30% room price.
-- - From 3:00 PM to 6:00 PM: 50% room price.
-- - After 6:00 PM: 100% room price.
CREATE OR ALTER TRIGGER UpdateActualIncurredCost
ON BILL
AFTER UPDATE
AS
BEGIN
    IF UPDATE(paytime)
    BEGIN
        UPDATE b
        SET costs_incurred =
            CASE
                WHEN i.paytime > br.expected_checkout_date THEN
                    CASE
                        WHEN i.paytime <= DATEADD(HOUR, 3, br.expected_checkout_date) THEN (rt.price * 0.3)
                        WHEN i.paytime <= DATEADD(HOUR, 6, br.expected_checkout_date) THEN (rt.price * 0.5)
                        ELSE (rt.price)
                    END
                ELSE 0
            END
        FROM BILL b
        JOIN inserted i ON b.bill_id = i.bill_id
        JOIN BOOKING_RECORD br ON br.booking_record_id = i.booking_record_id
        JOIN ROOM r ON br.room_id = r.room_id
        JOIN ROOM_TYPE rt ON rt.room_type_id = r.room_type_id;
    END
END;

-- 2.6.8. Trigger to update customer status to unofficial after payment
CREATE OR ALTER TRIGGER UpdateCustomerStatusToUnofficial
ON BILL
AFTER UPDATE
AS
BEGIN
    IF UPDATE(paytime)
    BEGIN
        UPDATE CUSTOMER
        SET status = 0
        FROM inserted i
        JOIN CUSTOMER_OF_BOOKING_RECORD cbr ON i.booking_record_id = cbr.booking_record_id
        JOIN CUSTOMER c ON cbr.customer_id = c.customer_id;
    END
END;

-- 2.6.9. Trigger to update room status to available after payment
CREATE OR ALTER TRIGGER UpdateRoomStatusToAvailable
ON BILL
AFTER UPDATE
AS
BEGIN
    IF UPDATE(paytime)
    BEGIN
        UPDATE ROOM
        SET room_status = 'Available'
        FROM inserted i
        JOIN BOOKING_RECORD br ON i.booking_record_id = br.booking_record_id
        JOIN ROOM r ON br.room_id = r.room_id;
    END
END;

-- 2.6.10. Trigger to update room, booking record, and bill when changing rooms or updating a booking record
CREATE OR ALTER TRIGGER Update_room_booking_record_bill_when_update_booking_record
ON BOOKING_RECORD
AFTER UPDATE
AS
BEGIN
    DECLARE @room_old VARCHAR(25);
    SET @room_old = (SELECT room_id FROM deleted);

    DECLARE @room_new VARCHAR(25);
    SET @room_new = (SELECT room_id FROM inserted);

    DECLARE @booking_record_id_new VARCHAR(25);
    SET @booking_record_id_new = (SELECT booking_record_id FROM inserted);

    DECLARE @number_of_days INT;
    SET @number_of_days = DATEDIFF(DAY, (SELECT actual_checkin_date FROM inserted), (SELECT actual_checkout_date FROM inserted)) + 1;

    UPDATE ROOM
    SET room_status = 'Available'
    WHERE room_id = @room_old;

    UPDATE ROOM
    SET room_status = 'Onrent'
    WHERE room_id = @room_new;

    UPDATE BILL
    SET total_cost = (
        SELECT
            (
                (SELECT price FROM ROOM_TYPE WHERE room_type_id = (SELECT room_type_id FROM ROOM WHERE room_id = @room_new)) * @number_of_days
                + (SELECT SUM(number_of_service * service_room_price) FROM
                    (SERVICE_USAGE_INFOR
                    INNER JOIN SERVICE_ROOM ON SERVICE_USAGE_INFOR.service_room_id = SERVICE_ROOM.service_room_id)
                    WHERE booking_record_id = @booking_record_id_new
                )
            )
            + (SELECT deposit FROM inserted)
            + (SELECT surcharge FROM inserted)
        )
    WHERE booking_record_id = @booking_record_id_new;
END;


-- 2.6.11. Trigger to handle when a customer has made a deposit but didn't check-in (the hotel holds the reservation until 12 PM the next day).
-- This deposit will be added to the revenue as described in the previous triggers. 
-- This trigger executes after an INSERT operation and updates room status (available), booking record status (canceled), and bill status (paid).
CREATE OR ALTER TRIGGER UpdateRoomBookingRecordBillWhenCustomerNotCheckin
ON BOOKING_RECORD
AFTER INSERT
AS
BEGIN
  DECLARE @booking_record_id VARCHAR(25);
  SET @booking_record_id = (SELECT booking_record_id FROM inserted);

  DECLARE @room_id VARCHAR(25);
  SET @room_id = (SELECT room_id FROM inserted);

  DECLARE @actual_checkin_date DATETIME;
  SET @actual_checkin_date = (SELECT actual_checkin_date FROM inserted);
  
  DECLARE @expected_checkin_date DATETIME;
  SET @expected_checkin_date = (SELECT expected_checkin_date FROM inserted);

  DECLARE @deposit MONEY;
  SET @deposit = (SELECT deposit FROM inserted);

  DECLARE @interval_time_hour INT;
  SET @interval_time_hour = 12 + DATEDIFF(HOUR, DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0), @expected_checkin_date)

  WHILE @interval_time_hour > 24
	BEGIN
	  WAITFOR DELAY '23:59:59';
	  SET @interval_time_hour = @interval_time_hour - 24;
	END;

  DECLARE @new_time_interval VARCHAR(10) = CONCAT(@interval_time_hour, ':00:00');
  WAITFOR DELAY @new_time_interval;

  IF (GETDATE() >= DATEADD(HOUR, 12, @expected_checkin_date)) AND @deposit > 0 AND @actual_checkin_date IS NULL
  BEGIN
    -- Update room status to 'Available'
    UPDATE ROOM
    SET room_status = 'Available'
    WHERE room_id = @room_id;

    -- Update booking record status to 'Canceled'
    UPDATE BOOKING_RECORD
    SET status = 'Canceled'
    WHERE booking_record_id = @booking_record_id;

    -- Update bill status to 'Paid' and set total cost as the deposit
    UPDATE BILL
    SET total_cost = @deposit,
        paytime = GETDATE()
    WHERE booking_record_id = @booking_record_id;
  END;
END;

-- 2.6.12. Trigger to update customer status to official and apply surcharge for early check-in and exceeding room capacity.
-- This trigger executes after an UPDATE operation on booking record status.
CREATE OR ALTER TRIGGER UpdateBookingRecordStatusIsOfficial
ON BOOKING_RECORD
AFTER UPDATE
AS 
IF UPDATE(status) 
BEGIN
  DECLARE @status VARCHAR(10) = (SELECT status FROM inserted);
  IF @status = 'official'
  BEGIN
    DECLARE @booking_record_id VARCHAR(25);
    DECLARE @actual_checkin_date DATETIME;
    DECLARE @room_id VARCHAR(25);
    SELECT @booking_record_id = booking_record_id,
           @room_id = room_id,
           @actual_checkin_date = actual_checkin_date
    FROM inserted;

    -- Update customer status to 'official'
    UPDATE CUSTOMER
    SET status = 'official'
    WHERE customer_id IN (SELECT customer_id 
      FROM CUSTOMER_OF_BOOKING_RECORD
      WHERE booking_record_id = @booking_record_id);

    -- Calculate room price
    DECLARE @room_price MONEY;
    SELECT @room_price = price
    FROM ROOM 
    JOIN ROOM_TYPE ON ROOM.room_type_id = ROOM_TYPE.room_type_id            
    WHERE room_id = @room_id;

    DECLARE @checkin_hour INT;
    SET @checkin_hour = FORMAT(@actual_checkin_date, 'HH');

    DECLARE @surcharge INT = (SELECT surcharge FROM inserted);
    DECLARE @note NVARCHAR(255) = (SELECT note FROM inserted);

    -- Apply surcharge for early check-in
    IF @checkin_hour >= 5 AND @checkin_hour < 9
    BEGIN
      SET @surcharge = @surcharge + 0.5 * @room_price;
      SET @note = CONCAT(@note, N'Early check-in from 5 AM to before 9 AM. ');
    END

    IF @checkin_hour >= 9 AND @checkin_hour < 14
    BEGIN
      SET @surcharge = @surcharge + 0.3 * @room_price;
      SET @note = CONCAT(@note, N'Early check-in from 9 AM to before 2 PM. ');

      -- Update the booking record surcharge
      UPDATE BOOKING_RECORD
      SET surcharge = (SELECT surcharge FROM inserted) + 0.3 * @room_price;
    END

    -- Calculate the number of customers
    DECLARE @number_of_customers INT = (SELECT COUNT(customer_id) 
     FROM CUSTOMER_OF_BOOKING_RECORD 
     WHERE booking_record_id = @booking_record_id);

    -- Get the room capacity
    DECLARE @room_capacity INT = (SELECT room_capacity FROM ROOM WHERE room_id = @room_id);

    -- Apply surcharge for exceeding room capacity
    IF @number_of_customers > @room_capacity
    BEGIN
      SET @surcharge = @surcharge + (@number_of_customers - @room_capacity) * 200000;
      SET @note = CONCAT(@note, N'Exceeded room capacity: ', @number_of_customers - @room_capacity, ' people. ');
    END

    -- Update the booking record surcharge and note
    IF @surcharge <> (SELECT surcharge FROM inserted)
    BEGIN
      UPDATE BOOKING_RECORD 
      SET surcharge = @surcharge, note = @note
      WHERE booking_record_id = @booking_record_id;
    END
  END
END
