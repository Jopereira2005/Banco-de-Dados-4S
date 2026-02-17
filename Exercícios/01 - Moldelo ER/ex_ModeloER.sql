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
  Nome varchar(250),
  Nivel varchar(100),
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

