using MongoDB.Driver;
using System.Data.SqlClient;
using System.Runtime.InteropServices;
using static System.Runtime.InteropServices.JavaScript.JSType;


namespace CinemaKino
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                //List<Dato> datos = LeerCSV();
                List<Dato> datos = LeerTAB();
                Insertar(datos);
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }

        }
        private void Insertar(List<Dato> datos)
        {
            try
            {
                Dato dato = new Dato();
                dato.Agregar(datos);
                MessageBox.Show("Datos agregados correctamente :D");
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void Busqueda()
        {
            try
            {
                Dato dato = new Dato();
                dato = dato.Obtener("Joseito");

                MessageBox.Show(dato.FirstName + dato.LastName);
            }
            catch (Exception)
            {

                throw;
            }
        }

        private List<Dato> LeerTexto(string archivo, string delimitador)
        {
            try
            {
                string[] data = File.ReadAllLines(archivo);

                bool isHeader = true;
                List<Dato> datos = new List<Dato>();

                foreach (string line in data)
                {
                    if (isHeader)
                    {
                        isHeader = false;
                        continue;
                    }
                    var renglon = line.Split(delimitador);

                    DateOnly.TryParse(renglon[8], out DateOnly date);
                    TimeOnly.TryParse(renglon[9], out TimeOnly time);
                    decimal.TryParse(renglon[10], out decimal price);
                    int.TryParse(renglon[11], out int seat);
                    int.TryParse(renglon[12], out int cinemaRoom);

                    Dato dato = new Dato
                    {
                        FirstName = renglon[1],
                        LastName = renglon[2],
                        Email = renglon[3],
                        Phone = renglon[4],
                        Gender = renglon[5],
                        MovieGenres = renglon[6],
                        MovieTitle = renglon[7],
                        Date = date,
                        Time = time,
                        Price = price,
                        Seat = seat,
                        CinemaRoom = cinemaRoom
                    };

                    datos.Add(dato);
                }
                return datos;

            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<Dato> LeerCSV()
        {
            try
            {

                string archivo = "Archivos\\MOCK_DATA.csv";
                string delimitador = ",";
                List<Dato> datos = LeerTexto(archivo, delimitador);


                return datos;

            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<Dato> LeerTAB()
        {
            try
            {

                string archivo = "Archivos\\MOCK_DATA_TAB.txt";
                string delimitador = "\t";
                List<Dato> datos = LeerTexto(archivo, delimitador);


                return datos;

            }
            catch (Exception)
            {

                throw;
            }
        }



        private void button2_Click(object sender, EventArgs e)
        {
            Busqueda();
        }

        private List<Dato> LeerJson()
        {
            try
            {
                string data = File.ReadAllText("Archivos\\MOCK_DATA.json");
                var options = new System.Text.Json.JsonSerializerOptions();
                options.PropertyNameCaseInsensitive = true;

                var datosJson = System.Text.Json.JsonSerializer.Deserialize<List<DatoJson>>(data, options);

                List<Dato> datos = new List<Dato>();

                foreach (var datoJson in datosJson)
                {
                    Dato dato = new Dato();
                    dato.FirstName = datoJson.FirstName;
                    dato.LastName = datoJson.LastName;
                    datos.Add(dato);


                }
                return datos;



            }
            catch (Exception)
            {

                throw;
            }
        }
        private void btnJson_Click(object sender, EventArgs e)
        {
            try
            {
                //List<Dato> datos = LeerCSV();
                List<Dato> datos = LeerJson();
                //Insertar(datos);

            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
        }


        private void button3_Click(object sender, EventArgs e)
        {
            InsertarGenerosEnSql();
        }




        private void InsertarGenerosEnSql()
        {
            try
            {
                
                Dato dato = new Dato();
                List<string> generos = dato.ObtenerGenerosUnicos();

                using (SqlConnection conn = conexionsql.ObtenerConexion())
                {
                    conn.Open();
                    foreach (var genero in generos)
                    {
                        // Preparar el comando para insertar
                        string query = "INSERT INTO gender_movie (name_gender_movie) VALUES (@NameGenderMovie)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@NameGenderMovie", genero);

                        // Ejecutar el comando
                        cmd.ExecuteNonQuery();
                    }
                }
                MessageBox.Show("Géneros insertados en SQL Server correctamente.");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void InsertarPeliculasEnSql()
        {
            try
            {
                
                Dato dato = new Dato();
                
                var todosLosDatos = dato.ObtenerTodosDatos(); 

                using (SqlConnection conn = conexionsql.ObtenerConexion())
                {
                    conn.Open();

                    foreach (var item in todosLosDatos)
                    {
                        // Obtener el ID del género desde SQL Server
                        int? idGenero = ObtenerIdGenero(conn, item.MovieGenres);

                        // Insertar la película en la tabla movie
                        string query = "INSERT INTO movie (id_gender_movie, title_movie) VALUES (@IdGenderMovie, @TitleMovie)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@IdGenderMovie", idGenero.HasValue ? (object)idGenero.Value : DBNull.Value); // Si hay ID, lo usamos; si no, insertamos NULL
                        cmd.Parameters.AddWithValue("@TitleMovie", item.MovieTitle);

                        cmd.ExecuteNonQuery();
                    }
                }
                MessageBox.Show("Películas insertadas en SQL Server correctamente.");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private int? ObtenerIdGenero(SqlConnection conn, string nombreGenero)
        {
            try
            {
                // Preparar el comando para buscar el ID del género
                string query = "SELECT id_gender_movie FROM gender_movie WHERE name_gender_movie = @NameGenderMovie";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@NameGenderMovie", nombreGenero);

                // Ejecutar el comando y obtener el ID
                var resultado = cmd.ExecuteScalar();
                return resultado != null ? (int?)Convert.ToInt32(resultado) : null; // Retorna el ID o null si no se encontró
            }
            catch (Exception)
            {
                throw;
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            InsertarPeliculasEnSql();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            InsertarUsuariosEnSql();
        }

        private void InsertarUsuariosEnSql()
        {
            try
            {
                Dato dato = new Dato();
                var todosLosDatos = dato.ObtenerTodosDatos(); 

                using (SqlConnection conn = conexionsql.ObtenerConexion())
                {
                    conn.Open();

                    foreach (var item in todosLosDatos)
                    {
                       
                        string cleanPhone = item.Phone.Replace("-", ""); // Eliminar guiones

                        // Para depuración: imprimir el número limpio
                        if (string.IsNullOrWhiteSpace(cleanPhone))
                        {
                            MessageBox.Show($"El número de teléfono '{item.Phone}' solo contiene caracteres no numéricos.");
                            continue; // Saltar a la siguiente iteración
                        }

                        string query = "INSERT INTO [user] (firs_name_user, last_name_user, email_user, phone_user, gender_user) " +
                                       "VALUES (@FirstName, @LastName, @Email, @Phone, @Gender)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@FirstName", item.FirstName);
                        cmd.Parameters.AddWithValue("@LastName", item.LastName);
                        cmd.Parameters.AddWithValue("@Email", item.Email);
                        cmd.Parameters.AddWithValue("@Phone", cleanPhone); // Usar el número de teléfono limpio sin guiones
                        cmd.Parameters.AddWithValue("@Gender", item.Gender);

                        cmd.ExecuteNonQuery();
                    }
                }
                MessageBox.Show("Usuarios insertados en SQL Server correctamente.");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
