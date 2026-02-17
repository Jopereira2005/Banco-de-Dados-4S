CREATE OR ALTER PROCEDURE spInsertVeiculo
  @IDModelo int, 
  @Proprietario varchar(200), 
  @Placa varchar(250),
  @DataCompra datetime,
  @Valor numeric(18,2),
  @AnoFabricacao int,
  @Cor varchar(50)
AS
BEGIN
    INSERT INTO Veiculo (Proprietario, Placa, DataCompra, IDModelo, Valor, AnoFabricacao, Cor)
      VALUES(@Proprietario, @Placa, @DataCompra, @IDModelo, @Valor, @AnoFabricacao, @Cor);
END;
GO

EXEC spInsertVeiculo 1, 'MrPaxe', 'ABCDEFG', '28-10-2023', 5000000, 2023, 'Preto';
GO

CREATE OR ALTER PROCEDURE spInsertModelo
  @IDFabricante int,
  @Nome varchar(200), 
  @Tipo varchar(50)
AS
BEGIN
  BEGIN TRY
    PRINT 'Inicio';
    INSERT INTO Modelo (Nome, Tipo, IDFabricante)
      VALUES(@Nome, @Tipo, @IDFabricante);
    PRINT 'Execucao Completa';
  END TRY
  BEGIN CATCH
    PRINT 'Algo deu errado!';
    SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
  END CATCH
END
GO

EXEC spInsertModelo 3, 'Nivus', 'SUV';
GO

RAISERROR('Meu errinhinho', 5, 1);
GO

RAISERROR('Meu warning', 5, 1);
GO

BEGIN TRY
  PRINT 'Inicio...';
  SELECT 10/0 Resultado;
  PRINT 'Termino...';
END TRY
BEGIN CATCH
  PRINT 'Opa Amigo, deu erro .-.';
  SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
  RAISERROR('Erro tratado', 16, 1);
END CATCH
GO

CREATE OR ALTER PROCEDURE spVenderVeiculo
  @IDVeiculo int, 
  @DataVenda datetime
AS
BEGIN
  DECLARE @veiculoExiste int;
  SELECT @veiculoExiste = COUNT(*) FROM Veiculo WHERE IDVeiculo = @IDVeiculo;

  IF @veiculoExiste = 0
    RAISERROR('Veiculo nao Encontrado', 16, 1);
  ELSE
    BEGIN
      UPDATE Veiculo SET DataCompra = @DataVenda WHERE IDVeiculo = @IDVeiculo;
      PRINT 'Venda realizada com sucesso';
    END
END

SET DATEFORMAT DMY;
EXEC spVenderVeiculo 99, '08-10-2025';
EXEC spVenderVeiculo 10, '08-10-2025';
GO

CREATE OR ALTER PROCEDURE spInsertVeiculo02
  @IDModelo int, 
  @Proprietario varchar(200), 
  @Placa varchar(250),
  @DataCompra datetime,
  @Valor numeric(18,2),
  @AnoFabricacao int,
  @Cor varchar(50)
AS
BEGIN
    DECLARE @modeloExiste int;
    SELECT @modeloExiste = COUNT(*) FROM Modelo WHERE IDModelo = @IDModelo;

    IF @modeloExiste = 0
      RAISERROR('Modelo nao Encontrado', 16, 1);
    ELSE
      BEGIN
        BEGIN TRY
          PRINT 'Inicio';
          INSERT INTO Veiculo (Proprietario, Placa, DataCompra, IDModelo, Valor, AnoFabricacao, Cor)
          VALUES(@Proprietario, @Placa, @DataCompra, @IDModelo, @Valor, @AnoFabricacao, @Cor);
          PRINT 'Execucao Completa';
        END TRY
        BEGIN CATCH
          PRINT 'Algo deu errado!';
          SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
        END CATCH
      END
END;
GO

EXEC spInsertVeiculo02 99, 'MrPaxe2', 'ABCDEFG', '28-10-2024', 1000000, 2024, 'Vermelho';
EXEC spInsertVeiculo02 2, 'MrPaxe2', 'ABCDEFG', '28-10-2024', null, 2024, 'Vermelho';
EXEC spInsertVeiculo02 2, 'MrPaxe2', 'ABCDEFG', '28-10-2024', 2000000, 2024, 'Vermelho';
GO

SELECT * FROM Veiculo;
SELECT * FROM Modelo;
SELECT * FROM Fabricante;