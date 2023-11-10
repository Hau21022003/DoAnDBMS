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
            string sql = "EXEC proc_updateAccount @account_id, @username, @password, @employee_id";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@account_id", accountId);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
        }
        public void Insert(string username, string password, int employeeId)
        {
            string sql = "EXEC proc_insertAccount @username, @password, @employee_id";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
        }
        public void Delete(int accountId)
        {
            string sql = "EXEC proc_deleteAccount @account_id";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@account_id", accountId);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
        }
    }
}
