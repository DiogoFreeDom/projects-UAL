  
create table Proprietário(
    CC varchar2(15) primary key,
    nome varchar2(10) not null,
    morada_rua varchar2(20),
    morada_número varchar2(4),
    morada_cod_postal varchar2(8) not null,
    morada_localidade varchar2(15) not null,
    morada_concelho varchar2(15) not null,
    sexo char(1) not null,
    data_nasc date not null,
    idade varchar2(3) not null );
    
create table Proprietário_Telefone(
    CC varchar2(15),
    Telefone numeric(9,0),
    Primary Key (Telefone, CC),
    Foreign Key (CC) references Proprietário(CC) );

create table Modelo(
    cod_model varchar2(6) primary key,
    modelo varchar2(10) );

create table Categoria(
    cod_cat varchar2(6) primary key,
    nome varchar2(10) );

create table Tipo_de_Infração(
    cód_inf varchar2(6) primary key,
    multa numeric(5,0),
    nome varchar2(10) );

create table Local(
    código varchar2(7) primary key,
    pos_geo varchar2(15) not null,
    v_permitida varchar2(3) not null );
    
create table Agente(
    cod_id varchar2(7) primary key,
    nome varchar2(10) not null,
    data_contrato date,
    tempo_serviço varchar2(10) );

create table Veículo(
    matrícula char(8) primary key,
    chassi varchar2(20)  not null,
    cor varchar2(10) not null,
    ano_fab varchar(4) not null,
    CC_Propreitário varchar2(15) not null,
    Cod_Modelo varchar2(6) not null,
    Cod_Categoria varchar2(6) not null,
    Foreign Key (CC_Propreitário) references Proprietário (CC),
    Foreign Key (Cod_Modelo) references Modelo(cod_model),
    Foreign Key (Cod_Categoria) references Categoria(cod_cat) );

create table Infração(
    cód_inf varchar2(6) ,
    matrícula_Veículo char(8) ,
    código_Local varchar2(7) ,
    cod_id_Agente varchar2(7) ,
    data date not null,
    v_veículo varchar2(3) not null,
    Primary Key (cód_inf, matrícula_Veículo),
    Foreign Key (cód_inf) references Tipo_de_Infração(cód_inf),
    Foreign Key (matrícula_Veículo) references Veículo(matrícula),
    Foreign Key (código_Local) references Local(código) ,
    Foreign Key (cod_id_Agente) references Agente(cod_id) );
     
insert into Agente values('1234','Xerife','1-1-2018','1 ano');
insert into Agente values('2345','Woody','1-10-2017','1 ano');
insert into Agente values('3456','Caricas','12-23-2010','8 anos');
insert into Agente values('4567','Slowpoke','1-25-1999','19 anos');
insert into Agente values('5678','Andrade','12-10-2005','13 anos');
insert into Agente values('6789','Leonel','5-20-2007','11 anos');
insert into Agente values('7890','Fiona','6-30-2012','6 anos');
insert into Agente values('8901','Penas','12-31-2017','1 ano');
insert into Agente values('9012','Mateus','10-10-2010','8 anos');
insert into Agente values('1111','Bala','12-21-2013','5 anos');
insert into Agente values('3636','Bugalho','8-13-1988','30 anos');

insert into Modelo values('1','Citroen');
insert into Modelo values('2','Peugeot');
insert into Modelo values('3','Honda');
insert into Modelo values('4','Toyota');
insert into Modelo values('5','Fiat');
insert into Modelo values('6','Ferrari');
insert into Modelo values('7','Mercedes');
insert into Modelo values('8','Opel');
insert into Modelo values('9','Seat');
insert into Modelo values('10','Subaru');
insert into Modelo values('11','Audi');

insert into Categoria values('1','Classe 1');
insert into Categoria values('2','Classe 2');
insert into Categoria values('3','Classe 3');
insert into Categoria values('4','Classe 4');

insert into Tipo_de_Infração values('1',100,'Excesso');
insert into Tipo_de_Infração values('2',500,'Álcool');
insert into Tipo_de_Infração values('3',1000,'Drogas');
insert into Tipo_de_Infração values('4',50,'Acidente');
insert into Tipo_de_Infração values('5',150,'Batida');
insert into Tipo_de_Infração values('6',275,'Telemóvel');
insert into Tipo_de_Infração values('7',200,'Excesso');
insert into Tipo_de_Infração values('8',350,'Álcool');
insert into Tipo_de_Infração values('9',123,'Remédios');
insert into Tipo_de_Infração values('10',5000,'Drogas');
insert into Tipo_de_Infração values('11',100,'Batida');

insert into Local values('12345','Baixa','50');
insert into Local values('23456','Chiado','50');
insert into Local values('34567','Rossio','50');
insert into Local values('45678','Oriente','80');
insert into Local values('56789','Chelas','50');
insert into Local values('67890','Entrecampos','30');
insert into Local values('78901','Sete Rios','50');
insert into Local values('89010','Benfica','70');
insert into Local values('11111','Campolide','40');
insert into Local values('22222','Ponte','120');
insert into Local values('34561','Cascais','50');

insert into Proprietário values('123456789','António','Rua 1','20','1111-222','Rossio','Lisboa','M', '1-20-1990','28');
insert into Proprietário values('234567891','Manel','Rua J','15','2222-333','Reboleira','Amadora','M', '12-25-1990','28');
insert into Proprietário values('345678901','Joaquim','Rua JK','16','3333-222','Amadora','Amadora','M', '1-1-1999','20');
insert into Proprietário values('567890123','Maria','Rua SIM','60','3333-444','Estoril','Estoril','F', '7-25-1995','23');
insert into Proprietário values('678901234','Marta','Rua 30','80','4444-333','Oeiras','Oeiras','F', '3-18-1950','68');
insert into Proprietário values('789012345','Jorge','Praça Janeiro','66','4444-555','Belém','Lisboa','M', '8-8-1988','30');
insert into Proprietário values('890123456','Josué','Avenida Cruz','75','5555-444','Saldanha','Lisboa','M', '6-16-1996','22');
insert into Proprietário values('901234567','Ana','Rua Barco','2','5555-777','Chiado','Lisboa','F', '12-12-1982','36');
insert into Proprietário values('000000001','Shrek','A1 Norte','100','7777-888','Sacavém','Lisboa','M', '5-20-2000','18');
insert into Proprietário values('012345678','Ariel','Rua 16','10','7777-123','Sintra','Sintra','F', '10-31-1993','25');
insert into Proprietário values('134567890','José','Rua José','20','1234-123','Loures','Loures','M', '12-25-1970','48');

insert into Proprietário_Telefone values('123456789',987654321);
insert into Proprietário_Telefone values('234567891',976543210);
insert into Proprietário_Telefone values('345678901',998765432);
insert into Proprietário_Telefone values('567890123',967654321);
insert into Proprietário_Telefone values('678901234',937654321);
insert into Proprietário_Telefone values('789012345',927654321);
insert into Proprietário_Telefone values('890123456',917654321);
insert into Proprietário_Telefone values('901234567',217654321);
insert into Proprietário_Telefone values('000000001',227654321);
insert into Proprietário_Telefone values('000000001',911234567);
insert into Proprietário_Telefone values('012345678',257654321);
insert into Proprietário_Telefone values('134567890',287654321);
insert into Proprietário_Telefone values('134567890',981234567);

insert into Veículo values('99-AB-99','12345678901234567890','Vermelho', '1997', '123456789', '1', '1');
insert into Veículo values('77-AB-77','09876543210987654321','Azul', '1998', '123456789', '2', '1');
insert into Veículo values('49-DA-44','44586920194850192785','Preto', '2000', '234567891', '2', '1');
insert into Veículo values('12-DA-56','10386710384019486712','Preto', '2001', '345678901', '2', '1');
insert into Veículo values('46-MB-52','97865498722146598723','Roxo', '2017', '567890123', '11', '1');
insert into Veículo values('65-BG-12','68794315978231456781','Vermelho', '2017', '678901234', '6', '1');
insert into Veículo values('98-GI-11','64231651665135489721','Branco', '2016', '789012345', '4', '1');
insert into Veículo values('40-MI-55','10694819274859183769','Prateado', '2010', '890123456', '7', '1');
insert into Veículo values('70-CA-68','12398756412359842456','Cinzento', '2008', '901234567', '7', '1');
insert into Veículo values('90-KI-00','10478671120938104912','Branco', '2005', '000000001', '3', '1');
insert into Veículo values('00-KI-90','57619487120494858123','Preto', '2009', '012345678', '3', '3');
insert into Veículo values('90-KK-90','87123951275419204958','Branco', '2006', '134567890', '4', '2');

insert into Infração values('1','99-AB-99','12345','1234','1-4-2019','150');
insert into Infração values('2','77-AB-77','23456','2345','4-29-2018','120');
insert into Infração values('3','49-DA-44','34567','3456','3-20-2018','123');
insert into Infração values('4','12-DA-56','45678','4567','8-30-2018','176');
insert into Infração values('5','46-MB-52','56789','5678','12-30-2017','149');
insert into Infração values('6','65-BG-12','67890','6789','8-13-2018','139');
insert into Infração values('7','98-GI-11','78901','7890','2-27-2018','178');
insert into Infração values('8','40-MI-55','89010','8901','9-10-2018','170');
insert into Infração values('9','70-CA-68','11111','9012','1-1-2019','168');
insert into Infração values('10','90-KI-00','22222','1111','10-23-2018','143');
insert into Infração values('11','00-KI-90','34561','3636','11-3-2018','156');
insert into Infração values('2','90-KK-90','45678','6789','6-30-2018','164');


















