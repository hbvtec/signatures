// https://seudominio.com/qrcode.php?id=3

// https://seudominio.com/vcard.php?id=3


<?php
// ------------------------------------
// CONFIGURAÇÕES DE BANCO
// ------------------------------------
$host = "localhost";
$user = "usuario";
$pass = "senha";
$db   = "meubanco";

// Conectar ao MySQL
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Erro ao conectar: " . $conn->connect_error);
}

// ------------------------------------
// PEGA ID DA URL
// ------------------------------------
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) {
    die("ID inválido.");
}

// ------------------------------------
// BUSCA FUNCIONÁRIO NO BANCO
// ------------------------------------
$sql = "SELECT * FROM funcionarios WHERE id = $id";
$result = $conn->query($sql);

if ($result->num_rows === 0) {
    die("Funcionário não encontrado.");
}

$dados = $result->fetch_assoc();

// ------------------------------------
// FUNÇÃO PARA REDIMENSIONAR FOTO
// ------------------------------------
function otimizarFoto($arquivo, $maxLado = 400, $qualidade = 85) {
    if (!file_exists($arquivo)) return ["", "JPEG"]; // evita erro se não houver foto

    $ext = strtolower(pathinfo($arquivo, PATHINFO_EXTENSION));
    if ($ext === "png") {
        $img = imagecreatefrompng($arquivo);
        $tipo = "PNG";
    } else {
        $img = imagecreatefromjpeg($arquivo);
        $tipo = "JPEG";
    }

    $largura = imagesx($img);
    $altura  = imagesy($img);

    if ($largura > $altura) {
        $novaLargura = $maxLado;
        $novaAltura  = intval($altura * ($maxLado / $largura));
    } else {
        $novaAltura  = $maxLado;
        $novaLargura = intval($largura * ($maxLado / $altura));
    }

    $imgReduzida = imagescale($img, $novaLargura, $novaAltura);

    ob_start();
    if ($tipo === "PNG") {
        imagepng($imgReduzida, null, 6);
    } else {
        imagejpeg($imgReduzida, null, $qualidade);
    }
    $fotoBytes = ob_get_clean();

    $fotoBase64 = base64_encode($fotoBytes);
    return [trim(chunk_split($fotoBase64, 75, "\n ")), $tipo];
}

// ------------------------------------
// PROCESSA FOTO
// ------------------------------------
list($fotoCodificada, $tipoFoto) = otimizarFoto($dados['foto']);

// ------------------------------------
// MONTA VCARD
// ------------------------------------
$vcard = "BEGIN:VCARD\n";
$vcard .= "VERSION:3.0\n";
$vcard .= "FN:{$dados['nome']}\n";
if (!empty($dados['telefone1'])) $vcard .= "TEL;TYPE=CELL:{$dados['telefone1']}\n";
if (!empty($dados['telefone2'])) $vcard .= "TEL;TYPE=CELL:{$dados['telefone2']}\n";
if (!empty($dados['email'])) $vcard .= "EMAIL:{$dados['email']}\n";
if (!empty($dados['url'])) $vcard .= "URL:{$dados['url']}\n";
if (!empty($dados['empresa'])) $vcard .= "ORG:{$dados['empresa']}\n";
if (!empty($dados['cargo'])) $vcard .= "TITLE:{$dados['cargo']}\n";
if (!empty($dados['descricao'])) $vcard .= "NOTE:{$dados['descricao']}\n";
if (!empty($fotoCodificada)) $vcard .= "PHOTO;ENCODING=b;TYPE=$tipoFoto:$fotoCodificada\n";
if (!empty($dados['social1'])) $vcard .= "X-SOCIALPROFILE:{$dados['social1']}\n";
if (!empty($dados['social2'])) $vcard .= "X-SOCIALPROFILE:{$dados['social2']}\n";
$vcard .= "END:VCARD\n";

// ------------------------------------
// DOWNLOAD AUTOMÁTICO
// ------------------------------------
header('Content-Type: text/vcard; charset=utf-8');
header("Content-Disposition: attachment; filename=\"{$dados['nome']}.vcf\"");
echo $vcard;
exit;
?>
