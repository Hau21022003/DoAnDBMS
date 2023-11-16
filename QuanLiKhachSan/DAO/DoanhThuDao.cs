using LiveCharts;
using LiveCharts.Wpf;
using LiveCharts.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using QuanLiKhachSan.Class;

namespace QuanLiKhachSan.DAO
{
    class DoanhThuDao
    {
        public void LayDoanhThu(ThongKe thongKe)
        {
            string sql1 = "select* from f_Calculate_Revenue(@StartDay, @EndDay)";
            string sql2 = "SELECT dbo.f_Calculate_Total_Revenue (@StartDay, @EndDay)";
            SqlConnection conn = DbConnection.conn;
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                SqlCommand cmd = new SqlCommand(sql1, conn);
                SqlCommand cmd2 = new SqlCommand(sql2, conn);
                cmd.Parameters.AddWithValue("@StartDay", thongKe.NgayBatDau);
                cmd.Parameters.AddWithValue("@EndDay", thongKe.NgayKetThuc);
                cmd2.Parameters.AddWithValue("@StartDay", thongKe.NgayBatDau);
                cmd2.Parameters.AddWithValue("@EndDay", thongKe.NgayKetThuc);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                SqlDataAdapter adapter2 = new SqlDataAdapter(cmd2);
                DataTable tb = new DataTable();
                DataTable tb2 = new DataTable();
                adapter.Fill(tb);
                adapter2.Fill(tb2);

                List<double> listDoanhThu = new List<double>();
                DateTime current = thongKe.NgayBatDau;
                while (current <= thongKe.NgayKetThuc)
                {
                    listDoanhThu.Add(tb.AsEnumerable().Where(x => x.Field<int>("Month") == current.Month && x.Field<int>("Year") == current.Year)
                                                     .Select(x => x.Field<double>("ToTal")).DefaultIfEmpty(0).FirstOrDefault());
                    current = current.AddMonths(1);
                    if (current.Year == thongKe.NgayKetThuc.Year && current.Month == thongKe.NgayKetThuc.Month)
                        current = thongKe.NgayKetThuc;
                }

                List<string> labels = new List<string>();
                current = thongKe.NgayBatDau;
                while (current <= thongKe.NgayKetThuc)
                {
                    labels.Add(current.ToString("MM/yyyy"));
                    current = current.AddMonths(1);
                    if (current.Year == thongKe.NgayKetThuc.Year && current.Month == thongKe.NgayKetThuc.Month)
                        current = thongKe.NgayKetThuc;
                }
                thongKe.Labels = labels;
                SeriesCollection seriesCollection = new SeriesCollection()
                {
                     new LineSeries() { Title = "Doanh thu", Values = listDoanhThu.AsChartValues()}
                };
                thongKe.SeriesCollection = seriesCollection;
                thongKe.TongDoanhThu = (double)tb2.Rows[0][0];//tb.AsEnumerable().Sum(x => x.Field<double>("ToTal"));
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
            }
        }
    }
}