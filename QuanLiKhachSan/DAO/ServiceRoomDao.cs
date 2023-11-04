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
    class ServiceRoomDao
    {
        public DataTable LayDanhSach()
        {
            DataTable dt = new DataTable();
            string sql = "select* from View_Service";
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
        public DataTable LayDanhSachTenDichVu()
        {
            DataTable dt = new DataTable();
            string sql = "select* from View_Name_Service_Room";
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
