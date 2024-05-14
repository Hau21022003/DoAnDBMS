using QuanLiKhachSan.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace QuanLiKhachSan.Class
{
    public class Phong: Model
    {
        private int maPhong;
        private string tenPhong;
        private string status;
        private int sucChua;
        private string moTa;
        private int loaiPhongId;


        public Phong() { }

        public Phong(int maPhong, string tenPhong) {
            this.MaPhong = maPhong;
            this.TenPhong = tenPhong;
        }

        public Boolean kiemTraPhongTrong()
        {
            try
            {
                RoomDao roomDao = new RoomDao();
                Phong foundPhong = roomDao.GetPhongById(this.MaPhong);

                if (foundPhong == null || foundPhong.Status != "Trống")
                {
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        public int MaPhong { get => maPhong; set => maPhong = value; }
        public string TenPhong { get => tenPhong; set => tenPhong = value; }
        public string Status { get => status; set => status = value; }
        public int SucChua { get => sucChua; set => sucChua = value; }
        public string MoTa { get => moTa; set => moTa = value; }
        public int LoaiPhongId { get => loaiPhongId; set => loaiPhongId = value; }
    }
}
