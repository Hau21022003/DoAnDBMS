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
    /// Interaction logic for UcKhachHang.xaml
    /// </summary>
    public partial class UcKhachHang : UserControl
    {
        CustomerDao customerDao = new CustomerDao();
        PhoneNumberOfCustomerDao phoneDao = new PhoneNumberOfCustomerDao();
        public UcKhachHang()
        {
            InitializeComponent();
        }

        public void LayDanhSach()
        {
            dtgDanhSachKhachHang.ItemsSource = customerDao.LayDanhSach().DefaultView;
            dtgDanhSachSdtCuaKhach.ItemsSource = phoneDao.LayDanhSach().DefaultView;
        }

        private void btnThemKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaSdtKhach_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemSdtKhach_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinSdtKhach_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaSdtKhach_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
