-- 8.2.2.1
create or replace trigger genero_igual
before insert or update of genero on Filme_Genero
for each row
BEGIN
    :new.genero := UPPER(:new.genero);
END;

-- 8.2.2.3
create or replace trigger ator_idade
after insert or update of data_nascimento on Ator
for each row
WHEN (new.numero_ID > 0)
BEGIN
    INSERT INTO ator_idade VALUES (:new.numero_ID, trunc((Sysdate - :new.data_nascimento)/365.25));
END;

-- 8.3.1a
DECLARE
    valor Produzido_por.Nome_Estudio%TYPE;
    CURSOR cur_produzidoPor is select distinct Produzido_por.Nome_Estudio  
        from (((Produzido_por join Filme_Genero on Produzido_por.Nome_Original = Filme_Genero.Nome_Original) 
        JOIN Participa_em on Produzido_por.Nome_Original = Participa_em.Nome_Original) join ATOR_NOME_SS on Participa_em.Numero_ID = ATOR_NOME_SS.Numero_ID) 
        where Filme_Genero.genero = 'Fantasia' and ATOR_NOME_SS.Nome_Artistico = 'Ruan Carlos';
        
BEGIN
    OPEN cur_produzidoPor;
    LOOP
    FETCH cur_produzidoPor INTO valor;
    
    IF cur_produzidoPor%NOTFOUND THEN
        EXIT;
    END IF;
    
    Dbms_output.put_line(valor);
    END LOOP;
    CLOSE cur_produzidoPor;
END;

-- 8.3.1b
DECLARE
    nome Filme.nome_original%type;
BEGIN
    SELECT nome_original into nome
    FROM (SELECT Filme.nome_original, max(Filme.custo_total) as maximo
    FROM (Filme inner join Filme_Genero on Filme.nome_original = Filme_Genero.nome_original) where Filme_Genero.genero = 'Aventura' and Filme.Nome_Realizador = 'XPTO'
    group by Filme.nome_original 
    order by maximo desc) 
    where rownum < 2;
    dbms_output.put_line(nome);
END;



-- 8.2.3
create or replace trigger ator_idade
after insert or update of data_nascimento on Ator
for each row
WHEN (new.numero_ID > 0)
BEGIN
    INSERT INTO ator_idade VALUES (:new.numero_ID, trunc((Sysdate - :new.data_nascimento)/365.25));
END;


-- 8.3.2
create or replace trigger custo_log
before update of custo_total on Filme
for each row
begin
    insert into filme_log VALUES(:old.nome_original, :old.custo_total, :new.custo_total, sysdate());
end;

-- 8.3.3
update filme set custo_total=12 where nome_original='The godmother'

-- 8.3.4
create or replace procedure aniversarios_mes
AS
nome ator_nome_SS.nome_artistico%TYPE;
data ator.data_nascimento%TYPE;
dia int;
CURSOR cur_pessoas is select ator_nome_SS.nome_artistico, ator.data_nascimento
from ator join ator_nome_SS on ator.numero_ID = ator_nome_SS.numero_ID 
where EXTRACT(MONTH FROM data_nascimento) = EXTRACT(MONTH FROM SYSDATE);
BEGIN
    OPEN cur_pessoas;
    LOOP
    FETCH cur_pessoas into nome, data;
    IF cur_pessoas%NOTFOUND THEN
        EXIT;
    END IF;
    dia:=EXTRACT(DAY FROM DATA);
    dbms_output.put_line(nome||' faz anos dia '||dia);
    END LOOP;
    CLOSE cur_pessoas;
END;


BEGIN
DBMS_SCHEDULER.CREATE_JOB (
   job_name             => 'Aniversarios_schedule',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'BEGIN aniversarios_mes; END;',
   repeat_interval      => 'FREQ=MONTHLY; BYMONTHDAY=1',
   enabled              =>  TRUE,
   comments             => 'Aponta os aniversários do mês');
END;

