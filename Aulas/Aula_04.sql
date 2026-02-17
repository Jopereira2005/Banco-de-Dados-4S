--1. Exibir a quantidade de modelos cadastrados (COUNT)
SELECT COUNT(*) QtdModelos FROM Modelo;
GO

--2. Exibir a quantidade de veículos cadastrados (COUNT)
SELECT COUNT(*) QtdVeiculos FROM Veiculo;
GO

--3. Exibir a soma dos valores de todos os veículos (SUM)
SELECT SUM(Valor) SomaValoresVeiculos FROM Veiculo;
GO

--4. Exibir a média de valores de todos os veículos (AVG)
SELECT AVG(Valor) MediaValoresVeiculos FROM Veiculo;
GO

--5. Exibir o valor do veículo mais caro (MAX)
SELECT MAX(Valor) VeiculoMaisCaro FROM Veiculo;
GO

--6. Exibir o valor do veículo mais barato (MIN)
SELECT MIN(Valor) VeiculoMaisBarato FROM Veiculo;
GO

--7. Exibir a soma dos valores dos veículos fabricados entre 2020 e 2022. (SUM + WHERE)
SELECT SUM(Valor) SomaValorVeiculos FROM Veiculo 
WHERE AnoFabricacao BETWEEN 2020 AND 2022;
GO

--8. Exibir a média dos valores dos veículos fabricados entre 2000 e 2019 (AVG + WHERE)
SELECT AVG(Valor) MediaValorVeiculos FROM Veiculo 
WHERE AnoFabricacao BETWEEN 2000 AND 2019;
GO

--9. Exibir a soma do valor dos veículos agrupados por Ano de Fabricação (SUM + GROUP BY)
SELECT AnoFabricacao, SUM(Valor) SomaValorVeiculos FROM Veiculo GROUP BY AnoFabricacao
ORDER BY AnoFabricacao;
GO

--10. Exibir o valor médio dos veículos agrupados por Ano de Fabricação (AVG + GROUP BY)
SELECT AnoFabricacao, AVG(Valor) MediaValorVeiculos FROM Veiculo GROUP BY AnoFabricacao
ORDER BY AnoFabricacao;
GO

--11. Exibir a quantidade de veículos agrupados por Ano de Fabricação (COUNT + GROUP BY)
SELECT AnoFabricacao, COUNT(*) QtdVeiculos FROM Veiculo 
  GROUP BY AnoFabricacao 
  ORDER BY AnoFabricacao;
GO

--12. Exibir o valor do veículo mais caro e do mais barato de cada Ano de Fabricação (MAX + MIN + GROUP BY)
SELECT AnoFabricacao, MAX(Valor) VeiculoMaisCaro, MIN(Valor) VeiculoMaisBarato FROM Veiculo 
  GROUP BY AnoFabricacao 
  ORDER BY AnoFabricacao;
GO

--Extra
SELECT
  AnoFabricacao,
  COUNT(*) QtdVeiculos,
  SUM(Valor) SomaValorVeiculos,
  AVG(Valor) MediaValorVeiculos,
  MAX(Valor) VeiculoMaisCaro,
  MIN(Valor) VeiculoMaisBarato
FROM Veiculo
  GROUP BY AnoFabricacao
  ORDER BY AnoFabricacao;

-- Exemplos de Uso do HAVING

-- Exibir a quantidade de modelos cadastrados por tipo, mas apenas tipos com mais de 2 modelos:
SELECT Tipo, COUNT(*) QuantidadeModelos FROM Modelo
  GROUP BY Tipo
  HAVING COUNT(*) > 2;

-- Exibir a soma dos valores dos veículos por ano de fabricação, mas apenas para anos onde a soma dos valores ultrapassa 100.000
SELECT AnoFabricacao, SUM(Valor) AS SomaValores FROM Veiculo
  GROUP BY AnoFabricacao
  HAVING SUM(Valor) > 100000;

-- Exibir a média dos valores dos veículos por proprietário, mas apenas para proprietários cuja média dos valores dos veículos é maior que 30.000
SELECT Proprietario, AVG(Valor) MediaValores FROM Veiculo
  GROUP BY Proprietario
  HAVING AVG(Valor) > 30000;

-- Exibir os proprietários de veículos que têm uma média de valor superior a 30.000 e cuja soma total dos valores dos veículos seja superior a 100.000
SELECT Proprietario, AVG(Valor) MediaValores, SUM(Valor) SomaValores FROM Veiculo
  GROUP BY Proprietario
  HAVING AVG(Valor) > 30000 AND SUM(Valor) > 100000;


--13. Exibir a soma do valor dos veículos agrupados por Ano de Fabricação. Somente devem ser exibidos os anos onde a soma é superior a . Somente as cidades com soma é igual ou superior a R$ 50.000,00 (SUM + GROUP BY + HAVING).
SELECT AnoFabricacao, SUM(Valor) SomaValorVeiculos FROM Veiculo 
  GROUP BY AnoFabricacao 
  HAVING SUM(Valor) >= 50000;

--14 Exibir o valor médio dos veículos agrupados por Ano de Fabricação. Somente devem ser exibidos os anos onde a média está entre R$ 30.000,00 e R$40.000,00 (AVG + GROUP BY + HAVING).
SELECT AnoFabricacao, AVG(Valor) MediaValorVeiculos FROM Veiculo 
  GROUP BY AnoFabricacao 
  HAVING AVG(Valor) BETWEEN 30000 AND 40000;

--15. Exibir a quantidade de veículos agrupados por Ano de Fabricação. Somente os anos com 2 ou mais veículos devem ser exibidos (count + group by + having).
SELECT AnoFabricacao, COUNT(*) QtdVeiculos FROM Veiculo 
  GROUP BY AnoFabricacao
  HAVING COUNT(*) >= 2;