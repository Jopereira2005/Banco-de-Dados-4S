USE master;
DROP DATABASE VeiculoDB;
GO
CREATE DATABASE VeiculoDB;
GO
USE VeiculoDB;
GO

CREATE TABLE Fabricante (
	IDFabricante int not null identity,
	Nome varchar(200) not null,
	Descricao varchar(500),
	Cidade varchar(150) not null,
	Estado varchar(10) not null,
	CONSTRAINT PKIDFabricante PRIMARY KEY (IDFabricante)
);

CREATE TABLE Modelo (
  IDModelo int not null identity,
  IDFabricante int not null,
  Nome varchar(200) not null,
  Tipo varchar(50) not null,
  CONSTRAINT PKIDModelo PRIMARY KEY (IDModelo),
  CONSTRAINT FKModeloFabricante FOREIGN KEY (IDFabricante) REFERENCES Fabricante(IDFabricante)
);

CREATE TABLE Veiculo (
  IDVeiculo int not null identity,
  IDModelo int not null,
  Proprietario varchar(200) not null,
  Placa varchar(50) not null,
  DataCompra datetime,
  Valor numeric(18,2) not null,
  AnoFabricacao int not null,
  Cor varchar(50),
  CONSTRAINT PKIDVeiculo PRIMARY KEY (IDVeiculo),
  CONSTRAINT FKVeiculoModelo FOREIGN KEY (IDModelo) REFERENCES Modelo(IDModelo)
);
GO

CREATE TABLE LogInfo (
  IDLog int not null identity,
  Tabela varchar(100),
  Informacoes varchar(5000),
  DateLog datetime
);
GO

CREATE TABLE LogAuditoriaVeiculo (
  IDLogVeiculo int not null identity,
  IDVeiculo int not null,
  DadosAntigos varchar(4000),
  DadosNovos varchar(4000),
  Observacoes varchar(1000),
  DateRegistro datetime
);
GO

CREATE TABLE LogAuditoriaModelo (
  IDLogModelo int not null identity,
  IDModelo int not null,
  DadosAntigos varchar(4000),
  DadosNovos varchar(4000),
  Observacoes varchar(1000),
  DateRegistro datetime
);
GO

SET DATEFORMAT DMY;

INSERT INTO Fabricante (Nome, Cidade, Estado) VALUES
   ('Sedan', 'Piracicaba', 'SP'),
   ('Honda', 'Belo Horizonte', 'MG'),
   ('Volkswagen', 'Anapolis', 'GO'),
   ('Nissan', 'Sao Caetano', 'SP'),
   ('Ford', 'Sao Paulo', 'SP'),
   ('Fiat', 'Sao Paulo', 'SP'),
   ('Citroen', 'Niterai', 'RJ'),
   ('Toyota', 'Itu', 'SP'),
   ('Jeep', 'Uberlandia', 'MG');
GO

INSERT INTO Modelo (Nome, Tipo, IDFabricante) 
VALUES('HB20s', 'Normal', 1),
      ('Civic', 'Normal', 2),
      ('Opala', 'Normal', 5),
      ('KA', 'Normal', 5),
      ('T-Cross', 'SUV', 3),
      ('Kick', 'SUV', 4),
      ('Sus', 'Normal', 7);
GO

INSERT INTO Veiculo (Proprietario, Placa, DataCompra, IDModelo, Valor, AnoFabricacao, Cor)
VALUES('Anna Clara', 'ABC1P34', '28-10-2013', 1, 500000, 2013, 'Prata'),
      ('Mr Paxe 1', 'SUSPAXE', '27-07-2012', 1, 20000, 2012, 'Preto'),
      ('Mr Paxe 2', 'SUSPAX7', '27-07-2013', 3, 20000, 2012, 'Rosa'),
      ('Mr Paxe 3', 'SUSPAX1', '27-07-2014', 4, 20000, 2012, 'Preto'),
      ('Mr Paxe 4', 'SUSPAX2', '27-07-2012', 5, 20000, 2012, 'Rosa'),
      ('Mr Paxe 5', 'SUSPAX3', '27-07-2017', 5, 20000, 2012, 'Vermelho'),
      ('Mr Paxe 6', 'SUSPAX4', '27-07-2016', 2, 200000, 2012, 'Amarelo'),
      ('Mr Paxe 7', 'SUSPAX5', '27-07-2017', 7, 205000, 2012, 'Azul'),
      ('Mr Paxe 8', 'SUSPAX6', '27-07-2016', 3, 200500, 2012, 'Preto'),
      ('Mr Paxe 9', 'SUSPAX6', '27-07-2016', 3, 200500, 2012, 'Preto'),
      ('Mr Paxe 10', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'Vermelho'),
      ('Mr Paxe 11', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'Preto'),
      ('Mr Paxe 12', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'Preto'),
      ('Mr Paxe 13', 'SUSPAX6', '27-07-2016', 1, 200500, 2012, 'Vermelho'),
      ('Mr Paxe 14', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'Preto'),
      ('Mr Paxe 15', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'PraVermelhota'),
      ('Mr Paxe 16', 'SUSPAX6', '27-07-2016', 3, 200500, 2012, 'Preto'),
      ('Mr Paxe 17', 'SUSPAX6', '27-07-2016', 5, 200500, 2012, 'Preto'),
      ('Mr Paxe 18', 'SUSPAX6', '27-07-2016', 2, 200500, 2012, 'Vermelho');
GO