-- 1. Realizar a criação das tabelas do modelo ER indicado. 
-- 2. Criar as restrições indicadas (not null, identity, etc.). 
-- 3. Criar os relacionamentos necessários (chaves primárias e chaves estrangeiras).
DROP DATABASE EmpresaDB;
GO

CREATE DATABASE EmpresaDB;
GO

USE EmpresaDB;
GO

CREATE TABLE Departamento (
  IDDepartamento int NOT NULL PRIMARY KEY IDENTITY,
  Nome varchar(250) NOT NULL,
)

CREATE TABLE Cargo (
  IDCargo int NOT NULL PRIMARY KEY IDENTITY,
  Nome varchar(250) NOT NULL,
  Nivel varchar(100) NOT NULL,
  SalarioBase numeric(18,2) NOT NULL
)

CREATE TABLE Empregado (
  IDEMpregado int NOT NULL PRIMARY KEY IDENTITY,
  Nome varchar(250) NOT NULL,
  Cidade varchar(150) NOT NULL,
  DataContratacao datetime NOT NULL,
  IDDepartamento int NOT NULL REFERENCES Departamento(IDDepartamento),
  IDCargo int NOT NULL REFERENCES Cargo(IDCargo)
)
GO

-- 4. Adicionar na tabela Empregado a coluna Estado do tipo varchar(250).

ALTER TABLE Empregado ADD Estado varchar(250);
GO

-- 5. Adicionar na tabela Cargo a coluna Descricao do tipo varchar(150).

ALTER TABLE Cargo ADD Descricao varchar(150);
GO
-- 6. Alterar o campo Nome da tabela Cargo para não permitir valores nulos (not null).

ALTER TABLE Cargo ALTER COLUMN Nome varchar(150) NOT NULL;
GO

-- 7. Excluir o campo Descricao da tabela Cargo.

ALTER TABLE Cargo DROP COLUMN Descricao;

-- 8. Caso fosse necessário excluir todas as tabelas deveria ser seguida uma ordem? Se sim qualseria?
-- Sim, primeiro exclui as tabelas com chave estrangeiras e depois as que não possuem.