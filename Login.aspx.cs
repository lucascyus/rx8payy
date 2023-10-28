using System;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace agoraVai.pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MensagemErro.Visible = false;
        }

        protected void EntrarButton_Click(object sender, EventArgs e)
        {
            string username = login.Text;
            string password = senha.Text;

            if (VerificarCredenciais(username, password)) //Lógica para verificar credencial e redirecionamento de página
            {
                UserContext.SetUser(username, username);
                Response.Redirect("Pagamentos.aspx");
            }
            else
            {
                // Credenciais incorretas
                MensagemErro.Visible = true;
            }
        }

        private bool VerificarCredenciais(string username, string password)
        {
            string connectionString = "string de conexão, existe no código original";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT COUNT(*) FROM tbl_login WHERE username = @username AND password = @password"; //Lógica para verificar credenciais

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", password);

                    int result = (int)command.ExecuteScalar();

                    if (result > 0)
                    {
                        return true; // Credenciais corretas
                    }
                }
            }
            return false; // Credenciais incorretas
        }
    }
}
