-- Questão 1. Criar uma tabela de auditoria chamada AuditoriaGeral (conforme estrutura abaixo) que será responsável por armazenar as transações realizadas nas tabelas existentes no banco de dados.
-- • IDAuditoria int autoincremento chave primária
-- • TipoOperacao varchar(100) //Insert ou Update ou Delete
-- • NomeTabela varchar(100)
-- • IDAfetado int //ID no qual está sendo realizada a operação
-- • InformacaoAntiga varchar(5000)
-- • InformacaoNova varchar(5000)
-- • DataOperacao datetime obrigatório

CREATE TABLE AuditoriaGeral (
  IDAuditoria int not null identity,
  TipoOperacao varchar(100) not null,
  NomeTabela varchar(100) not null,
  IDAfetado int not null,
  InformacaoAntiga varchar(5000),
  InformacaoNova varchar(5000),
  DataOperacao datetime not null
);
GO

-- Questão 2. Criar uma Trigger na tabela de Raça que registre na tabela de Auditoria Geral todas as exclusões realizadas, informando:
-- • Tipo de Operação (delete)
-- • Nome da Tabela
-- • ID afetado
-- • Nome da Raça excluída
-- • Data/hora da operação

CREATE OR ALTER TRIGGER tgrLogDeleteRaca
  ON Raca 
  AFTER DELETE 
AS 
BEGIN
  INSERT INTO AuditoriaGeral (TipoOperacao, NomeTabela, IDAfetado, InformacaoAntiga, DataOperacao)
  SELECT
    'Delete',
    'Raca',
    d.IDRaca,
    'Nome: ' + ISNULL (d.Nome, 'NULL') + ', Descricao: ' + ISNULL (d.Descricao, 'NULL') + ', Origem: ' + ISNULL (d.Origem, 'NULL'),
    GETDATE ()
  FROM
    deleted d;
END;
GO

INSERT INTO Raca (Nome, Descricao, Origem) VALUES
  ('Teste', 'Teste e adaptável', 'Diversos continentes');
GO

DELETE FROM Raca WHERE IDRaca = 12;
GO

SELECT * FROM Raca;
SELECT * FROM AuditoriaGeral;
GO



-- Questão 3. Criar  uma  Trigger  na  Tabela  de  Habilidade  que  registre  na  tabela  de  Auditoria  Geral  todas  as atualizações realizadas, informando: 
-- • Tipo de Operação (update) 
-- • Nome da Tabela 
-- • ID afetado  
-- • Nome da Habilidade e Multiplicador do Poder atualizados (antes e depois) 
-- • Data/hora da operação 

CREATE OR ALTER TRIGGER tgrLogUpdateHabilidade
  ON Habilidade
  AFTER UPDATE
AS
BEGIN
  INSERT INTO AuditoriaGeral (TipoOperacao, NomeTabela, IDAfetado, InformacaoAntiga, InformacaoNova, DataOperacao)
    SELECT 
      'Update',
      'Habilidade',
      D.IDHabilidade,
      'Nome: ' + D.Nome + ', Multiplicador: ' + CAST(D.MultiplicadorPoder as varchar),
      'Nome: ' + I.Nome + ', Multiplicador: ' + CAST(I.MultiplicadorPoder as varchar),
      GETDATE()
    FROM deleted D INNER JOIN inserted I
      ON D.IDHabilidade = I.IDHabilidade
END;
GO 

UPDATE Habilidade
  SET MultiplicadorPoder = 2
    WHERE IDHabilidade = 5
GO
SELECT * FROM Habilidade;
SELECT * FROM AuditoriaGeral;
GO

-- Questão 4. Criar uma Trigger de Auditoria Geral que será responsável por registrar na tabela Auditoria Geral todas as alterações (insert, update ou delete) realizadas na tabela de Personagem, informando:
-- • Tipo de Operação (insert / update / delete, conforme operação DML realizada)
-- • Nome da Tabela
-- • ID afetado
-- • Nome do Personagem e Poder (antes e depois, conforme operação DML realizada)
-- • Data/hora da operação

CREATE OR ALTER TRIGGER tgrLogPersonagem
  ON Personagem
  AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
      INSERT INTO AuditoriaGeral (TipoOperacao, NomeTabela, IDAfetado, InformacaoAntiga, InformacaoNova, DataOperacao)
      SELECT
        'Insert',
        'Personagem',
        I.IDPersonagem,
        NULL,
        'Nome: ' + I.Nome + ', Poder: ' + CAST(I.Poder AS VARCHAR),
        GETDATE()
      FROM inserted I;
    END
  ELSE IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
      INSERT INTO AuditoriaGeral (TipoOperacao, NomeTabela, IDAfetado, InformacaoAntiga, InformacaoNova, DataOperacao)
      SELECT
        'Delete',
        'Personagem',
        D.IDPersonagem,
        'Nome: ' + D.Nome + ', Poder: ' + CAST(D.Poder AS VARCHAR),
        NULL,
        GETDATE()
      FROM deleted D;
    END
  ELSE
    BEGIN
      INSERT INTO AuditoriaGeral (TipoOperacao, NomeTabela, IDAfetado, InformacaoAntiga, InformacaoNova, DataOperacao)
      SELECT
        'Update',
        'Personagem',
        I.IDPersonagem,
        'Nome: ' + D.Nome + ', Poder: ' + CAST(D.Poder AS VARCHAR),
        'Nome: ' + I.Nome + ', Poder: ' + CAST(I.Poder AS VARCHAR),
        GETDATE()
      FROM inserted I
      INNER JOIN deleted D ON I.IDPersonagem = D.IDPersonagem;
    END
END;
GO 

UPDATE Personagem
  SET Poder = 300
    WHERE IDPersonagem = 5
GO

DELETE FROM Personagem WHERE IDPersonagem = 97;
GO

INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Paxe', 'Humano guerreiro paxe', '14-11-2005', 1, 2, 1000);
GO

SELECT * FROM Personagem;
SELECT * FROM AuditoriaGeral;
GO

-- Questão 5. Criar uma Trigger na tabela de Personagem que impede o cadastro de personagens com Poder superior a 300. Quando isso ocorrer, uma mensagem de erro via RAISERROR deve ser exibida e a inserção cancelada.

CREATE OR ALTER TRIGGER tgrLogInsertValidaPoderPersonagem
ON Personagem
INSTEAD OF INSERT
AS
BEGIN
  IF EXISTS( SELECT * FROM inserted WHERE Poder > 300)
    BEGIN
      RAISERROR('Erro: Não é permitido cadastrar personagens com Poder superior a 300.', 16, 1);
      ROLLBACK TRANSACTION;
      RETURN;
    END;
  INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder)
  SELECT
      Nome,
      Descricao,
      DataNascimento,
      IDRaca,
      IDClasse,
      Poder
  FROM inserted;
END;
GO

INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Paxe', 'Humano guerreiro paxe', '14-11-2005', 1, 2, 200);
GO

SELECT * FROM Personagem;
SELECT * FROM AuditoriaGeral;
GO

-- Questão 6. Criar uma Trigger na tabela de Personagem que impede a exclusão de personagens com menos de 18 anos. Quando isso ocorrer, uma mensagem de erro via RAISERROR deve ser exibida e a exclusão cancelada.
CREATE OR ALTER TRIGGER tgrLogDeleteValidaIdadePersonagem
ON Personagem
INSTEAD OF DELETE
AS
BEGIN
  IF EXISTS (SELECT * FROM deleted WHERE DATEDIFF(YEAR, DataNascimento, GETDATE()) < 18)
    BEGIN
      ROLLBACK TRANSACTION;

      RAISERROR('Erro: Não é permitido excluir personagens com menos de 18 anos.', 16, 1);
      RETURN;
    END;
END;
GO

INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Paxe', 'Humano guerreiro paxe', '14-11-2010', 1, 2, 200);
GO

DELETE FROM Personagem WHERE IDPersonagem = 103;
GO

-- Questão 7. Criar uma Trigger na tabela de Habilidade que ao realizar a alteração do Multiplicador do Poder, atualize automaticamente o Poder dos personagens relacionados as classes que utilizam essa habilidade multiplicando o poder atual pelo novo valor.

CREATE OR ALTER TRIGGER tgrLogUpdateMultiplicadorPoderPersonagem
ON Habilidade
AFTER UPDATE
AS
BEGIN
  IF UPDATE(MultiplicadorPoder)
  BEGIN
    UPDATE P
      SET P.Poder = P.Poder * i.MultiplicadorPoder
        FROM Personagem P
      INNER JOIN Classe C
        ON P.IDClasse = C.IDClasse
      INNER JOIN inserted i
        ON C.IDHabilidade = i.IDHabilidade;
  END;
END;
GO

UPDATE Habilidade
  SET MultiplicadorPoder = 5
    WHERE IDHabilidade = 2;

SELECT * FROM Classe;
SELECT * FROM Habilidade;
SELECT * FROM Personagem;
GO


