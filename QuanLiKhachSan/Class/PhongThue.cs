using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace QuanLiKhachSan.Class
{
    public class PhongThue: Model
    {
        private int maPhongThue;
        private DateTime thoiGianCheckIn;
        private DateTime thoiGianCheckOut;
        private float phuPhi;
        private float tienCoc;
        private string ghiChu;
        private DateTime ngayDat;

        private PhongThue() { }

        public PhongThue(int maPhongThue, DateTime thoiGianCheckIn, DateTime thoiGianCheckOut, float phuPhi, float tienCoc, string ghiChu, DateTime ngayDat)
        {
            this.maPhongThue = maPhongThue;
            this.thoiGianCheckIn = thoiGianCheckIn;
            this.thoiGianCheckOut = thoiGianCheckOut;
            this.phuPhi = phuPhi;
            this.tienCoc = tienCoc;
            this.ghiChu = ghiChu;
            this.ngayDat = ngayDat;
        }

        public PhongThue(DateTime thoiGianCheckIn, DateTime thoiGianCheckOut, float phuPhi, float tienCoc, string ghiChu, DateTime ngayDat)
        {
            this.thoiGianCheckIn = thoiGianCheckIn;
            this.thoiGianCheckOut = thoiGianCheckOut;
            this.phuPhi = phuPhi;
            this.tienCoc = tienCoc;
            this.ghiChu = ghiChu;
            this.ngayDat = ngayDat;
        }

        public void thuePhong(Phong phong, KhachHang khachHang, DichVu? dichVu)
        {
            try
            {
                BookingRecordDao phongThueDAO = new BookingRecordDao();
                phongThueDAO.Insert(thoiGianCheckIn, thoiGianCheckOut, DateTime.Now, DateTime.Now, tienCoc, phuPhi,
                        ghiChu, "Chờ xác nhận", khachHang.MaKhachHang, phong.MaPhong);
            }catch(Exception ex)
            {
                Console.WriteLine(ex.ToString());
                MessageBox.Show("Không thể thuê phòng");
            }
        }

        public int MaPhongThue { get => maPhongThue; set => maPhongThue = value; }
        public DateTime ThoiGianCheckIn { get => thoiGianCheckIn; set => thoiGianCheckIn = value; }
        public DateTime ThoiGianCheckOut { get => thoiGianCheckOut; set => thoiGianCheckOut = value; }
        public float PhuPhi { get => phuPhi; set => phuPhi = value; }
        public float TienCoc { get => tienCoc; set => tienCoc = value; }
        public string GhiChu { get => ghiChu; set => ghiChu = value; }
        public DateTime NgayDat { get => ngayDat; set => ngayDat = value; }
    }
}
