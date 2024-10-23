using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using MongoDB.Driver;
using MongoDB.Bson;

namespace CinemaKino
{
    public class conexionsql
    {
        public static string CadenaConexion { get; } =
             "Data Source=JOSE-J-SILVA;Initial Catalog=cinemakino;Integrated Security=True;";

        public static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CadenaConexion);
        }
    }

    
}
