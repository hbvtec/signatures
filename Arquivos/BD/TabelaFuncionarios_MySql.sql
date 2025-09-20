CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
	cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone1 VARCHAR(20),
    telefone2 VARCHAR(20),
    email VARCHAR(100),
    url VARCHAR(200),
    empresa VARCHAR(150),
    cargo VARCHAR(100),
    descricao TEXT,
    social1 VARCHAR(200),
    social2 VARCHAR(200),
    foto VARCHAR(200) -- caminho da foto no servidor
);

INSERT INTO funcionarios (cpf, nome, telefone1, telefone2, email, url, empresa, cargo, descricao, social1, social2, foto)
VALUES (
	'99999999999',
    'Maria Silva',
    '+5511999999999',
    '+5511888888888',
    'maria.silva@empresa.com',
    'https://www.empresa.com',
    'Minha Empresa Ltda',
    'Gerente de Projetos',
    'Empresa especializada em soluções web.',
    'https://www.linkedin.com/in/mariasilva',
    'https://www.instagram.com/mariasilva',
    'fotos/maria.jpg'
);

