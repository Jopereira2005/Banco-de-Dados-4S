SELECT * FROM Veiculo;
SELECT * FROM Modelo;
SELECT * FROM Fabricante;
GO

-- INNER JOIN | Exemplos
-- 1. Desenvolver uma consulta para exibir o Nome e Tipo do Modelo e o respectivo Nome do Fabricante
SELECT
  A.Nome Modelo,
  A.Tipo Tipo,
  B.Nome Fabricante
FROM
  Modelo A INNER JOIN Fabricante B
    ON A.IDFabricante = B.IDFabricante;
GO

-- 2. Desenvolver uma consulta para exibir o Proprietário e Placa do Veículo e o Nome do Modelo.
SELECT
  A.Nome,
  A.Placa,
  B.Nome Modelo
FROM
  Veiculo A INNER JOIN Modelo B
    ON A.IDModelo = B.IDModelo;
GO

-- 3. Desenvolver uma consulta para exibir o Nome do Fabricante e a quantidade de Modelos cadastrados.
SELECT
  B.Nome Fabricante,
  COUNT(*) Qtdd_Modelos
FROM 
  Modelo A INNER JOIN Fabricante B
    ON A.IDFabricante = B.IDFabricante
GROUP BY B.Nome;
GO
  
-- 4. Desenvolver uma consulta para exibir o Nome do Proprietário, Nome do Modelo e Nome do Fabricante.
SELECT
  A.Proprietario,
  B.Nome Modelo,
  C.Nome Fabricante
FROM
  Veiculo A INNER JOIN Modelo B
    ON A.IDModelo = B.IDModelo
  INNER JOIN Fabricante C
    ON B.IDFabricante = C.IDFabricante;
GO

-- LEFT JOIN | Exemplos
--5. Desenvolver uma consulta para exibir o Nome e Tipo de todos os Modelo e o respectivo Nome do Fabricante quando existirem.
SELECT
  A.Nome NomeModelo,
  A.Tipo,
  B.Nome NomeFabricante
FROM 
  Modelo A LEFT JOIN Fabricante B
    ON A.IDFabricante = B.IDFabricante
  ORDER BY A.Nome, B.Nome;
GO

--6. Desenvolver uma consulta para exibir o Nome de todos os Fabricante e a quantidade de Modelos cadastrados de cada um deles.
SELECT
  A.Nome NomeFabricante,
  COUNT(B.IDFabricante) QtdModelos
FROM
  Fabricante A LEFT JOIN Modelo B
    ON A.IDFabricante = B.IDFabricante
  GROUP BY A.Nome
  ORDER BY A.Nome;
GO

-- RIGHT JOIN | Exemplos
--7. Desenvolver uma consulta para exibir o Proprietário e Tipo de todos os Veículos com os respectivos Nomes de Modelo e Fabricante (quando existirem).
SELECT
  B.Proprietario,
  A.Nome NomeModelo,
  C.Nome NomeFabricante
FROM
  Modelo A RIGHT JOIN Veiculo B
    ON A.IDModelo = B.IDModelo
  LEFT JOIN Fabricante C
    ON A.IDFabricante = C.IDFabricante;
GO

--8. Desenvolver uma consulta para exibir o Nome de todos os Modelos e a quantidade de Veículos cadastrados de cada um deles.
SELECT
  B.Nome NomeModelo,
  COUNT(A.IDVeiculo) QtdVeiculos
FROM
  Veiculo A RIGHT JOIN Modelo B
    ON A.IDModelo = B.IDModelo
  GROUP BY B.Nome;
GO

-- FULL JOIN | Exemplos
--9. Desenvolver uma consulta para exibir o Nome e Tipo de todos os Modelo e os respectivo Nome e Cidade de todos os Fabricante.
SELECT
  A.Nome NomeModelo,
  A.Tipo,
  B.Nome NomeFabricante,
  B.Cidade
FROM
  Modelo A FULL JOIN Fabricante B
    ON A.IDFabricante = B.IDFabricante
ORDER BY A.Nome, B.Nome;
GO

