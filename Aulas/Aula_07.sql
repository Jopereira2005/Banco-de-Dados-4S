DECLARE @AnoFabricacao int, @Dono varchar(250);
GO

-- SET @AnoFabricacao = (SELECT AnoFabricacao FROM Veiculo WHERE IDVeiculo = 3);
SELECT @AnoFabricacao = AnoFabricacao FROM Veiculo WHERE IDVeiculo = 3;
GO

CREATE OR ALTER PROCEDURE spPrimeiraProc
AS
BEGIN
    SELECT 'Primeira Procedure';
END;
GO

EXEC spPrimeiraProc;
GO

CREATE OR ALTER PROCEDURE spMudaCor @id int, @novaCor varchar(50)
AS
BEGIN
    SELECT * FROM Veiculo WHERE IDVeiculo = @id;
    UPDATE Veiculo SET Cor = @novaCor WHERE IDVeiculo = @id;
    SELECT * FROM Veiculo WHERE IDVeiculo = @id;
END;
GO

EXEC spMudaCor 1, 'Vermelho';
EXEC spMudaCor @novaCor = 'Preto', @id = 2;
GO

CREATE OR ALTER PROCEDURE spBuscaVeiculoPorAno @placa varchar(30)
AS
BEGIN
    SELECT 
      A.Proprietario Proprietario,
      B.Nome Modelo,
      C.Nome Fabricante,
      A.Placa
    FROM 
      Veiculo A INNER JOIN Modelo B
        ON A.IDModelo = B.IDModelo
      LEFT JOIN Fabricante C
        ON B.IDFabricante = C.IDFabricante
    WHERE 
      A.Placa LIKE '%' + @placa + '%';
END;
GO

EXEC spBuscaVeiculoPorAno 'ABC1234';
GO

CREATE OR ALTER PROCEDURE spAreaRet @base int, @altura int, @area int OUTPUT
AS
BEGIN
    SET @area = @base * @altura;
END;

DECLARE @ret int;
EXEC spAreaRet 10, 5, @ret OUTPUT;
PRINT @ret;
GO