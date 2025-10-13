
CREATE TABLE tbluf (
    id_uf	INT AUTO_INCREMENT PRIMARY KEY,
    sigla	CHAR(2) NOT NULL, -- ADR
    nm_uf	VARCHAR(50) NOT NULL -- ADR
) engine=innodb;

INSERT INTO tbluf
	(sigla, nmuf)
VALUES
	('AC','Acre'),
	('AL','Alagoas'),
	('AM','Amazonas'),
	('AP','Amapá'),
	('BA','Bahia'),
	('CE','Ceará'),
	('DF','Distrito Federal'),
	('ES','Espírito Santo'),
	('GO','Goiás'),
	('MA','Maranhão'),
	('MT','Mato Grosso'),
	('MS','Mato Grosso do Sul'),
	('MG','Minas Gerais'),
	('PA','Pará'),
	('PB','Paraíba'),
	('PR','Paraná'),
	('PE','Pernambuco'),
	('PI','Piauí'),
	('RJ','Rio de Janeiro'),
	('RN','Rio Grande do Norte'),
	('RS','Rio Grande do Sul'),
	('RO','Rondônia'),
	('RR','Roraima'),
	('SC','Santa Catarina'),
	('SP','São Paulo'),
	('SE','Sergipe'),
	('TO','Tocantins');

--

CREATE TABLE tblcity (
    id_city	INT AUTO_INCREMENT PRIMARY KEY,
    id_uf	INT NOT NULL,
    nm_city	VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_uf) REFERENCES tbluf(id_uf)
) engine=innodb;
