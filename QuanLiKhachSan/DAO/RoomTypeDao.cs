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

        public void Them(string room_type_name, float price, float discount_room) { 
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_add_room_type";
            cmd.Parameters.Add("@room_type_name", SqlDbType.NVarChar).Value = room_type_name;
            cmd.Parameters.Add("@price", SqlDbType.Float).Value = price;
            cmd.Parameters.Add("@discount_room", SqlDbType.Float).Value = discount_room;

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
        public void Sua(int id, string room_type_name, float price, float discount_room)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_delete_room_type";
            cmd.Parameters.Add("@room_type_id", SqlDbType.Int).Value = id;
            cmd.Parameters.Add("@room_type_name", SqlDbType.NVarChar).Value = room_type_name;
            cmd.Parameters.Add("@price", SqlDbType.Float).Value = price;
            cmd.Parameters.Add("@discount_room", SqlDbType.Float).Value = discount_room;

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
        public void Xoa(int id)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_deleteServiceRoom";
            cmd.Parameters.Add("@service_room_id", SqlDbType.Int).Value = id;

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