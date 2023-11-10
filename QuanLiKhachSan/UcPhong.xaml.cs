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
            try
            {
                DateTime? expectedCheckinDate = dtpNgayCheckinDuKien.SelectedDate;
                DateTime? expectedCheckoutDate = dtpNgayCheckoutDuKien.SelectedDate;
                DateTime? actualCheckinDate = dtpNgayCheckinThucTe.SelectedDate;
                DateTime? actualCheckoutDate = dtpNgayCheckoutThucTe.SelectedDate;
                float deposit = float.Parse(txtTienCoc.Text);
                float surcharge = float.Parse(txtPhuPhi.Text);
                string note = txtGhiChu.Text;
                string status = cbTrangThaiDatPhong.Text;
                int representativeId = int.Parse(cbNguoiDaiDienDatPhong.Text.Split("|")[0]);
                int roomId = int.Parse(cbPhongCuaDatPhong.Text.Split("|")[0]);
                bookingDao.Insert(expectedCheckinDate, expectedCheckoutDate, actualCheckinDate, actualCheckoutDate, deposit, surcharge,
                    note, status, representativeId, roomId);
                LayDanhSach();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSuaDatPhong_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int bookingRecordId = int.Parse(lbMaDatPhong.Content.ToString());
                DateTime? expectedCheckinDate = dtpNgayCheckinDuKien.SelectedDate;
                DateTime? expectedCheckoutDate = dtpNgayCheckoutDuKien.SelectedDate;
                DateTime? actualCheckinDate = dtpNgayCheckinThucTe.SelectedDate;
                DateTime? actualCheckoutDate = dtpNgayCheckoutThucTe.SelectedDate;
                float deposit = float.Parse(txtTienCoc.Text);
                float surcharge = float.Parse(txtPhuPhi.Text);
                string note = txtGhiChu.Text;
                string status = cbTrangThaiDatPhong.Text;
                int representativeId = int.Parse(cbNguoiDaiDienDatPhong.Text.Split("|")[0]);
                int roomId = int.Parse(cbPhongCuaDatPhong.Text.Split("|")[0]);
                bookingDao.Update(bookingRecordId,expectedCheckinDate, expectedCheckoutDate, actualCheckinDate, actualCheckoutDate, deposit, surcharge,
                    note, status, representativeId, roomId);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThongTinDatPhong_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDatPhong.SelectedValue;
            try
            {
                lbMaDatPhong.Content = drv["booking_record_id"].ToString();
                dtpNgayDatPhong.SelectedDate = DateTime.Parse(drv["booking_time"].ToString());
                dtpNgayCheckinDuKien.SelectedDate = DateTime.Parse(drv["expected_checkin_date"].ToString());
                dtpNgayCheckoutDuKien.SelectedDate = DateTime.Parse(drv["expected_checkout_date"].ToString());
                if (drv["actual_checkin_date"] != DBNull.Value)
                {
                    dtpNgayCheckinThucTe.SelectedDate = DateTime.Parse(drv["actual_checkin_date"].ToString());
                }
                else
                {
                    dtpNgayCheckinThucTe.SelectedDate = null;
                }
                if (drv["actual_checkout_date"] != DBNull.Value)
                {
                    dtpNgayCheckoutThucTe.SelectedDate = DateTime.Parse(drv["actual_checkout_date"].ToString());
                }
                else
                {
                    dtpNgayCheckoutThucTe.SelectedDate = null;
                }
                txtTienCoc.Text = drv["deposit"].ToString();
                txtPhuPhi.Text = drv["surcharge"].ToString();
                txtGhiChu.Text = drv["note"].ToString() ;
                cbTrangThaiDatPhong.SelectedValue = drv["status"].ToString();
                cbNguoiDaiDienDatPhong.SelectedValue = drv["customer_id"].ToString() + "|" + drv["customer_name"].ToString();
                cbPhongCuaDatPhong.SelectedValue = drv["room_id"].ToString() + "|" + drv["room_name"].ToString();
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaDatPhong_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachDatPhong.SelectedValue;
            int bookingId =  (int)drv["booking_record_id"];
            bookingDao.Delete(bookingId);
            LayDanhSach();
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
                txtMoTaPhong.Text = drv["room_description"].ToString();
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

        private void cbLocTheoTinhTrangDatPhong_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string tinhTrangDatPhong = (string)cbLocTheoTinhTrangDatPhong.SelectedValue;
            if(tinhTrangDatPhong == "Chưa checkin")
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.LayDsHoSoChuaCheckin().DefaultView;
            } else if(tinhTrangDatPhong == "Đã checkin")
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.LayDsHoSoDaCheckin().DefaultView;
            } else if(tinhTrangDatPhong == "Bị hủy")
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.LayDsHoSoDaBiHuy().DefaultView;
            } else
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.layDanhSach().DefaultView;
            }
        }

        private void cbLocTheoTinhTrangCoc_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string tinhTranhCoc = (string)cbLocTheoTinhTrangCoc.SelectedValue;
            if(tinhTranhCoc == "Chưa đặt cọc")
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.LayDsHoSoChuaDatCoc().DefaultView;
            } else if(tinhTranhCoc == "Đã đặt cọc")
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.LayDsHoSoDaDatCoc().DefaultView;
            } else
            {
                dtgDanhSachDatPhong.ItemsSource = bookingDao.layDanhSach().DefaultView;
            }
        }

        private void btnThongTinLoaiPhong_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachLoaiPhong.SelectedValue;
            try
            {
                lbMaLoaiPhong.Content = drv["room_type_id"].ToString();
                txtTenLoaiPhong.Text = drv["room_type_name"].ToString();
                txtGiaLoaiPhong.Text = drv["price"].ToString();
                txtGiamGiaLoaiPhong.Text = drv["discount_room"].ToString();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaLoaiPhong_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinKhachDatPhong_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachKhachHangDatPhong.SelectedValue;
            try
            {
                cbKhachHangCuaKhachDatPhong.SelectedValue = drv["customer_id"].ToString() + "|" + drv["customer_name"].ToString();
                txtMaDatPhongKhachHang.Text = drv["booking_record_id"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaKhachDatPhong_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
