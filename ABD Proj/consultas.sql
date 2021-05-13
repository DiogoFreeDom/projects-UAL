--A
select distinct Produzido_por.Nome_Estudio from (((Produzido_por join Filme_Genero on Produzido_por.Nome_Original = Filme_Genero.Nome_Original)
join Participa_em on Produzido_por.Nome_Original = Participa_em.Nome_Original) join ATOR_NOME_SS on Participa_em.Numero_ID = ATOR_NOME_SS.Numero_ID)
where Filme_Genero.genero = 'Fantasia' and ATOR_NOME_SS.Nome_Artistico = 'Ruan Carlos';

--B
select ATOR_Nome_SS.Nome_Artistico, Participa_em.cache FROM (ATOR_nome_SS JOIN ATOR on ATOR_NOME_SS.Numero_ID = ATOR.Numero_ID)
JOIN Participa_em on ATOR.Numero_ID = Participa_em.Numero_ID
Where Participa_em.Nome_Original = 'Batman vs Iron Man'
Order by cache desc;

--C
SELECT nome_original
FROM 
(
SELECT Filme.nome_original, max(Filme.custo_total) as maximo
FROM (Filme inner join Filme_Genero on Filme.nome_original = Filme_Genero.nome_original) where Filme_Genero.genero = 'Aventura' and Filme.Nome_Realizador = 'XPTO'
group by Filme.nome_original 
order by maximo desc
) where rownum = 1;


--D
select ator_é_realizador.nome, Filme.Nome_Original from (Ator_é_realizador join Participa_em on Ator_é_realizador.Numero_ID = Participa_em.Numero_ID) 
join filme on Participa_em.Nome_Original = Filme.Nome_Original 
where Filme.Nome_Realizador = Ator_é_realizador.nome or ator_é_realizador.Numero_ID = Participa_em.Numero_ID;

--E
SELECT Produzido_Por.Nome_Original FROM Produzido_por JOIN Distribuido_por on Produzido_por.Nome_Original = Distribuido_por.Nome_Original
WHERE Produzido_Por.Nome_estudio = '20th Century Fox' and Distribuido_por.localidade = 'Oeiras' and Distribuido_por.nome_cinema = 'Luso mundo';
