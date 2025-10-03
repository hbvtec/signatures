*** Armazenando senha
<?php
// Exemplo de conexão (MySQLi)
$conn = new mysqli("localhost", "usuario", "senha", "meubanco");

// Dados recebidos do formulário
$usuario = "12345678901"; // pode ser CPF ou CNPJ
$senha   = "MinhaSenha123";

// Gera o hash seguro da senha
$senha_hash = password_hash($senha, PASSWORD_BCRYPT);

// Insere no banco
$sql = "INSERT INTO login (usuario, senha_hash, tipo) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$tipo = "PESSOA"; // ou "EMPRESA"
$stmt->bind_param("sss", $usuario, $senha_hash, $tipo);
$stmt->execute();

echo "Usuário cadastrado com sucesso!";
?>

***Conferindo senha
<?php
$conn = new mysqli("localhost", "usuario", "senha", "meubanco");

$usuario = "12345678901"; 
$senha_digitada = "MinhaSenha123";

// Busca o hash da senha no banco
$sql = "SELECT senha_hash FROM login WHERE usuario = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $usuario);
$stmt->execute();
$stmt->bind_result($senha_hash);
$stmt->fetch();

if ($senha_hash && password_verify($senha_digitada, $senha_hash)) {
    echo "✅ Login realizado com sucesso!";
} else {
    echo "❌ Usuário ou senha inválidos.";
}
?>

