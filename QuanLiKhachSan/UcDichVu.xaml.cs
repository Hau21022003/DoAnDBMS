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
            List<string> listNameService = serviceRoomDao.LayDanhSachTenDichVu().AsEnumerable()
                .Select(x => x.Field<int>("service_room_id").ToString() + "|" + x.Field<string>("service_room_name"))
                .ToList<string>();
            cbDichVuCuaDatDichVu.ItemsSource = listNameService;
        }

        private void btnThemDaDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaDatDichVu_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinDatDichVu_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDatDichVu.SelectedValue;
            try
            {
                lbMaSuDungDichVu.Content = drv["service_usage_infor_id"].ToString();
                cbDichVuCuaDatDichVu.SelectedValue = drv["service_room_id"] + "|" + drv["service_room_name"];
                txtSoLuong.Text = drv["number_of_service"].ToString();
                dtpNgaySuDung.SelectedDate = DateTime.Parse(drv["date_used"].ToString());
                txtTongPhi.Text = drv["total_fee"].ToString();
                txtMaDatPhong.Text = drv["booking_record_id"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
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
            DataRowView drv = (DataRowView)dtgDanhSachDichVu.SelectedValue;
            try
            {
                lbMaDichVu.Content = drv["service_room_id"].ToString();
                txtTenDichVu.Text = drv["service_room_name"].ToString();
                chbTrangThaiDichVu.IsChecked = (bool)drv["service_room_status"];
                txtGia.Text = drv["service_room_price"].ToString();
                txtGiamGia.Text = drv["discount_service"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);    
            }
        }

        private void btnXoaDichVu_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
