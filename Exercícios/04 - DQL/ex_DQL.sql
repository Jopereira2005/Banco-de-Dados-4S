-- 1. Selecionar todas as informações da tabela Departamento
SELECT * FROM Departamento;
GO
-- 2. Selecionar o Nome, Nível e Salário Base dos Cargos

SELECT Nome, Nivel, SalarioBase FROM Cargo;
GO

-- 3. Selecionar o Nome, Cidade e Data de Contratação dos Empregados 
SELECT Nome, Cidade, DataContratacao FROM Empregado;
GO

-- 4. Selecionar os cargos onde o salário está entre R$ 2.500,00 e R$ 5.000,00. 

SELECT * FROM Cargo
  WHERE SalarioBase BETWEEN 2500.00 AND 5000.00;
GO

-- 5. Selecionar o Nome, Cidade, Estados e Data de Contratação dos Empregados contratos entre os anos de 2020 e 2021 

SELECT Nome, Cidade, Estado, DataContratacao FROM Empregado
  WHERE DATEPART(YEAR, DataContratacao) BETWEEN 2020 AND 2023;
GO

-- 6. Selecionar o Nome e Cidade dos empregados contratos em 2022 da cidade de Sorocaba. 

SELECT Nome, Cidade FROM Empregado
  WHERE DATEPART(YEAR, DataContratacao) = 2022
  AND Cidade = 'Sorocaba';
GO

-- 7. Selecionar os departamentos com nome igual a “Marketing” ou “Financeiro” 

SELECT * FROM Departamento
  WHERE Nome = 'Marketing' 
  OR Nome = 'Financeiro';
GO

-- 8. Selecionar o Nome, Nível e Salário Base dos Cargos que possuem a palavra “Tecnologia” em qual parte do nome.

SELECT Nome, Nivel, SalarioBase FROM Cargo
  WHERE Nome LIKE '%Tecnologia%'; 
GO

-- 9. Selecionar os Empregados onde as cidades começam com “São” e terminam qual qualquer sequência.

SELECT * FROM Empregado
  WHERE Cidade LIKE 'São%';
GO
 
-- 10. Selecionar o Nome, Nível e Salário base dos Cargos com Nível “Pleno” e Salário Base maior ou igual a R$ 3.000,00 

SELECT Nome, Nivel, SalarioBase FROM Cargo
  WHERE Nivel = 'Pleno'
  AND SalarioBase >= 3000.00;
GO

-- 11. Selecionar Nome, Cidade e Data de Contratação dos empregados com sobrenome “Silva” ou “Oliveira”. Nesse caso devemos verificar os empregados que terminado com os textos indicados. 

SELECT Nome, Cidade, DataContratacao FROM Empregado
  WHERE Nome LIKE '%Silva'
  OR Nome LIKE '%Oliveira'
GO

-- 12. Selecionar as cidades distintas dos Empregados.

SELECT DISTINCT Cidade FROM Empregado;
GO