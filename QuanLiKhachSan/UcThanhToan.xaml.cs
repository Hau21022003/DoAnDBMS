using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
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

        }

        private void btnXoaBill_Click(object sender, RoutedEventArgs e)
        {

        }


        private void cbLocTrangThaiBill_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string trangThaiBill = (string)cbLocTrangThaiBill.SelectedValue;
            if(trangThaiBill == "Chưa thanh toán")
            {
                dtgDanhSach.ItemsSource = billDao.LayDsBillChuaThanhToan().DefaultView;
            } else if(trangThaiBill == "Đã thanh toán")
            {
                dtgDanhSach.ItemsSource = billDao.LayDsBillDaThanhToan().DefaultView;
            }
            else
            {
                dtgDanhSach.ItemsSource = billDao.LayDanhSach().DefaultView;
            }
        }
    }
}
