CREATE DATABASE Aula_02
GO

USE Aula_02
GO

CREATE TABLE Modelo (
	IDModelo int not null PRIMARY KEY identity,
	Nome varchar(200) not null,
	Descricao varchar(500)
)
GO

CREATE TABLE Veiculo (
	IDVeiculo int not null PRIMARY KEY identity,
	Proprietario varchar(200) not null,
	Placa varchar(50) not null,
	DataCompra datetime,
	IDModelo int not null REFERENCES Modelo(IDModelo),
	Valor numeric(18,2) not null
)
GO

--Demonstra��o para cria��o de uma Chave Composta
CREATE TABLE ChaveComposta (
	IDChave1 int not null,
	IDChave2 int not null,
	Nome varchar(150) not null
)
GO

ALTER TABLE ChaveComposta ADD CONSTRAINT PKChaveComposta PRIMARY KEY (IDChave1, IDChave2)
GO

--ALTER TABLE
--Tabela Modelo
ALTER TABLE Modelo ADD NumeroLugares int
ALTER TABLE Modelo ADD Tipo varchar(100)

--abela: Veiculo
ALTER TABLE Veiculo ADD VouApagar numeric(18,2)
ALTER TABLE Veiculo ADD AnoFabricacao int
ALTER TABLE Veiculo ADD Cores varchar(10)
GO

ALTER TABLE Veiculo ALTER COLUMN AnoFabricacao int not null
ALTER TABLE Veiculo ALTER COLUMN Cores varchar(50)
GO

ALTER TABLE Veiculo DROP COLUMN VouApagar
GO

exec SP_RENAME 'Veiculo.Cores', Cor
GO

--DROP TABLE
drop table ChaveComposta
GO