using Microsoft.Win32;
using QuanLiKhachSan.Class;
using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.Data;
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
        CustomerDao customerDao = new CustomerDao();
        public UcPhong()
        {
            InitializeComponent();
            this.DataContext = hinhAnh;
            //List<string> list = new List<string>() { "Đang cho thuê", "Trống", "Đang sửa" };
            //cbTrangThaiPhong.ItemsSource = list;
        }
        
        public void LayDanhSach()
        {
            dtgDanhSachPhong.ItemsSource = roomDao.LayDanhSach().DefaultView;
            dtgDanhSachDatPhong.ItemsSource = bookingDao.layDanhSach().DefaultView;
            dtgDanhSachLoaiPhong.ItemsSource = roomTypeDao.LayDanhSach().DefaultView;
            dtgDanhSachKhachHangDatPhong.ItemsSource = customerBookingDao.LayDanhSach().DefaultView;
            cbPhongCuaDatPhong.ItemsSource = roomDao.LayDanhSachTenPhong().AsEnumerable()
                .Select(x => x.Field<int>("room_id").ToString() + "|" + x.Field<string>("room_name")).ToList<string>(); ;
            cbLoaiPhongCuaPhong.ItemsSource = roomTypeDao.LayDanhSach().AsEnumerable()
                .Select(x => x.Field<int>("room_type_id").ToString() + "|" + x.Field<string>("room_type_name"))
                .ToList<string>();
            List<string> danhSachTenKhachHang = customerDao.LayDanhSachTenKhach().AsEnumerable()
                .Select(x => x.Field<int>("customer_id").ToString() + "|" + x.Field<string>("customer_name"))
                .ToList<string>();
            cbKhachHangCuaKhachDatPhong.ItemsSource = danhSachTenKhachHang;
            cbNguoiDaiDienDatPhong.ItemsSource = danhSachTenKhachHang;
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
            DataRowView drv = (DataRowView)dtgDanhSachPhong.SelectedValue;
            try
            { 
                lbMaPhong.Content = drv["room_id"].ToString();
                txtTenPhong.Text = drv["room_name"].ToString();
                txtSucChua.Text = drv["room_capacity"].ToString();
                cbTrangThaiPhong.SelectedValue = drv["room_status"].ToString();
                if (drv["room_description"] != DBNull.Value)
                {
                    txtMoTaPhong.Text = drv["room_description"].ToString();
                }
                if (drv["room_image"] != DBNull.Value)
                {
                    hinhAnh.HinhAnh = (byte[])drv["room_image"];
                }
                dtpNgayCapNhatPhong.SelectedDate = DateTime.Parse(drv["room_update"].ToString());
                cbLoaiPhongCuaPhong.SelectedValue = drv["room_type_id"].ToString() + "|" + drv["room_type_name"];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThemPhong_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int maLoaiPhong = int.Parse(((string)cbLoaiPhongCuaPhong.SelectedValue).Split("|")[0]);
                roomDao.Them(txtTenPhong.Text, int.Parse(txtSucChua.Text), (string)cbTrangThaiPhong.SelectedValue, txtMoTaPhong.Text,
                    ChuyenMangLuu(hinhAnh.HinhAnh), maLoaiPhong);
                LayDanhSach();
            }
            catch (Exception ex) 
            { 
                MessageBox.Show(ex.Message); 
            }
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
