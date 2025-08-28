<?php
// ------------------------------------
// CONFIGURAÇÕES DO CONTATO
// ------------------------------------
$nome       = "João da Silva";
$telefone1  = "+5511999999999";
$telefone2  = "+5511888888888";
$email      = "joao.silva@example.com";
$url        = "https://www.meusite.com";
$empresa    = "Minha Empresa Ltda";
$cargo      = "Desenvolvedor";
$descricao  = "Empresa especializada em soluções web.";
$social1    = "https://www.linkedin.com/in/joaosilva";
$social2    = "https://www.instagram.com/joaosilva";
$caminhoFoto = "foto.jpg"; // Foto original (JPEG ou PNG)

// ------------------------------------
// FUNÇÃO PARA REDIMENSIONAR E CODIFICAR FOTO EM BASE64
// ------------------------------------
function otimizarFoto($arquivo, $maxLado = 400, $qualidade = 85) {
    // Detecta tipo da imagem
    $ext = strtolower(pathinfo($arquivo, PATHINFO_EXTENSION));
    if ($ext === "png") {
        $img = imagecreatefrompng($arquivo);
        $tipo = "PNG";
    } else {
        $img = imagecreatefromjpeg($arquivo);
        $tipo = "JPEG";
    }

    // Obtém dimensões originais
    $largura = imagesx($img);
    $altura  = imagesy($img);

    // Calcula proporção (mantendo 3x4, 16x9, etc.)
    if ($largura > $altura) {
        $novaLargura = $maxLado;
        $novaAltura  = intval($altura * ($maxLado / $largura));
    } else {
        $novaAltura  = $maxLado;
        $novaLargura = intval($largura * ($maxLado / $altura));
    }

    // Redimensiona proporcionalmente
    $imgReduzida = imagescale($img, $novaLargura, $novaAltura);

    // Salva em memória com compressão
    ob_start();
    if ($tipo === "PNG") {
        imagepng($imgReduzida, null, 6); // compressão PNG (0-9)
    } else {
        imagejpeg($imgReduzida, null, $qualidade);
    }
    $fotoBytes = ob_get_clean();

    // Converte para Base64
    $fotoBase64 = base64_encode($fotoBytes);

    // Quebra em linhas de 75 caracteres (padrão vCard)
    $fotoQuebrada = trim(chunk_split($fotoBase64, 75, "\n "));

    return [$fotoQuebrada, $tipo];
}

// ------------------------------------
// PROCESSA A FOTO
// ------------------------------------
list($fotoCodificada, $tipoFoto) = otimizarFoto($caminhoFoto);

// ------------------------------------
// MONTA O VCARD
// ------------------------------------
$vcard = "BEGIN:VCARD\n";
$vcard .= "VERSION:3.0\n";
$vcard .= "FN:$nome\n";
$vcard .= "TEL;TYPE=CELL:$telefone1\n";
if (!empty($telefone2)) $vcard .= "TEL;TYPE=CELL:$telefone2\n";
$vcard .= "EMAIL:$email\n";
if (!empty($url)) $vcard .= "URL:$url\n";
$vcard .= "ORG:$empresa\n";
$vcard .= "TITLE:$cargo\n";
$vcard .= "NOTE:$descricao\n";
$vcard .= "PHOTO;ENCODING=b;TYPE=$tipoFoto:$fotoCodificada\n";
if (!empty($social1)) $vcard .= "X-SOCIALPROFILE:$social1\n";
if (!empty($social2)) $vcard .= "X-SOCIALPROFILE:$social2\n";
$vcard .= "END:VCARD\n";

// ------------------------------------
// SALVA O ARQUIVO
// ------------------------------------
file_put_contents("contato.vcf", $vcard);

echo "✅ vCard criado com sucesso: contato.vcf\n";
?>
