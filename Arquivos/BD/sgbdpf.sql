-- Criar o banco de dados somente se não existir
create database if not exists sgbdpf
	default character set utf8mb4
    default collate utf8mb4_general_ci;

-- Selecionar o banco
use sgbdpf;

create table if not exists tblpessoa (
	id_pessoa	int auto_increment primary key,
	cpf			varchar(11)	unique not null,
	nm_pessoa	varchar(30)	not null,
	dt_nasc		date not null,
	photo		varchar(16),
	codcountry	varchar(3) not null,
	tel1		varchar(11),
	tel2		varchar(11),
	email1		varchar(50),
	email2		varchar(50),
	midiasoc1	varchar(150),
	midiasoc2	varchar(150),
	midiasoc3	varchar(150),
	dt_inclusao	date not null,
	dt_validade	date not null,
	passwd		varchar(15) not null,
	ativo		enum('S', 'N') default 'S'
) ENGINE=InnoDB;

create table if not exists tblacesso (
	id_acesso	int auto_increment primary key,
	usuario		varchar(14) unique not null,
	dt_inclusao	date not null,
	dt_validade	date not null,
	passwd		varchar(15) not null,
	ativo		enum('S', 'N') default 'S'
) engine=InnoDB;


-- Criar tabela de login
CREATE TABLE IF NOT EXISTS tbllogin (
    id_login	int		auto_increment	primary key,
    nmLogin VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Criar tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
) ENGINE=InnoDB;

-- Criar tabela de pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('pendente','pago','enviado','cancelado') DEFAULT 'pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Criar tabela de itens do pedido (relação N:N entre pedidos e produtos)
CREATE TABLE IF NOT EXISTS itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Criar tabela de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Criar tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
) ENGINE=InnoDB;

-- Criar tabela de pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('pendente','pago','enviado','cancelado') DEFAULT 'pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Criar tabela de itens do pedido (relação N:N entre pedidos e produtos)
CREATE TABLE IF NOT EXISTS itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


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

