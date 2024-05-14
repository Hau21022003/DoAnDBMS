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
        public static SqlConnection conn;
        public static SqlConnection connAdmin = new SqlConnection(@"Data Source=MONEY;Initial Catalog=HotelManagementSystem3;Integrated Security=True");

    }
}
