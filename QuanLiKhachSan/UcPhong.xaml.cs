using Microsoft.Win32;
using QuanLiKhachSan.Class;
using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.IO;
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
    /// Interaction logic for UcPhong.xaml
    /// </summary>
    public partial class UcPhong : UserControl
    {
        HinhAnhModel hinhAnh = new HinhAnhModel();
        RoomDao roomDao = new RoomDao();
        BookingRecordDao bookingDao = new BookingRecordDao();
        RoomTypeDao roomTypeDao = new RoomTypeDao();
        CustomerOfBookingRecordDao customerBookingDao = new CustomerOfBookingRecordDao();
        public UcPhong()
        {
            InitializeComponent();
            this.DataContext = hinhAnh;
        }
        
        public void LayDanhSach()
        {
            dtgDanhSachPhong.ItemsSource = roomDao.LayDanhSach().DefaultView;
            dtgDanhSachDatPhong.ItemsSource = bookingDao.layDanhSach().DefaultView;
            dtgDanhSachLoaiPhong.ItemsSource = roomTypeDao.LayDanhSach().DefaultView;
            dtgDanhSachKhachHangDatPhong.ItemsSource = customerBookingDao.LayDanhSach().DefaultView;
        }

        private void btnThemDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnXoaPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemPhong_Click(object sender, RoutedEventArgs e)
        {
            roomDao.Them(txtTenPhong.Text, int.Parse(txtSucChua.Text), txtTrangThaiPhong.Text, txtMoTaPhong.Text,
                ChuyenMangLuu(hinhAnh.HinhAnh), int.Parse(txtMaLoaiPhongCuaPhong.Text));
            LayDanhSach();
        }

        private void btnSuaPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemLoaiPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaLoaiPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemKhachHangDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaKhachHangDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private byte[] ChuyenHinhAnhSangMang(string fileName)
        {
            var encoder = new PngBitmapEncoder();
            var image = new BitmapImage(new Uri(fileName));
            encoder.Frames.Add(BitmapFrame.Create(image));
            using (var ms = new MemoryStream())
            {
                encoder.Save(ms);
                return ms.ToArray();
            }
        }
        private string ChuyenMangLuu(byte[] bytes)
        {
            return "0x" + BitConverter.ToString(bytes).Replace("-", "");
        }

        public void ChonHinhAnh()
        {
            var ofd = new OpenFileDialog()
            {
                Filter = "Image Files (*.jpg, *.png, *.bmp)|*.jpg;*.png;*.bmp",
                Multiselect = false
            };
            if (ofd.ShowDialog() == true)
            {
                hinhAnh.HinhAnh = ChuyenHinhAnhSangMang(ofd.FileName);
            }    
        }

        private void btnChonAnh_Click(object sender, RoutedEventArgs e)
        {
            ChonHinhAnh();
        }
    }
}
