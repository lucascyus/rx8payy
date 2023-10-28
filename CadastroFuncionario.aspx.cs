using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace agoraVai.pages
{
    public partial class CadastroFuncionario : Page
    {
        private const string connectionString = "string de conexão com o banco de dados";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigoAleatorio = GerarCodigoAleatorio(5); //gerar id funcionario
                txtb_codigo.Text = codigoAleatorio;
            }
        }

        protected void MeuBotao_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime dataNascimento;
                if (DateTime.TryParse(Nascimento.Text, out dataNascimento))
                {
                    int idadeMinima = 18;
                    if (!VerificarIdade(dataNascimento, idadeMinima)) //verificar idade funcionario
                    {
                        dataInvalida.Visible = false;
                    }
                    else
                    {
                        dataInvalida.Visible = true;
                    }
                }

                if (!VerificarCpfVinculado(txtb_cpf.Text) && !VerificarRgVinculado(txtb_rg.Text) && !VerificarCtpsVinculado(txtb_ctps.Text) && !VerificarTituloVinculado(txtb_TituloEleitor.Text)) //verificar existência de dados no banco de dados
                {
                    InserirDados();
                }
                else
                {
                    if (VerificarCpfVinculado(txtb_cpf.Text))
                    {
                        cpfJaVinculado.Visible = true;
                    }
                    if (VerificarRgVinculado(txtb_rg.Text))
                    {
                        rgJaVinculado.Visible = true;
                    }
                    if (VerificarCtpsVinculado(txtb_ctps.Text))
                    {
                        ctpsJaVinculado.Visible = true;
                    }
                    if (VerificarTituloVinculado(txtb_TituloEleitor.Text))
                    {
                        tituloJaVinculado.Visible = true;
                    }
                }
            }
            catch (SqlException ex)
            {
                Response.Write("Erro de SQL: " + ex.ToString());
            }
            catch (Exception ex)
            {
                Response.Write("Erro geral: " + ex.ToString());
            }
        }

        private void InserirDados() //inserir dados do banco de dados
        {
            string codigo = txtb_codigo.Text;
            string nomeCompleto = nome.Text;
            string cpf = txtb_cpf.Text;
            string rg = txtb_rg.Text;
            string sexo = txtb_sexo.Text;
            string ctps = txtb_ctps.Text;
            string tituloEleitor = txtb_TituloEleitor.Text;
            string reservista = txtb_reservista.Text;
            string telefone = txtb_telefone.Text;
            string email = txtb_email.Text;
            string cep = txtb_cep.Text;
            string endereco = txtb_endereco.Text;

            DateTime dataAdmissao = DateTime.Parse(txtb_admissao.Text);
            DateTime proximoDia5 = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 5);

            TimeSpan diferenca = proximoDia5 - dataAdmissao;
            int diasAteProximoDia5 = diferenca.Days;

            string statusPagamento;

            if (diasAteProximoDia5 <= 0)
            {
                // O funcionário se cadastrou no dia 5 ou depois.
                // Defina o status como "Novo".
                statusPagamento = "Novo";
            }
            else
            {
                // Mais de 15 dias até o próximo dia 5.
                // Defina o status como "Não pago".
                statusPagamento = "Não pago";
            }

            string escolha = cargo.SelectedItem.Text.ToString();

            double salario = 0.00;
            //Definir o salário com base no cargo escolhido
            if (escolha == "Assistente Administrativo") 
            {
                salario = 2560.30;
            }
            if (escolha == "Assistente de Vendas")
            {
                salario = 1520.60;
            }

            if (escolha == "Suporte ao Cliente")
            {
                salario = 2100.50;
            }

            if (escolha == "Auxiliar de Estoque")
            {
                salario = 1340.12;
            }

            if (escolha == "Recepcionista")
            {
                salario = 1403.00;
            }

            if (escolha == "Assistente de Marketing")
            {
                salario = 1660.90;
            }

            if (escolha == "Auxiliar de Contabilidade")
            {
                salario = 2433.21;
            }

            if (escolha == "Operador de Caixa")
            {
                salario = 1413.00;
            }

            if (escolha == "Assistente de Recursos Humanos")
            {
                salario = 1890.06;
            }

            if (escolha == "Auxiliar de Limpeza")
            {
                salario = 1320.00;
            }

            using (SqlConnection connection = new SqlConnection(connectionString)) //Inserir dados no banco de dados
            {
                connection.Open();
                string query = "INSERT INTO tbl_funcionario (Id, Nome, DataNascimento, Cpf, Rg, Sexo, Ctps, TituloEleitor, Reservista, Telefone, Email, Endereco, Cargo, Salario, DataAdmissao, Cep, StatusPagamento) VALUES (@Id, @Nome, @DataNascimento, @Cpf, @Rg, @Sexo, @Ctps, @TituloEleitor, @Reservista, @Telefone, @Email, @Endereco, @Cargo, @Salario, @DataAdmissao, @Cep, @StatusPagamento)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", codigo);
                    command.Parameters.AddWithValue("@Nome", nomeCompleto);
                    command.Parameters.AddWithValue("@DataNascimento", Nascimento.Text);
                    command.Parameters.AddWithValue("@Cpf", cpf);
                    command.Parameters.AddWithValue("@Rg", rg);
                    command.Parameters.AddWithValue("@Sexo", sexo);
                    command.Parameters.AddWithValue("@Ctps", ctps);
                    command.Parameters.AddWithValue("@TituloEleitor", tituloEleitor);
                    command.Parameters.AddWithValue("@Reservista", reservista);
                    command.Parameters.AddWithValue("@Telefone", telefone);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Cep", cep);
                    command.Parameters.AddWithValue("@Endereco", endereco);
                    command.Parameters.AddWithValue("@Cargo", escolha);
                    command.Parameters.AddWithValue("@Salario", salario);
                    command.Parameters.AddWithValue("@DataAdmissao", txtb_admissao.Text);
                    command.Parameters.AddWithValue("@StatusPagamento", statusPagamento);
                    command.ExecuteNonQuery();
                }
            }
        }


        private bool VerificarIdade(DateTime dataNascimento, int idadeMinima) //Método de verificar a idade
        {
            int idade = DateTime.Now.Year - dataNascimento.Year;
            if (DateTime.Now.Month < dataNascimento.Month || (DateTime.Now.Month == dataNascimento.Month && DateTime.Now.Day < dataNascimento.Day))
            {
                idade--;
            }
            return idade >= idadeMinima;
        }

        private bool VerificarCpfVinculado(string cpf) //Verificar Cpf se já existente
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM tbl_funcionario WHERE Cpf = @Cpf";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Cpf", cpf);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool VerificarRgVinculado(string rg) //Verificar rg se já existente
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM tbl_funcionario WHERE Rg = @Rg";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Rg", rg);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool VerificarCtpsVinculado(string ctps) //Verificar ctps se já existente
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM tbl_funcionario WHERE Ctps = @Ctps";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Ctps", ctps);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool VerificarTituloVinculado(string tituloEleitor) //Verificar titulo se já existente
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM tbl_funcionario WHERE TituloEleitor = @TituloEleitor";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TituloEleitor", tituloEleitor);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private string GerarCodigoAleatorio(int tamanho) //Gerar código do funcionário
        {
            const string caracteresPermitidos = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            char[] codigo = new char[tamanho];
            for (int i = 0; i < tamanho; i++)
            {
                int indice = random.Next(caracteresPermitidos.Length);
                codigo[i] = caracteresPermitidos[indice];
            }
            return new string(codigo);
        }

        protected void cargo_SelectedIndexChanged(object sender, EventArgs e) //preencher o input da interface com base no salárioe escolhido
        {
            
            string escolha = cargo.SelectedItem.Text;
            double AssistenteAdministrativo = 2560.30;
            double AssistenteVendas = 1520.60;
            double SuporteCliente = 2100.50;
            double AuxiliarEstoque = 1340.12;
            double Recepcionista = 1403.00;
            double AssistenteMarketing = 1660.90;
            double AuxiliarContabilidade = 2433.21;
            double OperadorCaixa = 1413.00;
            double AssistenteRecursosHumanos = 1890.06;
            double AuxiliarLimpeza = 1320.00;

            if (escolha == "")
            {
                txtb_salario.Text = "";
            }

            if (escolha == "Assistente Administrativo")
            {
                txtb_salario.Text = "R$" + AssistenteAdministrativo.ToString("0.00");
            }

            if (escolha == "Assistente de Vendas")
            {
                txtb_salario.Text = "R$" + AssistenteVendas.ToString("0.00");
            }

            if (escolha == "Suporte ao Cliente")
            {
                txtb_salario.Text = "R$" + SuporteCliente.ToString("0.00");
            }

            if (escolha == "Auxiliar de Estoque")
            {
                txtb_salario.Text = "R$" + AuxiliarEstoque.ToString("0.00");
            }

            if (escolha == "Recepcionista")
            {
                txtb_salario.Text = "R$" + Recepcionista.ToString("0.00");
            }

            if (escolha == "Assistente de Marketing")
            {
                txtb_salario.Text = "R$" + AssistenteMarketing.ToString("0.00");
            }

            if (escolha == "Auxiliar de Contabilidade")
            {
                txtb_salario.Text = "R$" + AuxiliarContabilidade.ToString("0.00");
            }

            if (escolha == "Operador de Caixa")
            {
                txtb_salario.Text = "R$" + OperadorCaixa.ToString("0.00");
            }

            if (escolha == "Assistente de Recursos Humanos")
            {
                txtb_salario.Text = "R$" + AssistenteRecursosHumanos.ToString("0.00");
            }

            if (escolha == "Auxiliar de Limpeza")
            {
                txtb_salario.Text = "R$" + AuxiliarLimpeza.ToString("0.00");
            }
        }
    }
}
