using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiKhachSan.DAO
{
    class EmployeeDao
    {
        public DataTable LayDanhSach()
        {
            String sql = "select* from View_Employee";
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
    }
}
