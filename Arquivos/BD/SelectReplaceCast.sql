select  cast(cod_barra as varchar(15))
        , des_produto
        , length(des_resumida) as Tamanho
        , des_resumida
        , replace(cast(vlr_venda1 as varchar(15)), '.', ',')
        , *
from    produto
where   flg_ativo = 'S'
and     length(des_resumida) > 27
order by tamanho, cod_barra, des_produto;

select   cod_empresa
         , cod_produto
         , cod_barra
         , des_resumida
         , des_produto
from     produto
where    flg_ativo = 'S'
and      length(des_produto) > 27;