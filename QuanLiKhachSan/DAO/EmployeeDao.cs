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
    class EmployeeDao
    {
        public DataTable LayDanhSach()
        {
            string sql = "select* from View_Front_Desk_Employee";
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
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
            return dt;
        }
        public DataTable LayDanhSachTenNhanVien()
        {
            string sql = "select* from View_Employee_Name";
            DataTable dt = new DataTable();
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conn);
                adapter.Fill(dt);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
            return dt;
        }
        public void Insert(string employeeName, string gender,DateTime? birthday, 
            string identifyCard,string address, string email)
        {
            string sql = "EXEC proc_insertEmployee @employee_name,@gender,@birthday," +
                "@identify_card,@address,@email";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@employee_name", employeeName);
                cmd.Parameters.AddWithValue("@gender", gender);
                cmd.Parameters.AddWithValue("@birthday", (object)birthday ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@identify_card", identifyCard);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
        }
        public void Update(int employeeId, string employeeName, string gender, DateTime? birthday,
            string identifyCard, string address, string email)
        {
            string sql = "EXEC proc_updateEmployee @employee_id, @employee_name,@gender,@birthday," +
                "@identify_card,@address,@email";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.Parameters.AddWithValue("@employee_name", employeeName);
                cmd.Parameters.AddWithValue("@gender", gender);
                cmd.Parameters.AddWithValue("@birthday", (object)birthday ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@identify_card", identifyCard);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
        }
        public void Delete(int employeeId)
        {
            string sql = "EXEC proc_deleteEmployee @employee_id";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
            finally { conn.Close(); }
        }
        public DataTable TimKiemTheoHoTen(string employeeName)
        {
            string sql = "SELECT * FROM func_searchByEmployeeName(@employee_name)";
            DataTable dt = new DataTable();
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@employee_name", employeeName);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally { conn.Close(); }
            return dt;
        }
    }
}
