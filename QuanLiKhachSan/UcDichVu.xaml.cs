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
            try
            {
                int maDichVu = int.Parse(((string)cbDichVuCuaDatDichVu.SelectedValue).Split("|")[0]);
                serviceUsageInfoDao.Them(int.Parse(txtSoLuong.Text), float.Parse(txtTongPhi.Text), int.Parse(txtMaDatPhong.Text), maDichVu);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSuaDatDichVu_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int maDichVu = int.Parse(((string)cbDichVuCuaDatDichVu.SelectedValue).Split("|")[0]);
                serviceUsageInfoDao.Sua(int.Parse((string)tbMaSuDungDichVu.Content),int.Parse(txtSoLuong.Text), float.Parse(txtTongPhi.Text), int.Parse(txtMaDatPhong.Text), maDichVu);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThongTinDatDichVu_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDatDichVu.SelectedValue;
            try
            {
                tbMaSuDungDichVu.Content = drv["service_usage_infor_id"].ToString();
                txtSoLuong.Text = drv["number_of_service"].ToString();
                dtpNgaySuDung.Text = drv["date_used"].ToString();
                txtMaDatPhong.Text = drv["booking_record_id"].ToString();
                txtTongPhi.Text = drv["total_fee"].ToString();
                cbDichVuCuaDatDichVu.SelectedValue = drv["service_room_id"].ToString() + "|" + drv["service_room_name"];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaDatDichVu_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDatDichVu.SelectedValue;
            try
            {
                serviceUsageInfoDao.Xoa((int)drv["service_usage_infor_id"]);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThemDichVu_Click(object sender, RoutedEventArgs e)
        {
            try
            { 
                serviceRoomDao.Them((string)txtTenDichVu.Text, float.Parse(txtGia.Text), float.Parse(txtGiamGia.Text));
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSuaDichVu_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                serviceRoomDao.Sua(int.Parse((string)lbMaDichVu.Content), (string)txtTenDichVu.Text, (bool)chbTrangThaiDichVu.IsChecked, float.Parse(txtGia.Text), float.Parse(txtGiamGia.Text));
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThongTinTDichVu_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDichVu.SelectedValue;
            try
            {
                lbMaDichVu.Content = drv["service_room_id"].ToString();
                txtTenDichVu.Text = drv["service_room_name"].ToString();
                txtGiamGia.Text = drv["discount_service"].ToString();
                txtGia.Text = drv["service_room_price"].ToString();

                if ((bool)drv["service_room_status"])
                {
                    chbTrangThaiDichVu.IsChecked = true;
                }
                else
                {
                    chbTrangThaiDichVu.IsChecked = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaDichVu_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDichVu.SelectedValue;
            try
            {
                serviceRoomDao.Xoa((int)drv["service_room_id"]);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
