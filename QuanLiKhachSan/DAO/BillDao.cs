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
    class BillDao
    {
        public DataTable LayDanhSach()
        {
            DataTable dt = new DataTable();
            string sql = "select* from view_BILL";
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
        public DataTable LayDsBillChuaThanhToan()
        {
            DataTable dt = new DataTable();
            string sql = "select* from View_Unpaid_Bill";
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
        public DataTable LayDsBillDaThanhToan()
        {
            DataTable dt = new DataTable();
            string sql = "select* from View_Paid_Bill";
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
