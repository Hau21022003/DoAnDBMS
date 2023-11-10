using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace QuanLiKhachSan.DAO
{
    class AccountDao
    {
        public DataTable LayDanhSach()
        {
            string sql = "Select* from View_Front_Desk_Account";
            DataTable dt = new DataTable();
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sql,conn);
                adapter.Fill(dt);
            }
            catch (Exception ex)
            {

            }
            finally { conn.Close(); }
            return dt;
        }
        public void Update(int accountId, string username, string password, int employeeId)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_updateAccount";
            cmd.Parameters.Add("@account_id",SqlDbType.Int).Value = accountId;
            cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
            cmd.Parameters.Add("@employee_id", SqlDbType.Int).Value = employeeId;
            try
            {
                conn.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Sửa thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
        public void Insert(string username, string password, int employeeId)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_insertAccount";
            cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value =password;
            cmd.Parameters.Add("@employee_id", SqlDbType.Int).Value = employeeId;
            try
            {
                conn.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Thêm thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
        public void Delete(int accountId)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_deleteAccount";
            cmd.Parameters.Add("@account_id", SqlDbType.Int).Value = accountId;
            try
            {
                conn.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Xóa thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
