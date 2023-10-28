<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="agoraVai.pages.Login" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html lang="pt-br">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - RX8Pay</title>
    <link rel="stylesheet" type="text/css" href="~/css/styles.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet" />

    <script src="../js/getUser.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <main>
            <div class="retangulo">
                <div class="retangulo_roxo">
                    <img src="../img/logo_paia__1_-removebg.png" alt="Logo RX8Pay" />
                </div>
                <div class="formulario">
                    <h1 class="frase">Olá,<br /><strong>Tudo bem?</strong></br></h1>
                    <h2><span>Entre&nbsp;</span> na sua conta</h2>
                    <form>
                        <label for="login">Login</label>
                        <asp:TextBox ID="login" runat="server" CssClass="input-padrao" required="required" />
                        <label for="password">Senha</label>
                        <asp:TextBox ID="senha" runat="server" CssClass="input-padrao" TextMode="Password" required="required" />
                        <a href="EsqueceuSenha.html" class="link__esqueci">Esqueci a senha</a>
                        <div id="MensagemErro" class="mensagem-erro" runat="server" visible="false">
                            LOGIN OU SENHA INCORRETOS
                        </div>
                        <asp:Button ID="EntrarButton" runat="server" Text="Entrar" CssClass="Entrar" OnClick="EntrarButton_Click" />
                        <a href="CriarConta.html" class="container__botao">Criar Conta</a>
                    </form>
                </div>
            </div>
        </main>
    </form>
</body>
</html>
