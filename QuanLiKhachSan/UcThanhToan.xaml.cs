using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace QuanLiKhachSan
{
    /// <summary>
    /// Interaction logic for UcThanhToan.xaml
    /// </summary>
    public partial class UcThanhToan : UserControl
    {
        private BillDao billDao = new BillDao();
        public UcThanhToan()
        {
            InitializeComponent();
        }

        public void LayDanhSach()
        {
            dtgDanhSach.ItemsSource = billDao.LayDanhSach().DefaultView;
        }

        private void btnThemBill_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaBill_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinBill_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSach.SelectedValue;
            try
            {
                lbMaBill.Content = drv["bill_id"].ToString();
                txtChiPhiPhatSinh.Text = drv["costs_incurred"].ToString();
                txtNoiDungPhatSinh.Text = drv["content_incurred"].ToString();
                txtTongPhi.Text = drv["total_cost"].ToString();
                if (drv["created_date"] != DBNull.Value)
                {
                    dtpNgayTao.SelectedDate = DateTime.Parse(drv["created_date"].ToString());
                }
                else
                {
                    dtpNgayTao.SelectedDate = null;
                }
                cbHinhThucThanhToan.SelectedValue = drv["payment_method"].ToString();
                if (drv["paytime"] != DBNull.Value)
                {
                    dtpNgayThanhToan.SelectedDate = DateTime.Parse(drv["paytime"].ToString());
                }
                else
                {
                    dtpNgayThanhToan.SelectedDate = null;
                }
                txtMaDatPhong.Text = drv["booking_record_id"].ToString();
                txtMaNhanVien.Text = drv["employee_id"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaBill_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
