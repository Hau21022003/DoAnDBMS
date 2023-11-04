using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiKhachSan.DAO
{
    class DbConnection
    {
        public static SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnStr);
    }
}
