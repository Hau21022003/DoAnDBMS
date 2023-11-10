﻿using System;
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
            string sql = "select* from View_Service_Name";
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

        public void Them(string serviceRoomName, float serviceRoomPrice, float discountService)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_insertServiceRoom";
            cmd.Parameters.Add("@service_room_name", SqlDbType.NVarChar).Value = serviceRoomName;
            cmd.Parameters.Add("@service_room_price", SqlDbType.Float).Value = serviceRoomPrice;
            cmd.Parameters.Add("@discount_service", SqlDbType.Float).Value = discountService;

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

        public void Sua(int id, string serviceRoomName,bool serviceRoomStatus, float serviceRoomPrice, float discountService)
        {
            SqlConnection conn = DbConnection.conn;
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_updateServiceRoom";
            cmd.Parameters.Add("@service_room_id", SqlDbType.Int).Value = id;
            cmd.Parameters.Add("@service_room_status", SqlDbType.Bit).Value = serviceRoomStatus;
            cmd.Parameters.Add("@service_room_name", SqlDbType.NVarChar).Value = serviceRoomName;
            cmd.Parameters.Add("@service_room_price", SqlDbType.Float).Value = serviceRoomPrice;
            cmd.Parameters.Add("@discount_service", SqlDbType.Float).Value = discountService;

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
