--Atores 
--1
INSERT INTO ATOR VALUES(0001, 'Espanhol', '01-01-1990', 'M', 'Ruan3000@Sapo.pt', 925145369, 962541002);
INSERT INTO Ator_Aptidao VALUES('Vilão', 0001);
INSERT INTO ATOR_NOME_SS VALUES('Ruan Carlos', 0001, '059603928500');

--2
INSERT INTO ATOR VALUES(0002, 'Francês', '05-03-1991', 'M', 'Ani25@Gmail.pt', 921023478, 981025789);
INSERT INTO Ator_Aptidao VALUES('Heroi', 0002);
INSERT INTO ATOR_NOME_SS VALUES('Anthoine Delon', 0002, '058602850112');

--3
INSERT INTO ATOR VALUES(0003, 'Português', '05-07-1995', 'F', 'Rita_P@Sapo.pt', 987456123, 936258741);
INSERT INTO Ator_Aptidao VALUES('Princesa', 0003);
INSERT INTO ATOR_NOME_SS VALUES('Rita Branco', 0003, '049182930143');

--4
INSERT INTO Ator VALUES(0004, 'Americano', '06-10-1972', 'M', 'BenAF@outlook.com', 918450123, 964812302);
INSERT INTO Ator_Aptidao VALUES('Herói cómico', 0004);
INSERT INTO ATOR_NOME_SS VALUES('Ben Afleck', 0004, '498168021945');

--5
INSERT INTO Ator VALUES(0005, 'Brasileiro', '08-23-1964', 'F', 'gp_64@gmail.com', 923156487, 983214576);
INSERT INTO Ator_Aptidao VALUES('Detetive', 0005);
INSERT INTO ATOR_NOME_SS VALUES('Glória Pires', 0005, 'A479174SWA1T');

--6
INSERT INTO Ator VALUES(0006, 'Português', '02-21-2000', 'F', 'gp_64@gmail.com', 951753264, 928436157);
INSERT INTO Ator_Aptidao VALUES('Rebelde', 0006);
INSERT INTO ATOR_NOME_SS VALUES('Susana Flores', 0006, 'G5W189484A79');

--7
INSERT INTO Ator VALUES(0007, 'Italiano', '05-11-1984', 'M', 'gioluca@gmail.com', 936258741, 961234578);
INSERT INTO Ator_Aptidao VALUES('Mafioso', 0007);
INSERT INTO ATOR_NOME_SS VALUES('Giovanni Luca', 0007, 'FG145879AS2F');


--Realizadores -----------------------
INSERT INTO Realizador VALUES ('Antonio', 755552320);
INSERT INTO Realizador VALUES ('XPTO', 951000258);
INSERT INTO Realizador VALUES ('José', 925741369);
INSERT INTO Realizador VALUES ('Mónica', 194557293);
INSERT INTO Realizador VALUES ('Ben Afleck', 950193859);

--Ator_É_Realizador-------------------
INSERT INTO Ator_É_Realizador VALUES (0004,'Ben Afleck');

--Cinemas -------------------------------
INSERT INTO Cinema VALUES ('Luso mundo', 'Oeiras');
INSERT INTO Cinema VALUES ('NOS', 'Colombo');
INSERT INTO Cinema VALUES ('UCI Cinemas', 'Amadora');
INSERT INTO Cinema VALUES ('Cinema City', 'Carnaxide');
INSERT INTO Cinema VALUES ('CinePlace', 'Caldas da Rainha');


--Filmes -----------------------------------
--Batman vs Iron Man (XPTO)
INSERT INTO Filme VALUES ('Batman vs Iron Man', 'Morcego vs Ferro', 12, 12500000, 'Antonio', '05-05-2019');
INSERT INTO Filme_Genero VALUES('Batman vs Iron Man', 'Fantasia');

--A Madrinha
INSERT INTO Filme VALUES ('The godmother', 'A Madrinha', 7, 1200000000, 'Mónica', '07-11-2019');
INSERT INTO Filme_Genero VALUES('The godmother', 'Crime');

--DeadPool
INSERT INTO Filme VALUES ('DeadPool', 'Piscina Morta', 10, 256000000000, 'Ben Afleck', '02-10-2016');
INSERT INTO Filme_Genero VALUES ('DeadPool', 'Super heróis');

--Final Fantasy
INSERT INTO Filme VALUES ('Final Fantasy', 'Final Fantasia', 6, 50000000, 'José', '01-03-2017');
INSERT INTO Filme_Genero VALUES ('Final Fantasy', 'Fantasia');

--Final Fantasy 2
INSERT INTO Filme VALUES ('Final Fantasy II', 'Final Fantasia II', 4, 80000000, 'José', '01-03-2018');
INSERT INTO Filme_Genero VALUES ('Final Fantasy II', 'Fantasia');

--O Feiticeiro
INSERT INTO Filme VALUES ('The Wizard', 'O Feiticeiro', 7, 150000000, 'José', '01-12-2016');
INSERT INTO Filme_Genero VALUES ('The Wizard', 'Fantasia');

--A Aventura (José)
INSERT INTO Filme VALUES ('The Adventure', 'A Aventura', 10, 180000000, 'José', '05-11-2018');
INSERT INTO Filme_Genero VALUES ('The Adventure', 'Aventura');

--A Aventura 2 (XPTO)
INSERT INTO Filme VALUES ('The Adventure 2', 'A Aventura 2', 5, 20000000, 'XPTO', '01-05-2020');
INSERT INTO Filme_Genero VALUES ('The Adventure 2', 'Aventura');

--A Aventura 3 (XPTO)
INSERT INTO Filme VALUES ('The Adventure 3', 'A Aventura 3', 4, 22000000, 'XPTO', '10-05-2021');
INSERT INTO Filme_Genero VALUES ('The Adventure 3', 'Aventura');

--Ator Participa em
INSERT INTO Participa_Em VALUES (0001, 'Final Fantasy', 'Cloud Strife', 550000);
INSERT INTO Participa_Em VALUES (0001, 'Final Fantasy II', 'Cloud Strife', 550000);
INSERT INTO Participa_Em VALUES (0001, 'The Wizard', 'Cloud Strife', 550000);
INSERT INTO Participa_Em VALUES (0001, 'Batman vs Iron Man', 'Batman', 50000);
INSERT INTO Participa_Em VALUES (0004, 'DeadPool', 'DeadPool', 100000);
INSERT INTO Participa_Em VALUES (0002, 'Batman vs Iron Man', 'Iron Man', 9000);
INSERT INTO Participa_Em VALUES (0003, 'DeadPool', 'John', 12321);
INSERT INTO Participa_Em VALUES (0007, 'The godmother', 'Vini', 1500000);
INSERT INTO Participa_Em VALUES (0006, 'The Adventure', 'Bibi', 500000);
INSERT INTO Participa_Em VALUES (0006, 'The Adventure 2', 'Bibi', 555000);
INSERT INTO Participa_Em VALUES (0006, 'The Adventure 3', 'Bibi', 655000);

--Estudios------
--Fox
INSERT INTO Estudio VALUES ('20th Century Fox', 'Los Angles', 'Disney',66, '05-31-1935', 100000000);
INSERT INTO Estudio_CodPostal VALUES ('20th Century Fox', 123457);

--Marvel
INSERT INTO Estudio VALUES ('Marvel Studios', 'Los Angeles', 'Disney', 55, '05-04-1990', 634512304);
INSERT INTO Estudio_CodPostal VALUES ('Marvel Studios', 134512);

--Plural Entertainment
INSERT INTO Estudio VALUES ('Plural Entertainment', 'Quinta dos Melos Bucelas', 'Media Capital', 14, '01-02-1992', 20000000);
INSERT INTO Estudio_CodPostal VALUES ('Plural Entertainment', 262570);

--RTP
INSERT INTO Estudio VALUES ('RTP', 'Lisboa', 'Estado', 14, '01-02-1992', 20000000);
INSERT INTO Estudio_CodPostal VALUES ('RTP', 147963);

--Produzido por------
INSERT INTO Produzido_Por VALUES ('Final Fantasy', '20th Century Fox');
INSERT INTO Produzido_Por VALUES ('Final Fantasy II', '20th Century Fox');
INSERT INTO Produzido_Por VALUES ('The Wizard', 'Marvel Studios');
INSERT INTO Produzido_Por VALUES ('Batman vs Iron Man', '20th Century Fox');
INSERT INTO Produzido_Por VALUES ('DeadPool', 'Marvel Studios');
INSERT INTO Produzido_Por VALUES ('The godmother', 'Plural Entertainment');
INSERT INTO Produzido_Por VALUES ('The Adventure', '20th Century Fox');
INSERT INTO Produzido_Por VALUES ('The Adventure 2', '20th Century Fox');
INSERT INTO Produzido_Por VALUES ('The Adventure 3', '20th Century Fox');

--Distribuido Por------
INSERT INTO Distribuido_Por VALUES ('Batman vs Iron Man', 'Luso mundo', 'Oeiras');
INSERT INTO Distribuido_Por VALUES ('DeadPool','NOS', 'Colombo');
INSERT INTO Distribuido_Por VALUES ('The godmother','CinePlace', 'Caldas da Rainha');
INSERT INTO Distribuido_Por VALUES ('The Adventure','UCI Cinemas', 'Amadora');
INSERT INTO Distribuido_Por VALUES ('Final Fantasy','UCI Cinemas', 'Amadora');
INSERT INTO Distribuido_Por VALUES ('Final Fantasy II','UCI Cinemas', 'Amadora');
INSERT INTO Distribuido_Por VALUES ('The Wizard','Cinema City', 'Carnaxide');
