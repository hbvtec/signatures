-- drop database bdcard;

-- criar o banco de dados somente se não existir
CREATE DATABASE if NOT EXISTS bdcard
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci;

-- selecionar o banco
USE bdcard;

-- 1. Tabela de Login
CREATE TABLE if NOT EXISTS tblaccess (
	id_login		INT AUTO_INCREMENT PRIMARY KEY,
	cpf_cnpj		VARCHAR(20) UNIQUE NOT NULL, -- pode armazenar cpf ou cnpj
	-- pwd_hash		VARCHAR(255) NOT NULL, -- senha criptografada
	tipo			ENUM('F', 'J') DEFAULT 'F',
 	dt_inc		DATE DEFAULT CURRENT_DATE,
	dt_val		DATE NOT NULL,
	dt_ren		DATE DEFAULT CURRENT_DATE,
	ativo			ENUM('S', 'N') DEFAULT 'S'
) ENGINE=innodb;

-- 2. Pessoa Física
CREATE TABLE if NOT EXISTS tblpes (
	id_pes		INT AUTO_INCREMENT PRIMARY KEY,
	id_login		INT UNIQUE, -- cada pessoa física tem um login
	nome			VARCHAR(35) NOT NULL, -- N
	sobrenome	VARCHAR(15) NOT NULL, -- N
	nm_completo VARCHAR(50) NOT NULL, -- FN
	dt_nasc		DATE, -- BDAY
	photo			VARCHAR(150), -- caminho da foto no servidor : PHOTO
	FOREIGN KEY (id_login) REFERENCES tblaccess(id_login)
) ENGINE=innodb;

-- 3. Tabela de Estados Brasileiros
CREATE TABLE if NOT EXISTS tbluf (
	id_uf		INT AUTO_INCREMENT PRIMARY KEY,
	sigla		CHAR(2) NOT NULL, -- ADR
	nm_uf		VARCHAR(50) NOT NULL -- ADR
) ENGINE=innodb;

-- 4. Pessoa Jurídica (Empresas)
CREATE TABLE if NOT EXISTS tblemp (
	id_emp		INT AUTO_INCREMENT PRIMARY KEY,
	id_login		INT UNIQUE, -- cada empresa tem um login
	id_uf			INT NOT NULL,
	-- rsocial		varchar(150) not null,
	nm_emp		VARCHAR(150) NOT NULL, -- ORG
	Logradouro	VARCHAR(150), -- ADR
	numero		VARCHAR(6), -- ADR
	compl			VARCHAR(20), -- ADR	
	cidade		VARCHAR(20), -- ADR
	cep			VARCHAR(9), -- ADR
	logo			VARCHAR(150), -- caminho da imagem no servidor : não carrega no vcard. Aparece na página.
	FOREIGN KEY (id_login) REFERENCES tblaccess(id_login), FOREIGN KEY (id_uf) REFERENCES tbluf(id_uf)
) ENGINE=innodb;

-- 5. Funcionários (ligação entre Empresas e Pessoas)
CREATE TABLE if NOT EXISTS tblfun (
	id_fun		INT AUTO_INCREMENT PRIMARY KEY,
	id_pes		INT NOT NULL,
	id_emp		INT NOT NULL,
	setor			VARCHAR(30), -- ORG
	cargo			VARCHAR(100), -- TITLE
	dt_adm		DATE,
	dt_dem		DATE,
	ativo			ENUM('S', 'N') DEFAULT 'S',
	FOREIGN KEY (id_pes) REFERENCES tblpes(id_pes),
	FOREIGN KEY (id_emp) REFERENCES tblemp(id_emp),
	UNIQUE (id_pes, id_emp) -- evita duplicidade de vínculo
) ENGINE=innodb;

-- 6. Telefones de pessoas físicas
CREATE TABLE if NOT EXISTS tbltel (
	id_tel		INT AUTO_INCREMENT PRIMARY KEY,
	id_pes		INT,
	id_emp		INT,
	id_fun		INT,
	cod_pais1	VARCHAR(3) DEFAULT '+55',
	ddd_tel1		VARCHAR(2) NOT NULL, -- TEL
	numtel1		VARCHAR(10) NOT NULL, -- TEL
	tipotel1		ENUM('HOME', 'WORK') DEFAULT 'HOME', -- TYPE TEL
	zap1			ENUM('S', 'N') DEFAULT 'N',
	cod_pais2	VARCHAR(3) DEFAULT '+55',
	ddd_tel2		VARCHAR(2), -- TEL
	numtel2		VARCHAR(10), -- TEL
	tipotel2		ENUM('HOME', 'WORK'), -- TYPE TEL
	zap2			ENUM('S', 'N'),
	FOREIGN KEY (id_pes) REFERENCES tblpes(id_pes),
	FOREIGN KEY (id_emp) REFERENCES tblemp(id_emp),
	FOREIGN KEY (id_fun) REFERENCES tblfun(id_fun)
) ENGINE=INNODB;


-- 7. Tabela de e-mails
CREATE TABLE if NOT EXISTS tblmail (
	id_mail		INT AUTO_INCREMENT PRIMARY KEY,
	id_pes		INT,
	id_fun		INT,
	id_emp		INT,
	email			VARCHAR(100) NOT NULL,
	tipomail		ENUM('HOME', 'WORK') DEFAULT 'HOME', -- TYPE
	FOREIGN KEY (id_pes) REFERENCES tblpes(id_pes),
	FOREIGN KEY (id_fun) REFERENCES tblfun(id_fun),
	FOREIGN KEY (id_emp) REFERENCES tblemp(id_emp),
	UNIQUE (id_pes, id_emp)
) ENGINE=INNODB;

-- 8. Tabela de urls
CREATE TABLE if NOT EXISTS tblsite (
	id_site		INT AUTO_INCREMENT PRIMARY KEY,
	id_pes		INT,
	id_emp		INT,
	urlsite		VARCHAR(250) NOT NULL,
	tiposite		ENUM('HOME', 'WORK') DEFAULT 'HOME', -- TYPE
	FOREIGN KEY (id_pes) REFERENCES tblpes(id_pes),
	FOREIGN KEY (id_emp) REFERENCES tblemp(id_emp),
	UNIQUE (id_pes, id_emp)
) ENGINE=INNODB;

-- 9. Tabela de mídias sociais
CREATE TABLE if NOT EXISTS tblsocial (
	id_social	INT AUTO_INCREMENT PRIMARY KEY,
	id_pes		INT,
	id_emp		INT,
	midia1		VARCHAR(250),
	midia2		VARCHAR(250),
	midia3		VARCHAR(250),
	FOREIGN KEY (id_pes) REFERENCES tblpes(id_pes),
	FOREIGN KEY (id_emp) REFERENCES tblemp(id_emp)
) ENGINE=innodb;