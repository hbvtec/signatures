-- criar o banco de dados somente se não existir
create database if not exists bdcard
	default character set utf8mb4
    default collate utf8mb4_general_ci;

-- selecionar o banco
use bdcard;

-- 1. tabela de login (genérica)
create table if not exists tblacesso (
    id_login	int auto_increment primary key,
    cpf_cnpj	varchar(20) unique not null,   -- pode armazenar cpf ou cnpj
    pwd_hash	varchar(255) not null,
    dt_inclusao	date default current_date,
	dt_validade	date not null,
	ativo		enum('S', 'N') default 'S'
) engine=innodb;

-- 2. pessoa física
create table if not exists tblpessoa (
    id_pessoa	int auto_increment primary key,
    id_login	int,  -- cada pessoa física tem um login
    nm_completo	varchar(50) not null,
    dt_nasc		date,
    foreign key (id_login) references tblacesso(id_login) on delete cascade
);

-- 3. empresa (pessoa jurídica)
create table if not exists tblempresa (
    id_empresa	int auto_increment primary key,
    id_login 	int unique, -- cada empresa tem um login
    rs			varchar(150) not null,
	nf			varchar(150) not null,
    foreign key (id_login) references tblacesso(id_login)
);

-- 4. funcionário (ligação entre pessoa física e empresa)
create table if not exists tblfunc (
    id_funcionario	int auto_increment primary key,
    id_pessoa		int not null,
    id_empresa		int not null,
	setor			varchar(30),
    cargo			varchar(100),
    data_admissao	date,
	ativo			enum('S', 'N') default 'S',
    foreign key (id_pessoa) references tblpessoa(id_pessoa),
    foreign key (id_empresa) references tblempresa(id_empresa),
    unique (id_pessoa, id_empresa) -- evita duplicidade de vínculo
);

create table if not exists tblpessoa (
	id_pessoa	int auto_increment primary key,
	id_login	int,
	foreign key (id_login) references tbllogin(id_login),
	foreign key (id_func) references tblfuncionario(id_func),
	nm_pessoa	varchar(30)	not null,
	dt_nasc		date not null,
	photo		varchar(16)
) engine=innodb;

create table if not exists tbltelefone (
	id_tel		int auto_increment primary key,
	foreign key (id_login) references tbllogin(id_login),
	tel1		varchar(11),
	tel2		varchar(11)
) engine=innodb;

create table if not exists tblemail (
	email1		varchar(50),
	email2		varchar(50),
) engine=innodb;

	midiasoc1	varchar(150),
	midiasoc2	varchar(150),
	midiasoc3	varchar(150),

create table if not exists tblacesso (
	id_acesso	int auto_increment primary key,
	usuario		varchar(14) unique not null,
	dt_inclusao	date not null,
	dt_validade	date not null,
	passwd		varchar(15) not null,
	ativo		enum('s', 'n') default 's'
) engine=innodb;


-- criar tabela de login
create table if not exists tbllogin (
    id_login	int		auto_increment	primary key,
    nmlogin varchar(20) not null,
    email varchar(100) unique not null,
    telefone varchar(20),
    criado_em timestamp default current_timestamp
) engine=innodb;

-- criar tabela de produtos
create table if not exists produtos (
    id_produto int auto_increment primary key,
    nome varchar(100) not null,
    preco decimal(10,2) not null,
    estoque int default 0
) engine=innodb;

-- criar tabela de pedidos
create table if not exists pedidos (
    id_pedido int auto_increment primary key,
    id_cliente int not null,
    data_pedido date not null,
    status enum('pendente','pago','enviado','cancelado') default 'pendente',
    foreign key (id_cliente) references clientes(id_cliente)
        on delete cascade
        on update cascade
) engine=innodb;

-- criar tabela de itens do pedido (relação n:n entre pedidos e produtos)
create table if not exists itens_pedido (
    id_item int auto_increment primary key,
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null,
    preco_unitario decimal(10,2) not null,
    foreign key (id_pedido) references pedidos(id_pedido)
        on delete cascade
        on update cascade,
    foreign key (id_produto) references produtos(id_produto)
        on delete restrict
        on update cascade
) engine=innodb;

-- criar tabela de clientes
create table if not exists clientes (
    id_cliente int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    telefone varchar(20),
    criado_em timestamp default current_timestamp
) engine=innodb;

-- criar tabela de produtos
create table if not exists produtos (
    id_produto int auto_increment primary key,
    nome varchar(100) not null,
    preco decimal(10,2) not null,
    estoque int default 0
) engine=innodb;

-- criar tabela de pedidos
create table if not exists pedidos (
    id_pedido int auto_increment primary key,
    id_cliente int not null,
    data_pedido date not null,
    status enum('pendente','pago','enviado','cancelado') default 'pendente',
    foreign key (id_cliente) references clientes(id_cliente)
        on delete cascade
        on update cascade
) engine=innodb;

-- criar tabela de itens do pedido (relação n:n entre pedidos e produtos)
create table if not exists itens_pedido (
    id_item int auto_increment primary key,
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null,
    preco_unitario decimal(10,2) not null,
    foreign key (id_pedido) references pedidos(id_pedido)
        on delete cascade
        on update cascade,
    foreign key (id_produto) references produtos(id_produto)
        on delete restrict
        on update cascade
) engine=innodb;


create table funcionarios (
    id int auto_increment primary key,
	cpf varchar(11) not null,
    nome varchar(100) not null,
    telefone1 varchar(20),
    telefone2 varchar(20),
    email varchar(100),
    url varchar(200),
    empresa varchar(150),
    cargo varchar(100),
    descricao text,
    social1 varchar(200),
    social2 varchar(200),
    foto varchar(200) -- caminho da foto no servidor
);

insert into funcionarios (cpf, nome, telefone1, telefone2, email, url, empresa, cargo, descricao, social1, social2, foto)
values (
	'99999999999',
    'maria silva',
    '+5511999999999',
    '+5511888888888',
    'maria.silva@empresa.com',
    'https://www.empresa.com',
    'minha empresa ltda',
    'gerente de projetos',
    'empresa especializada em soluções web.',
    'https://www.linkedin.com/in/mariasilva',
    'https://www.instagram.com/mariasilva',
    'fotos/maria.jpg'
);






