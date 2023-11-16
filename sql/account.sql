use HotelManagementSystem;

ALTER TABLE ACCOUNT
ADD roles NVARCHAR(20);


SELECT * FROM ACCOUNT;
SELECT * FROM EMPLOYEE;

INSERT INTO ACCOUNT VALUES('admin', 'password1', 5, 'admin');


SELECT * FROM View_Front_Desk_Account;

CREATE ROLE Staff;

--4. **Tài khoản**
SELECT * FROM ACCOUNT;
--THÊM ACCOUNT

CREATE OR ALTER PROCEDURE proc_insertAccount
    @username NVARCHAR(50),
    @password VARCHAR(25),
    @employee_id INT,
    @roles NVARCHAR(20)
AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
        -- Thêm tài khoản
        INSERT INTO ACCOUNT (username, password, employee_id, roles) VALUES (@username, @password, @employee_id, @roles);

        DECLARE @sqlString NVARCHAR(2000)

        -- Tạo tài khoản login cho nhân viên, tên người dùng và mật khẩu là tài khoản được tạo trên bảng Account
        SET @sqlString = 'CREATE LOGIN [' + @username + '] WITH PASSWORD=''' + @password + ''', DEFAULT_DATABASE=[HotelManagementSystem], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF'
        EXEC (@sqlString)

        -- Tạo tài khoản người dùng đối với nhân viên đó trên database (tên người dùng trùng với tên login)
        -- Tạo tài khoản người dùng đối với nhân viên đó trên database (tên người dùng trùng với tên login)
		SET @sqlString = 'CREATE USER ' + @username + ' FOR LOGIN ' + @username;
		EXEC (@sqlString)


        -- Thêm người dùng vào vai trò quyền tương ứng (Staff hoặc Manager(sysadmin))
        IF (@roles = 'sysadmin')
            SET @sqlString = 'ALTER SERVER ROLE sysadmin ADD MEMBER ' + @username;
        ELSE
            SET @sqlString = 'ALTER ROLE Staff ADD MEMBER ' + @username;

        EXEC (@sqlString)

        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        DECLARE @err NVARCHAR(MAX)
        SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
        RAISERROR(@err, 16, 1)
    END CATCH
END


EXEC proc_insertAccount
    @username = 'tuyenne',
    @password = '123446',
    @employee_id = 5,
	@roles = 'STAFF'

EXEC proc_insertAccount
    @username = 'tuyenne1',
    @password = '123446',
    @employee_id = 5,
	@roles = 'sysadmin'

SELECT * FROM ACCOUNT;

----Xóa ACCOUNT

CREATE or ALTER PROCEDURE proc_deleteAccount
    @account_id INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM ACCOUNT where account_id = @account_id
        COMMIT;
    END TRY
   	BEGIN CATCH
		DECLARE @err NVARCHAR(MAX)
		SELECT @err = N'Lỗi ' + ERROR_MESSAGE()
		RAISERROR(@err, 16, 1)
	END CATCH
END;
 
 exec proc_deleteAccount @account_id = 5;

 SELECT * FROM ACCOUNT;

-- --Cập nhật ACCOUNT
CREATE OR ALTER PROCEDURE proc_updateAccount
    @account_id INT,
    @username NVARCHAR(50),
    @password VARCHAR(25),
    @employee_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE ACCOUNT
        SET
            username = @username,
            password = @password,
            employee_id = @employee_id
        WHERE account_id = @account_id;

        COMMIT;
    END TRY
    BEGIN CATCH
        DECLARE @err NVARCHAR(MAX);
        SELECT @err = N'Lỗi ' + ERROR_MESSAGE();
        ROLLBACK; 
        RAISERROR(@err, 16, 1);
    END CATCH
END;


select * from account;
EXEC proc_updateAccount
	@account_id = 1,
    @username = 'CAM ON',
    @password = '123446',
    @employee_id = 1

SELECT * FROM ACCOUNT;