USE BD2025S2
go
----------
--INSERT--
----------
--Modelo
SET DATEFORMAT DMY

INSERT INTO Modelo (Nome, NumeroLugares, Tipo) VALUES
    ('HB20s', 5, 'Sedan'),
    ('HB20', 5, 'Hatch'),
    ('Porsche Spyder', 2, 'Outros'),
    ('Fiesta',  null, 'Hatch') ,
    ('Onix', null, 'Hatch'),
    ('TCross', null, 'SUV'),
    ('Tiguan', 7, 'SUV')

--Nome, Descricao, NumeroLugares, Tipo
INSERT INTO Modelo VALUES
    ('C3', null, null, 'Hatch'),
    ('Gol', 'Geracao 3', 5, null)

--Validando as informa��es inseridas
SELECT * FROM Modelo


--Veiculo
SET DATEFORMAT DMY
INSERT INTO Veiculo (Proprietario, Placa, DataCompra, IDModelo, Valor, AnoFabricacao) VALUES
    ('Anna Clara', 'ABC1234', '28-10-2013', 1, 50000, 2013),
    ('Enzo Gabriel', 'DEF1234', '27-07-2012', 1, 20000, 2012),
    ('Geovana', 'GHI5678', '31-07-2013', 2, 40000,  2013),
    ('Manuela', 'ABC9090', '11-12-2013', 3, 10000, 2012)

INSERT INTO Veiculo (Proprietario, Placa, IDModelo, Valor, AnoFabricacao) VALUES
    ('Bernardo', 'BER2301', 4, 50000, 2020)

INSERT INTO Veiculo VALUES
    ('Lucas', 'LUC9988', '14-05-2020', 2, 25000, 2020, 'Branca'),
    ('Murilo', 'MUU5334', '20-02-2021', 3, 35000, 2021, 'Azul'),
    ('Marcelo', 'MAH2376', '05-04-2022', 2, 50000, 2022, 'Cinza')

--Importante: Validar se o IDModelo existe, caso contr�rio, atualizar
-- Validando as informa��es inseridas
SELECT * FROM Veiculo

----------
--UPDATE--
----------
SET DATEFORMAT DMY

--Atualizando todas as informa��es 
--UPDATE Modelo SET Descricao = 'Veiculo 123' --CUIDADO

--Filtrando/Selecionando as informa��es que ser�o atualizadas
UPDATE Modelo SET NumeroLugares = 4 WHERE IDModelo = 4
UPDATE Modelo SET NumeroLugares = 6 WHERE Nome = 'C3'
UPDATE Modelo SET Descricao = 'Carro de Fam�lia' WHERE Tipo = 'Sedan'
UPDATE Modelo SET Descricao = 'Nova descri��o' WHERE IDModelo >=5 
UPDATE Modelo SET Tipo = 'Outros' WHERE Tipo IS NULL

--Validando as informa��es
SELECT * FROM Modelo

--Filtrando/Selecionando as informa��es que ser�o atualizadas
UPDATE Veiculo SET Cor = 'Amarelo', Valor = 75000 WHERE Proprietario = 'Bernardo'
UPDATE Veiculo SET Cor = '---' WHERE Cor IS NULL
UPDATE Veiculo SET IDModelo = 5 WHERE IDModelo = 4
UPDATE Veiculo SET Placa = 'CLA2810', Cor = 'Rosa' WHERE Proprietario = 'Anna Clara' AND Cor IS NOT NULL
UPDATE Veiculo SET Cor = NULL WHERE Cor = '---'

--Validando as informa��es
SELECT * FROM Veiculo

----------
--DELETE--
----------
--Excluindo todas as informa��es
--DELETE FROM Modelo

--Filtrando/Selecionando as informa��es que ser�o exclu�das
DELETE FROM Modelo WHERE IDModelo = 6
DELETE FROM Modelo WHERE NumeroLugares >5 AND Tipo = 'SUV'

--Validando as informa��es
SELECT * FROM Modelo


--Excluindo todas as informa��es 
--DELETE FROM Veiculo

--Filtrando/Selecionando as informa��es que ser�o exclu�das
DELETE FROM Veiculo WHERE YEAR(DataCompra) = 2020
DELETE FROM Veiculo WHERE Placa = 'MUU5334'

SELECT * FROM Veiculo
