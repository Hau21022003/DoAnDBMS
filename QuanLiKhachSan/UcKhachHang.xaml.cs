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
            cbKhachHangCuaSDT.ItemsSource = customerDao.LayDanhSachTenKhach().AsEnumerable()
                .Select(x => x.Field<int>("customer_id").ToString() + "|" + x.Field<string>("customer_name"))
                .ToList<string>();
        }

        private void btnThemKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaKhachHang_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinKhachHang_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachKhachHang.SelectedValue;
            try
            {
                lbMaKhachHang.Content = drv["customer_id"].ToString();
                txtTenKhachHang.Text = drv["customer_name"].ToString();
                cbGioiTinh.SelectedValue = drv["gender"].ToString();
                txtEmail.Text = drv["email"].ToString();
                dtpNgaySinh.SelectedDate = DateTime.Parse(drv["birthday"].ToString());
                txtIdentifyCard.Text = drv["identify_card"].ToString();
                txtDiaChi.Text = drv["address"].ToString();
                chbTrangThai.IsChecked = (bool)drv["status"];
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
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
            DataRowView drv = (DataRowView)dtgDanhSachSdtCuaKhach.SelectedValue;
            try
            {
                cbKhachHangCuaSDT.SelectedValue = drv["customer_id"].ToString() + "|" + drv["customer_name"].ToString();
                txtSDT.Text = drv["phone_number"].ToString();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);    
            }
        }

        private void btnXoaSdtKhach_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
