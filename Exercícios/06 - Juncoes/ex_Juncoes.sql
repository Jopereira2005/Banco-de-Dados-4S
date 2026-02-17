-- 1. Criar uma consulta para exibir o Nome e Cidade do Empregado e o Nome do Departamento.

SELECT 
  A.Nome Empregado,
  A.Cidade,
  B.Nome Departamento
FROM Empregado A 
  INNER JOIN Departamento B
    ON A.IDDepartamento = B.IDDepartamento;
  
-- 2. Criar uma consulta para exibir o Nome e Data de Contratação do Empregado e o Nome e Nível do Cargo. 

SELECT 
  A.Nome Empregado,
  A.DataContratacao,
  B.Nome Cargo,
  B.Nivel
FROM Empregado A 
  INNER JOIN Cargo B
    ON A.IDCargo = B.IDCargo;

-- 3. Criar uma Consulta para exibir a quantidade de empregados por departamento (exibir o nome do departamento e a respectiva quantidade de empregados).

SELECT 
  A.Nome Departamento,
  COUNT(B.IDDepartamento) Qtdd_Empregados
FROM Departamento A 
  RIGHT JOIN Empregado B
    ON A.IDDepartamento = B.IDDepartamento
GROUP BY A.Nome;

-- 4. Criar uma consulta para exibir a quantidade de empregados por cargo (exibir o nome do cargo e a respectiva quantidade de empregados).

SELECT
  A.Nome Cargo,
  COUNT(B.IDCargo) Qtdd_Empregados
FROM Cargo A 
  INNER JOIN Empregado B
    ON A.IDCargo = B.IDCargo
GROUP BY A.Nome;

-- 5. Criar uma consulta para exibir o Nome e Cidade do Empregado e o Nome do Departamento quando o nome do departamento possuir “Tecnologia” ou “TI”. 

SELECT
  A.Nome,
  A.Cidade,
  B.Nome Departamento
FROM Empregado A 
  INNER JOIN Departamento B
    ON A.IDDepartamento = B.IDDepartamento
WHERE B.Nome LIKE '%Tecnologia%' OR B.Nome LIKE '% TI%';

-- 6. Criar uma consulta para exibir o Nome e Data de Contratação dos Empregados e o Nome do Cargo dos empregados contratados entre 2019 e 2022. 

SELECT
  A.Nome,
  A.DataContratacao,
  B.Nome Cargo
FROM Empregado A 
  INNER JOIN Cargo B
    ON A.IDCargo = B.IDCargo
WHERE DATEPART(YEAR, A.DataContratacao) BETWEEN 2019 AND 2022;

-- 7. Criar uma consulta para exibir o Nome, Cidade e Data de Contratação do Empregado, o Nome do Departamento e o Nome, Nível e Salário Base do Cargo. 

SELECT
  A.Nome,
  A.Cidade,
  A.DataContratacao,
  B.Nome Departamento,
  C.Nome Cargo,
  C.Nivel,
  C.SalarioBase
FROM Empregado A 
  INNER JOIN Departamento B
    ON A.IDDepartamento = B.IDDepartamento
  INNER JOIN Cargo C
    ON A.IDCargo = C.IDCargo

-- 8. Criar uma Consulta para exibir o nome de TODOS os departamentos e a quantidade de empregados de cada um deles (exibir o nome do departamento e a respectiva quantidade de empregados, quando não possuir empregados a quantidade deve ser ZERO). 

SELECT
  A.Nome Departamento,
  COUNT(B.IDDepartamento) Qtdd_Empregados
FROM Departamento A
  LEFT JOIN Empregado B
    ON A.IDDepartamento = B.IDDepartamento
GROUP BY A.Nome;

-- 9. Criar uma Consulta para exibir o nome de TODOS os cargos e a quantidade de empregados de cada um deles (exibir o nome do cargo e a respectiva quantidade de empregados, quando não possuir empregados a quantidade deve ser ZERO).

SELECT
  A.Nome Cargo,
  COUNT(B.IDDepartamento) Qtdd_Empregados
FROM Cargo A
  LEFT JOIN Empregado B
    ON A.IDCargo = B.IDCargo
GROUP BY A.Nome;

