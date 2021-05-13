create table Realizador(
    Nome VARCHAR2(30),
    Telefone numeric(9,0),
    Primary key (Nome) 
);

create table Filme(
    nome_original VARCHAR2(20),
    nome_português VARCHAR2(20),
    duração_filmagens numeric(9,0),
    custo_total numeric(12,0), 
    Nome_Realizador VARCHAR2(20),  
    ano_lançamento date,

    Primary Key (nome_original),
    Foreign KEY (Nome_Realizador) REFERENCES Realizador(Nome)
);

create table Filme_Genero(
    nome_original VARCHAR2(20),
    genero VARCHAR2(20),
    PRIMARY key (nome_original, genero),
    Foreign Key (nome_original) references Filme(nome_original)
);

create table Cinema(
    Nome VARCHAR2(30),
    Localidade VARCHAR2(20),
    Primary key (Nome, Localidade) 
);

create table Ator(
    Numero_ID numeric(4,0),
    Nacionalidade VARCHAR2(20),
    data_nascimento date,
    sexo CHAR(1),
    email VARCHAR2(50),
    telefone numeric(9,0),
    telemovel numeric(9,0),
    
    Primary key (Numero_ID) 
);

CREATE TABLE ATOR_NOME_SS(
    Nome_artistico VARCHAR2(35) not null UNIQUE,
    Numero_ID numeric(4,0),
    Numero_SS VARCHAR2(12) not null UNIQUE,

    Primary key (Numero_ID) ,
    Foreign Key (Numero_ID) references Ator(Numero_ID)
);

CREATE TABLE Ator_Idade(
    Numero_ID numeric(4,0) primary key,
    Idade numeric(3,0),

    Foreign Key (Numero_ID) references Ator(Numero_ID)
);

create table Ator_É_Realizador(
    Numero_ID numeric(4,0),
    Nome VARCHAR2(30),
    
    PRIMARY KEY (Numero_ID),
    Foreign Key (Numero_ID) references Ator(Numero_ID),
    Foreign Key (Nome) references Realizador(Nome)
);

create table Ator_Aptidao (
      Aptidao varchar2(100),
      Numero_ID numeric(4,0),
      PRIMARY KEY (Aptidao, Numero_ID),
      Foreign key (Numero_ID) references Ator(Numero_ID)
);

create table Participa_Em(
     Numero_ID numeric(4,0),
     Nome_Original varchar(20),
     nome_Personagem varchar2(20),
     Cache numeric(10,0),

    PRIMARY KEY (Numero_ID, Nome_Original),
    Foreign key (Numero_ID) references Ator(Numero_ID),
    Foreign key (Nome_Original) references Filme(Nome_Original)

);

create table Estudio(
    Nome VARCHAR2(30),
    Morada VARCHAR2(50),
    Dono VARCHAR2(20),
    Numero_Porta numeric(2,0),
    data_fundação date,
    lucro numeric(16,0),
    PRIMARY KEY (nome)
);

CREATE TABLE Estudio_CodPostal(
    Nome_estudio VARCHAR2(20),
    cod_postal VARCHAR2(7),
    PRIMARY KEY (Nome_estudio),
    Foreign key (Nome_estudio) references Estudio(Nome)
);

CREATE TABLE Produzido_Por(
    Nome_Original VARCHAR2(20),
    Nome_estudio VARCHAR2(20),
    PRIMARY KEY (Nome_Original, Nome_estudio),
    
    Foreign key (Nome_estudio) references Estudio(nome),
    Foreign key (Nome_Original) references Filme(Nome_Original)
);

create table Distribuido_Por(
    nome_original VARCHAR2(20),
    Nome_Cinema VARCHAR2(20),
    Localidade varchar2(20),
   
    PRIMARY KEY (nome_original, Nome_Cinema, Localidade),
    
    Foreign key (Nome_Original) references Filme(nome_original),
    Foreign key (Nome_Cinema, Localidade) references Cinema(Nome, Localidade)
);

-- Parte 2
create table filme_log(
    nome_original VARCHAR2(20),
    custo_anterior numeric(12,0),
    custo_atual numeric(12,0),
    data_mod date,

    PRIMARY KEY (nome_original, data_mod),
    
    Foreign key (nome_original) references Filme(nome_original)
);

Alter table Ator ADD CONSTRAINT Sexo_Ator CHECK (sexo = 'M' OR sexo = 'F');

Alter table Filme MODIFY custo_total numeric(12,0) NOT NULL;
Alter table Filme ADD CONSTRAINT custo_total CHECK (custo_total > 0);

