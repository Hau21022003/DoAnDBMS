using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
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
    /// Interaction logic for UcNhanVien.xaml
    /// </summary>
    public partial class UcNhanVien : UserControl
    {
        EmployeeDao employeeDao = new EmployeeDao();
        AccountDao accountDao = new AccountDao();
        PhoneNumberOfEmployeeDao phoneDao = new PhoneNumberOfEmployeeDao(); 
        public UcNhanVien()
        {
            InitializeComponent();
        }

        public void LayDanhSach()
        {
            dtgDanhSachNhanVien.ItemsSource = employeeDao.LayDanhSach().DefaultView;
            dtgDanhSachTaiKhoan.ItemsSource = accountDao.LayDanhSach().DefaultView;
            dtgDanhSachSdtCuaNhanVien.ItemsSource = phoneDao.LayDanhSach().DefaultView;
            DataTable tb = employeeDao.LayDanhSachTenNhanVien();
            List<string> list = tb.AsEnumerable()
                                  .Select(x => x.Field<int>("employee_id").ToString() + "|" + x.Field<string>("employee_name"))
                                  .ToList<string>();
            cbNhanVienCuaSDT.ItemsSource = list;
            cbNhanVienCuaTaiKhoan.ItemsSource = list;
        }

        private void btnThongTinNhanVien_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachNhanVien.SelectedValue;
            try
            {
                lbMaNhanVien.Content = drv["employee_id"].ToString();
                txtTenNhanVien.Text = drv["employee_name"].ToString();
                cbGioiTinh.SelectedValue = drv["gender"].ToString();
                dtpNgaySinh.SelectedDate = DateTime.Parse(drv["birthday"].ToString());
                txtIdentifyCard.Text = drv["identify_card"].ToString();
                txtDiaChi.Text = drv["address"].ToString();
                txtEmail.Text = drv["email"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaNhanVien_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachNhanVien.SelectedValue;
            try
            {
                int employeeId = int.Parse(drv["employee_id"].ToString());
                employeeDao.Delete(employeeId);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThemNhanVien_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string employeeName = txtTenNhanVien.Text;
                string gender = cbGioiTinh.Text;
                DateTime? birthday = dtpNgaySinh.SelectedDate;
                string identifyCard = txtIdentifyCard.Text;
                string address = txtDiaChi.Text;
                string email = txtEmail.Text;
                employeeDao.Insert(employeeName, gender, birthday, identifyCard, address, email);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSuaNhanVien_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int employeeId = int.Parse((string)lbMaNhanVien.Content);
                string employeeName = txtTenNhanVien.Text;
                string gender = cbGioiTinh.Text;
                DateTime? birthday = dtpNgaySinh.SelectedDate;
                string identifyCard = txtIdentifyCard.Text;
                string address = txtDiaChi.Text;
                string email = txtEmail.Text;
                employeeDao.Update(employeeId, employeeName, gender, birthday, identifyCard, address, email);
                LayDanhSach();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSuaTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int accountId = int.Parse((string)lbMaTaiKhoan.Content);
                string username = txtTenTaiKhoan.Text;
                string password = txtMatKhau.Text;
                int employeeId = int.Parse(cbNhanVienCuaTaiKhoan.Text.Split("|")[0]);
                accountDao.Update(accountId, username, password, employeeId);
                LayDanhSach();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void btnThemTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string username = txtTenTaiKhoan.Text;
                string password = txtMatKhau.Text;
                int employeeId = int.Parse(cbNhanVienCuaTaiKhoan.Text.Split("|")[0]);
                accountDao.Insert(username, password, employeeId);
                LayDanhSach();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThongTinTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachTaiKhoan.SelectedValue;
            try
            {
                lbMaTaiKhoan.Content = drv["account_id"].ToString();
                txtTenTaiKhoan.Text = drv["username"].ToString();
                txtMatKhau.Text = drv["password"].ToString();
                cbNhanVienCuaTaiKhoan.SelectedValue = drv["employee_id"] + "|" + drv["employee_name"];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachTaiKhoan.SelectedValue;
            try
            {
                int accountId = int.Parse(drv["account_id"].ToString());
                accountDao.Delete(accountId);
                LayDanhSach();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThemSdtNhanVien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnSuaSdtNhanVien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnThongTinSdtNhanVien_Click(object sender, RoutedEventArgs e)
        {
            DataRowView drv = (DataRowView)dtgDanhSachSdtCuaNhanVien.SelectedValue;
            try
            {
                cbNhanVienCuaSDT.SelectedValue = drv["employee_id"].ToString() + "|" + drv["employee_name"].ToString();
                txtSDT.Text = drv["phone_number"].ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoaSdtNhanVien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnTimKiemTheoTenNhanVien_Click(object sender, RoutedEventArgs e)
        {
            string employeeName = txtLocTheoTenNhanVien.Text;
            dtgDanhSachNhanVien.ItemsSource = employeeDao.TimKiemTheoHoTen(employeeName).DefaultView;
        }
    }
}
