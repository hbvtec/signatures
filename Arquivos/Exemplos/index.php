<?php
// Define página padrão
$page = "home";

// Captura a rota amigável (ex: site.com/sobre)
if (isset($_GET['page'])) {
    $page = $_GET['page'];
}

// Caminho do arquivo correspondente
$file = __DIR__ . "/pages/" . $page . ".php";

// Se existir a página, carrega. Se não, mostra 404.
if (file_exists($file)) {
    include __DIR__ . "/includes/header.php";
    include $file;
    include __DIR__ . "/includes/footer.php";
} else {
    include __DIR__ . "/includes/header.php";
    echo "<h1>Página não encontrada</h1>";
    include __DIR__ . "/includes/footer.php";
}
