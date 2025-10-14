use mysql;

GRANT ALL ON *.* TO root@'192.168.101.168' IDENTIFIED BY 'root';
GRANT ALL ON *.* TO root@'192.168.101.97' IDENTIFIED BY 'root';

use ABBR;

create table tblClientes (
	idCliente	int	not null primary key,
	nmCliente	varchar(40)
);

INSERT INTO tblClientes
values
(2, 'Helton'),
(3, 'Luiz');

DROP PROCEDURE IF EXISTS `spClientes_Sel`;

CREATE PROCEDURE `spClientes_Sel`(IN prmIdCliente INT)
BEGIN
	IF(prmIdCliente IS NULL) THEN
		SELECT	idCliente	as	'Código',
				nmCliente	as	'Nome'
		FROM	tblClientes;
		ELSE
			SELECT	idCliente	as	'Código',
					nmCliente	as	'Nome'
			FROM	tblClientes
			where	idCliente = prmIdCliente;
	END IF;
END;

call spClientes_Sel(null);