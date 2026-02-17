CREATE DATABASE Aula_01;
USE Aula_01;

CREATE TABLE Teste_01 (
  id int(10) PRIMARY KEY,
  nome varchar(100) NOT NULL,
  salario decimal(8,2) NOT NULL
);

INSERT INTO Teste_01 (id, nome, salario) VALUES (1, "Mr Paxe", 90000.00);
INSERT INTO Teste_01 (id, nome, salario) VALUES (2, "Outro Paxe", 80000.00);
INSERT INTO Teste_01 (id, nome, salario) VALUES (3, "Mais um Paxe", 70000.00);
INSERT INTO Teste_01 (id, nome, salario) VALUES (4, "Quanto Paxe", 60000.00);
INSERT INTO Teste_01 (id, nome, salario) VALUES (5, "Mr Paxe", 50000.00);

SELECT * FROM Teste_01;