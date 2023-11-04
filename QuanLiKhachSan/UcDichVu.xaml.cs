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
    /// Interaction logic for UcDichVu.xaml
    /// </summary>
    public partial class UcDichVu : UserControl
    {
        ServiceUsageInfoDao serviceUsageInfoDao = new ServiceUsageInfoDao();
        ServiceRoomDao serviceRoomDao = new ServiceRoomDao();
        public UcDichVu()
        {
            InitializeComponent();
        }

        public void LayDanhSach()
        {
            dtgDanhSachDatDichVu.ItemsSource = serviceUsageInfoDao.LayDanhSach().DefaultView;
            dtgDanhSachDichVu.ItemsSource = serviceRoomDao.LayDanhSach().DefaultView;
        }

        private void btnThemDaDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaDatDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinDatDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaDatDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinTDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaDichVu_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
