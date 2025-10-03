<?php
try {
    // Conexão PDO
    $pdo = new PDO("mysql:host=localhost;dbname=meubanco;charset=utf8mb4", "root", "");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Inicia a transação
    $pdo->beginTransaction();

    // 1) Inserir Pessoa
    $sqlPessoa = "INSERT INTO pessoa (nome, cpf, data_nascimento) 
                  VALUES (:nome, :cpf, :data_nascimento)";
    $stmt = $pdo->prepare($sqlPessoa);
    $stmt->execute([
        ':nome'            => "Maria Oliveira",
        ':cpf'             => "98765432100",
        ':data_nascimento' => "1992-08-20"
    ]);

    // Pega o ID gerado
    $idPessoa = $pdo->lastInsertId();

    // 2) Inserir Funcionário vinculado à Pessoa e Empresa
    $sqlFunc = "INSERT INTO funcionario (id_pessoa, id_empresa, cargo, data_admissao) 
                VALUES (:id_pessoa, :id_empresa, :cargo, :data_admissao)";
    $stmt = $pdo->prepare($sqlFunc);
    $stmt->execute([
        ':id_pessoa'     => $idPessoa,
        ':id_empresa'    => 1, // ID da empresa já existente
        ':cargo'         => "Engenheira de Software",
        ':data_admissao' => date("Y-m-d") // hoje
    ]);

    // Confirma a transação
    $pdo->commit();

    echo "✅ Pessoa cadastrada (ID: $idPessoa) e vinculada como funcionário.";
} catch (Exception $e) {
    // Se algo falhar, desfaz tudo
    $pdo->rollBack();
    echo "❌ Erro: " . $e->getMessage();
}
?>

Boa 👌
Vamos montar um exemplo completo em **PDO com transações**, para que se qualquer passo falhar, nada fique gravado no banco. Isso é importante quando você insere em múltiplas tabelas encadeadas (ex.: **pessoa** → **funcionário**).

---

## 🔹 Exemplo: Cadastro de Pessoa + Funcionário dentro de uma transação

```php
<?php
try {
    // Conexão PDO
    $pdo = new PDO("mysql:host=localhost;dbname=meubanco;charset=utf8mb4", "root", "");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Inicia a transação
    $pdo->beginTransaction();

    // 1) Inserir Pessoa
    $sqlPessoa = "INSERT INTO pessoa (nome, cpf, data_nascimento) 
                  VALUES (:nome, :cpf, :data_nascimento)";
    $stmt = $pdo->prepare($sqlPessoa);
    $stmt->execute([
        ':nome'            => "Maria Oliveira",
        ':cpf'             => "98765432100",
        ':data_nascimento' => "1992-08-20"
    ]);

    // Pega o ID gerado
    $idPessoa = $pdo->lastInsertId();

    // 2) Inserir Funcionário vinculado à Pessoa e Empresa
    $sqlFunc = "INSERT INTO funcionario (id_pessoa, id_empresa, cargo, data_admissao) 
                VALUES (:id_pessoa, :id_empresa, :cargo, :data_admissao)";
    $stmt = $pdo->prepare($sqlFunc);
    $stmt->execute([
        ':id_pessoa'     => $idPessoa,
        ':id_empresa'    => 1, // ID da empresa já existente
        ':cargo'         => "Engenheira de Software",
        ':data_admissao' => date("Y-m-d") // hoje
    ]);

    // Confirma a transação
    $pdo->commit();

    echo "✅ Pessoa cadastrada (ID: $idPessoa) e vinculada como funcionário.";
} catch (Exception $e) {
    // Se algo falhar, desfaz tudo
    $pdo->rollBack();
    echo "❌ Erro: " . $e->getMessage();
}
?>
```

---

## 🔹 Como funciona

1. **`$pdo->beginTransaction()`** → inicia a transação.
2. Insere a **pessoa**.
3. Recupera o ID gerado com `lastInsertId()`.
4. Usa esse ID no insert de **funcionário**.
5. Se tudo der certo → `commit()`.
6. Se qualquer coisa falhar (ex.: CPF duplicado, empresa inexistente) → `rollBack()` e nada é salvo.

---

👉 Quer que eu estenda esse exemplo para incluir também **cadastro de login junto (pessoa + login + funcionário)**, tudo dentro de uma única transação?

