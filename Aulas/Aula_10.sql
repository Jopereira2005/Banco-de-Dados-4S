CREATE OR ALTER TRIGGER tgrLogInsertVeiculo
  ON Veiculo
  AFTER INSERT
AS
BEGIN
  INSERT INTO LogAuditoriaVeiculo (IDVeiculo, DadosNovos, DateRegistro)
    SELECT 
      IDVeiculo,
      'Prop: ' + Proprietario + ', Placa: ' + Placa,
      GETDATE()
    FROM inserted;
END;
GO

INSERT INTO Veiculo VALUES(1, 'HyperPaxe', 'ASD54321', GETDATE(), 100000, 2025, 'Vermelho');
GO

SELECT * FROM Veiculo;
SELECT * FROM LogAuditoriaVeiculo;
GO

CREATE OR ALTER TRIGGER tgrLogInsertModelo
  ON Modelo
  AFTER INSERT
AS
BEGIN
  INSERT INTO LogAuditoriaModelo (IDModelo, DadosNovos, DateRegistro)
    SELECT 
      IDModelo,
      'Nome: ' + Nome + ', Tipo: ' + Tipo,
      GETDATE()
    FROM inserted;
END;
GO

INSERT INTO Modelo VALUES(1, 'Paxe Movel', 'SUV');
GO
SELECT * FROM Modelo;
SELECT * FROM LogAuditoriaModelo;
GO

CREATE OR ALTER TRIGGER tgrLogUpdateVeiculo
  ON Veiculo
  AFTER UPDATE
AS
BEGIN
  INSERT INTO LogAuditoriaVeiculo (IDVeiculo, DadosAntigos, DadosNovos, DateRegistro)
    SELECT 
      D.IDVeiculo,
      'Prop: ' + D.Proprietario + ', Placa: ' + D.Placa,
      'Prop: ' + I.Proprietario + ', Placa: ' + I.Placa,
      GETDATE()
    FROM deleted D INNER JOIN inserted I
      ON D.IDVeiculo = I.IDVeiculo
END;
GO

UPDATE Veiculo
  SET Placa = 'PAXE54321'
    WHERE IDVeiculo = 22
GO
SELECT * FROM Veiculo;
SELECT * FROM LogAuditoriaVeiculo;
GO

CREATE OR ALTER TRIGGER tgrLogUpdateModelo
  ON Modelo
  AFTER UPDATE
AS
BEGIN
  INSERT INTO LogAuditoriaModelo (IDModelo, DadosAntigos, DadosNovos, DateRegistro)
    SELECT 
      D.IDModelo,
      'Nome: ' + D.Nome + ', Tipo: ' + D.Tipo,
      'Nome: ' + I.Nome + ', Tipo: ' + I.Tipo,
      GETDATE()
    FROM deleted D INNER JOIN inserted I
      ON D.IDModelo = I.IDModelo
END;
GO

UPDATE Modelo
  SET Tipo = 'SUV'
    WHERE IDModelo = 11
GO
SELECT * FROM Modelo;
SELECT * FROM LogAuditoriaModelo;
GO
