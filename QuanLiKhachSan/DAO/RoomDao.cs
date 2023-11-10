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
    class RoomDao
    {
        public DataTable LayDanhSach()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                string sql = "select* from View_Room";
                SqlDataAdapter adapter = new SqlDataAdapter(sql,conn);
                adapter.Fill(dt);
            }
            catch(Exception ex) 
            { 
                MessageBox.Show(ex.Message); 
            }
            finally { conn.Close(); }
            return dt;
        }
        public void Them(string tenPhong, int sucChua, string trangThai, string moTa, string anh, int loaiPhong)
        {
            SqlConnection conn = DbConnection.conn;
            string sql = $"insert into Room(room_name, room_capacity, room_status, room_description, room_image, room_type_id) " +
                $"values('{tenPhong}', {sucChua},N'{trangThai}',N'{moTa}',{anh},{loaiPhong})";
            MessageBox.Show("OK");
            try
            {
                conn.Open();
                SqlCommand cm = new SqlCommand(sql, conn);
                if (cm.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("thanh cong");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message );
            }
            finally
            {
                conn.Close();
            }
        }
        public DataTable LayDanhSachTenPhong()
        {
            DataTable dt = new DataTable() ;
            string sql = "select* from View_Room_Name";
            SqlConnection conn = DbConnection.conn;
            try
            {
                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sql,conn);
                adapter.Fill(dt);
            }
            catch ( Exception ex )
            {
                MessageBox.Show(ex.Message );
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }
    }
}
