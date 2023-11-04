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
            string sql = "select* from View_Employee";
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
            string sql = "select* from View_Name_Employee";
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
    }
}
