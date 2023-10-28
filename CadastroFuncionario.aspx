<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CadastroFuncionario.aspx.cs" Inherits="agoraVai.pages.CadastroFuncionario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Cadastro de Funcionários - RX8Pay</title>
    <link rel="stylesheet" type="text/css" href="~/css/styleCad.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet" />

    <script src="../js/salario.js"></script> <!--link do javascript que transfere o salário do código behind para a interface do usuário -->
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar"> <!-- Barra de navegação superior -->
                <ul>
                    <li><a href="Pagamentos.aspx" id="Pagamentos">Pagamentos</a></li>
                    <li><a href="CadastroFuncionario.aspx" id="CadastroFuncionarios"><strong>Cadastro de Funcionários</strong></a></li>
                </ul>
                <div class="user-icon" id="userIcon" onclick="toggleUserPanel()">
                    <img src="../img/user_icon.png" alt="Ícone do Usuário" />
                </div>
            </div>
            <div id="userPanel" class="user-panel"> <!-- Painel para mostrar o usuário logado -->
                <div class="usuario">@<span id="userName" runat="server"></span></div>                
                <button class="botao-sair" onclick="logout()">Sair</button>
            </div>  
    <asp:Panel ID="pnlCadastro" runat="server" CssClass="cadastro-panel">
        <h2>Cadastro de Funcionário</h2> 
        <form> <!-- Áreas de input para o preenchimento de dados -->
            <div class="form-group"> 
                        <label for="codigo">Código-chave</label> <!-- código chave do funcionário -->
                        <asp:TextBox ID="txtb_codigo" runat="server" type="text" style="width: 50px" ReadOnly="true"></asp:TextBox>
                    </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="nome">Nome Completo:</label>
                    <asp:TextBox ID="nome" runat="server" ClientIDMode="Static" CssClass="inline-inputs" style="width: 300px" MaxLength="100" MinLength="3" />
                </div>
                <div class="form-group">
                    <label for="nascimento">Data de Nascimento:</label> 
                    <label for="nascimentoInvalido" id="dataInvalida" runat="server" visible="false"></label>
                    <asp:TextBox ID="Nascimento" runat="server" type="date" CssClass="inline-inputs" style="width: 100px"></asp:TextBox>
                </div>
               
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <label for="cpfVinculado" id="cpfJaVinculado" runat="server" visible="false"></label>
                    <asp:TextBox ID="txtb_cpf" runat="server" ClientIDMode="Static" style="width: 150px" CssClass="inline-inputs" oninput="this.value = this.value.replace(/[^0-9]/g, '')" MaxLength="11" MinLength="11"/>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="rg">RG:</label>
                    <label for="rgInvalido" id="rgJaVinculado" runat="server" visible="false"></label>
                    <asp:TextBox ID="txtb_rg" runat="server" type="number" style="width: 80px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="sexo">Sexo:</label>
                    <asp:TextBox ID="txtb_sexo" runat="server" type="text" style="width: 100px" MaxLength="10"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="ctps">Ctps:</label>
                    <label for="ctpsVinculado" id="ctpsJaVinculado" runat="server" visible="false"></label>
                    <asp:TextBox ID="txtb_ctps" runat="server" type="number" style="width: 100px" MaxLength="8" MinLength="8"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="titulo">Título de Eleitor:</label>
                    <label for="tituloVinculado" id="tituloJaVinculado" runat="server" visible="false"></label>
                    <asp:TextBox ID="txtb_TituloEleitor" runat="server" type="text" style="width: 100px" MaxLength="12" MinLength="12"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="reservista">Reservista:</label>
                    <label for="reservista-vinculado" id="reservistaJaVinculado" visible="false">Já Vinculado</label>
                    <asp:TextBox ID="txtb_reservista" runat="server" type="text" style="width: 100px" MaxLength="12" MinLength="12"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="telefone">Telefone:</label>
                    <asp:TextBox ID="txtb_telefone" runat="server" type="number" style="width: 100px" MaxLength="11" MinLength="8"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <asp:TextBox ID="txtb_email" runat="server" type="email" style="width: 200px" MaxLength="30" MinLength="5"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="cep">CEP:</label>
                    <asp:TextBox ID="txtb_cep" runat="server" type="number" style="width: 100px" MaxLength="8" MinLength="8"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <asp:TextBox ID="txtb_endereco" runat="server" type="text" style="width: 500px" MaxLength="100" MinLength="3"></asp:TextBox>
            </div>
            <h2 class="dados-bancarios">Dados Bancários</h2>
            <div class="form-row">
                <div class="form-group">
                    <label for="banco">Nome do Banco:</label>
                    <asp:TextBox ID="txtb_banco" runat="server" type="text" style="width: 300px" MaxLength="100" MinLength="2"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="conta">Número da Conta:</label>
                    <label for="numero-vinculado" id="numeroJaVinculado" visible="false"></label>
                    <asp:TextBox ID="txtb_conta" runat="server" type="number" style="width: 100px" MaxLength="20" MinLength="5"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="numero">Número do Banco:</label>
                    <asp:TextBox ID="txtb_numero" runat="server" type="number" style="width: 150px" MaxLength="3" MinLength="3"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="agencia">Agência Bancária:</label>
                    <asp:TextBox ID="txtb_agencia" runat="server" type="number" style="width: 100px" MaxLength="5" MinLength="5"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="tipo">Tipo de Conta:</label>
                    <asp:TextBox ID="txtb_tipo" runat="server" type="text" style="width: 80px" MaxLength="20" MinLength="3"></asp:TextBox>
                </div>
            </div>
            <div class="form-row"> <!-- caixa de seleção do cargo -->
                <div class="form-group">
                    <asp:Label ID="lblCargo" runat="server" Text="Cargo:" AssociatedControlID="cargo" />
                    <asp:DropDownList ID="cargo" runat="server" OnSelectedIndexChanged="cargo_SelectedIndexChanged" AutoPostBack="true" style="width: 250px">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="Assistente Administrativo">Assistente Administrativo</asp:ListItem>
                        <asp:ListItem Text="Assistente de Vendas">Assistente de Vendas</asp:ListItem>
                        <asp:ListItem Text="Suporte ao Cliente">Suporte ao Cliente</asp:ListItem>
                        <asp:ListItem Text="Auxiliar de Estoque">Auxiliar de Estoque</asp:ListItem>
                        <asp:ListItem Text="Recepcionista">Recepcionista</asp:ListItem>
                        <asp:ListItem Text="Assistente de Marketing">Assistente de Marketing</asp:ListItem>
                        <asp:ListItem Text="Auxiliar de Contabilidade">Auxiliar de Contabilidade</asp:ListItem>
                        <asp:ListItem Text="Operador de Caixa">Operador de Caixa</asp:ListItem>
                        <asp:ListItem Text="Assistente de Recursos Humanos">Assistente de Recursos Humanos</asp:ListItem>
                        <asp:ListItem Text="Auxiliar de Limpeza">Auxiliar de Limpeza</asp:ListItem> 
                    </asp:DropDownList>
                    <br/>
                </div>
                <div class="form-group">
                        <asp:Label for="salario">Salário:</asp:Label>    
                        <asp:TextBox ID="txtb_salario" runat="server" type="text" style="width: 100px" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="admissao">Data de Admissão:</label> 
                    <asp:TextBox ID="txtb_admissao" runat="server" type="date" style="width: 100px"></asp:TextBox>
                </div>
            </div>
            <asp:Button ID="MeuBotao" runat="server" Text="Salvar" OnClick="MeuBotao_Click" />
        </form>
    </asp:Panel>
    </form>
</body>
</html>
