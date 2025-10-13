CREATE VIEW conspf AS
SELECT c.nome AS cliente, p.valor, p.data
FROM tblaccess	as l
JOIN clientes c ON c.id = p.cliente_id;
