<?php
require 'phpqrcode.php'; // Biblioteca de QR Code

// URL base do seu servidor
$baseURL = "https://seudominio.com/vcard.php";

// Pega o ID do funcionário pela URL
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) {
    die("ID inválido.");
}

// Monta a URL do vCard
$link = $baseURL . "?id=" . $id;

// Gera o QR Code direto na tela
QRcode::png($link, false, QR_ECLEVEL_H, 8, 2);
