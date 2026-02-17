-- 1. Exibir a quantidade de cargos cadastrados.

SELECT COUNT(*) Quantidade_Cargos FROM Cargo;

-- 2. Exibir a soma de todos os salários bases dos cargos. 

SELECT SUM(SalarioBase) Soma_Salarios FROM Cargo;

-- 3. Exibir a média geral dos salários bases dos cargos. 

SELECT AVG(SalarioBase) Media_Salarios FROM Cargo;

-- 4. Exibir o menor e o maior salário base dos cargos. 

SELECT MIN(SalarioBase) Menor_Salario, MAX(SalarioBase) Maior_Salario FROM Cargo;

-- 5. Exibir a soma dos salários base dos Cargos com Nível “Júnior”. 

SELECT SUM(SalarioBase) Soma_Salarios FROM Cargo
  WHERE Nivel = 'Júnior';

-- 6. Exibir a quantidade de empregados por cidade (exibir a cidade e a respectiva quantidade).

SELECT COUNT(*) Quantidade_Empregado, Cidade FROM Empregado
  GROUP BY Cidade;

-- 7. Exibir a média salarial (salário base) de cada um dos níveis (exibir o nome do nível e a respectiva média salarial). 

SELECT AVG(SalarioBase) Media_Salarial, Nivel FROM Cargo
  GROUP BY Nivel;

-- 8. Exibir a quantidade de contratação por ano (exibir o ano e a respectiva quantidade). Somente devem ser exibidos os anos com mais de 2 (duas) contratações. 

SELECT 
  COUNT(DataContratacao) Contratacao_Anual, 
  DATEPART(YEAR, DataContratacao) Ano
FROM Empregado
  GROUP BY DATEPART(YEAR, DataContratacao)
    HAVING COUNT(DataContratacao) > 1;

-- 9. Exibir a média salarial (salário base) de cada um dos níveis (exibir o nome do nível e a respectiva média salarial). Somente devem ser exibidos os níveis que a média salarial é inferior a R$ 2.000,00. 

SELECT Nivel, AVG(SalarioBase) Media_Salarial FROM Cargo
  GROUP BY Nivel
    HAVING AVG(SalarioBase) < 20000;

-- 10. Exibir a quantidade de empregados por cidade (exibir a cidade e a respectiva quantidade). Somente devem ser exibidas as cidades com mais de 3 (três) empregados.

SELECT Cidade, COUNT(*) Quantidade_Empregado FROM Empregado
  GROUP BY Cidade
    HAVING COUNT(*) > 2;