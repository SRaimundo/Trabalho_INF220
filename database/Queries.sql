-- List a client from part of his/her name
SELECT Id_cliente, Nome
FROM CLIENTE
WHERE Nome LIKE '%Yuri%';

-- List a hotel from its city
SELECT Id_hotel, Nome
FROM HOTEL
WHERE Cidade = 'Rio de Janeiro';

-- List the rooms from a Hotel's code
SELECT Numero as Quarto
FROM QUARTO
WHERE Hotel = 2;

-- List the rooms from a Hotel's name
SELECT Q.Numero as Quarto
FROM QUARTO Q, HOTEL H
WHERE Q.Hotel = H.Id_hotel AND H.Nome = 'Durma Bem';

-- List the rooms from part of a Hotel's name
SELECT Q.Numero as Quarto, H.Nome as Hotel
FROM QUARTO Q, HOTEL H
WHERE Q.Hotel = H.Codigo AND H.Nome LIKE '%Durma%';

-- List the adapted rooms
SELECT Q.Numero as Quarto, Adaptado
FROM QUARTO Q, TIPO_QUARTO T
WHERE Q.Tipo = T.Id_tipo AND T.Adaptado = true;

-- List the rooms from a especific type
SELECT Numero as Quarto
FROM QUARTO
WHERE Tipo = 2;

-- Search a empty room of an especific type in some period (In: '2022-12-07', Out: '2022-12-13')
SELECT Numero as Quarto
FROM QUARTO
WHERE Tipo = 2 AND Numero NOT IN (
	SELECT Quarto
	FROM RESERVA
	WHERE Data_in < '2022-12-13' AND Data_out > '2022-12-07'
);

-- List the clients in a Hotel from its city
SELECT C.Nome
FROM CLIENTE C, HOTEL H, QUARTO Q, RESERVA R
WHERE C.Id_cliente = R.Cliente AND Q.Numero = R.Quarto AND Q.Hotel = H.Id_hotel AND H.Nome IN (
	SELECT Nome
	FROM HOTEL
	WHERE Cidade = 'Rio de Janeiro'
);


--Nome dos clientes hospedados na Filial Rio de Janeiro, no período 26/fev a 01/mar/22;
SELECT  DISTINCT C.Nome
FROM CLIENTE C, RESERVA R, QUARTO Q, HOTEL H
WHERE R.Data_in <= '2022-03-01' AND R.Data_out >= '2022-02-26' AND
C.Id_cliente = R.Cliente AND R.Quarto = Q.Numero AND 
Q.HOTEL = H.Id_hotel AND H.Cidade = 'Rio de Janeiro';

--Nome das faxineiras que limparam o quarto 401, Filial Rio de Janeiro, no período 26/fev a 01/mar/22;
SELECT DISTINCT F.Nome
FROM FUNCIONARIO F, ARRUMACAO A, HOTEL H, QUARTO Q
WHERE F.Id_funcionario = A.Funcionario AND A.Quarto = Q.Numero
AND Q.Hotel = H.Id_hotel and H.Cidade = 'Rio de Janeiro' AND Q.Numero = '401'
AND A.Data >='2022-02-26' AND A.Data <= '2022-03-01';


--Hotel, número do quarto e nome dos clientes que consumiram “RedBull” em qualquer data.
SELECT DISTINCT H.Nome, Q.Numero, C.Nome
FROM HOTEL H, QUARTO Q, CLIENTE C, DESPESA D, RESERVA R
WHERE D.Descricao = 'Red Bull' AND  D.Cliente = C.Id_cliente 
AND R.Cliente = C.Id_cliente AND R.Data_in <= D.Data AND R.Data_out >= D.Data
AND R.Quarto = Q.Numero AND Q.Hotel = H.Id_hotel;

--Nome dos clientes que fizeram reserva na Filial Rio de Janeiro, mas não se hospedaram;
SELECT C.Nome
FROM CLIENTE C, RESERVA R, HOTEL H, QUARTO Q
WHERE R.Data_in <= "2022-12-07" AND R.Check_in = false 
AND C.Id_cliente = R.Cliente AND R.Quarto = Q.Numero 
AND Q.Hotel = H.Id_hotel AND H.Cidade = "Rio de Janeiro";

--Número de quartos tipo “1 Cama de Casal” em cada filial;
SELECT H.Cidade , count(*) AS count
FROM HOTEL H, QUARTO Q, TIPO_QUARTO T
WHERE H.Id_hotel = Q.Hotel AND Q.Tipo = T.Id_tipo
AND T.Numero_camas_casal = 1
GROUP BY H.Cidade;