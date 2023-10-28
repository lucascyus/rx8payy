<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pagamentos.aspx.cs" Inherits="agoraVai.pages.Pagamentos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Pagamentos - RX8Pay</title>
    <link rel="stylesheet" type="text/css" href="~/css/stylesPag.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet" />
    
    <script src="../js/getUser.js"></script> <!-- Código JavaScript para obter o usuário logado -->

</head>
<body>
    <form id="form1" runat="server">
            <div class="navbar"> <!-- Barra de navegação superior -->
                <ul>
                    <li><a href="Pagamentos.aspx" id="Pagamentos"><strong>Pagamentos</strong></a></li>
                    <li><a href="CadastroFuncionario.aspx">Cadastro de Funcionários</a></li>
                </ul>
                <div class="user-icon" id="userIcon" onclick="toggleUserPanel()">
                    <img src="../img/user_icon.png" alt="Ícone do Usuário" />
                </div>
            </div>
            <div id="userPanel" class="user-panel"> <!-- Painel para mostrar o usuário logado -->
                <div class="usuario">@<span id="userName" runat="server"></span></div>                
                <button class="botao-sair" onclick="logout()">Sair</button>
            </div>   
        <div class="funcionarios-panel"> <!-- Painel principal que mostra informações dos funcionários -->
            <h1 id="pag">Pagamentos</h1>
            <asp:Button ID="btnExportarTodosPDF" runat="server" Text="Exportar PDFs" OnClick="ExportarPDF_Click" CssClass="botao-pdf"/> <!--Botão para exportar pdf dos funcionários -->
            <asp:Button ID="btnGerarRelatorio" runat="server" Text="Gerar Relatório" OnClick="GerarRelatorio_Click" CssClass="botao-relatorio" /> <!--Botão para exportar um relatório da empresa -->
                <tbody>
                    <asp:Table ID="tabelaPagamentos" runat="server" CssClass="tabela-pagamentos"> <!-- Tabela que organiza os dados -->
                        <asp:TableHeaderRow> 
                            <asp:TableHeaderCell>Data de Admissão</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Nome</asp:TableHeaderCell>
                            <asp:TableHeaderCell>CPF</asp:TableHeaderCell>
                            <asp:TableHeaderCell>ID</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Cargo</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Salário Total</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Status de Pagamento</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
