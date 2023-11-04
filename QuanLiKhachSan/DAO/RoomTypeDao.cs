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
    class RoomTypeDao
    {   
        public DataTable LayDanhSach()
        {
            SqlConnection conn = DbConnection.conn;
            DataTable dt = new DataTable(); 
            try
            {
                conn.Open();
                String sql = "Select* from View_Room_Type";
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
    }
}
