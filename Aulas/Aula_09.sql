CREATE OR ALTER TRIGGER tgrValidarFabrincante
  ON Fabricante
  AFTER INSERT
AS
BEGIN
  declare @hoje int;
  set @hoje = DAY(GETDATE());

  IF @hoje >= 31
    BEGIN
      RAISERROR('Cadastros somentes ANTES do dias 20!', 10, 1);
      ROLLBACK; -- Transação é criada automaticamente em qualquer ação de DELETE, INSERT, UPDATE
    END;
END;

SELECT * FROM Fabricante;
GO
INSERT INTO Fabricante VALUES('BMW', NULL, 'São Roque', 'SP');
GO
SELECT * FROM Fabricante;
GO

CREATE OR ALTER TRIGGER tgrLogInsertVeiculo
  ON Veiculo
  AFTER INSERT
AS
BEGIN
  INSERT INTO LogInfo (Tabela, Informacoes, DateLog) VALUES
    ('Tab.Veiculo', 'Inserindo Novo Veiculo', GETDATE());
END;
GO

INSERT INTO Veiculo VALUES(1, 'Paxeeee', 'ASD1234', GETDATE(), 25000, 2023, 'Vermelho');
GO
SELECT * FROM Veiculo;
SELECT * FROM LogInfo;
GO

CREATE OR ALTER TRIGGER tgrLogInsertFabricante
  ON Fabricante
  AFTER INSERT
AS
BEGIN
  INSERT INTO LogInfo (Tabela, Informacoes, DateLog) VALUES
    ('Tab.Fabricante', 'Inserindo Novo Fabricante', GETDATE());
END
GO

INSERT INTO Fabricante VALUES('Bugatti', NULL, 'Tatuí', 'SP');
GO
SELECT * FROM Fabricante;
SELECT * FROM LogInfo;
GO


CREATE OR ALTER TRIGGER tgrLogUpdateVeiculo
  ON Veiculo
  AFTER UPDATE
AS
BEGIN
  INSERT INTO LogInfo (Tabela, Informacoes, DateLog) VALUES
    ('Tab.Veiculo', 'Atualizando Veiculo', GETDATE());
END;
GO

UPDATE Veiculo SET Proprietario = 'Paxo'
  WHERE IDVeiculo = 29;
GO
SELECT * FROM Veiculo;
SELECT * FROM LogInfo;
GO

CREATE OR ALTER TRIGGER tgrLogDeleteVeiculo
  ON Veiculo
  AFTER DELETE
AS
BEGIN
  INSERT INTO LogInfo (Tabela, Informacoes, DateLog) VALUES
    ('Tab.Veiculo', 'Excluindo Veiculo', GETDATE());
END;
GO

DELETE FROM Veiculo WHERE IDVeiculo = 29;
GO
SELECT * FROM Veiculo;
SELECT * FROM LogInfo;
GO
