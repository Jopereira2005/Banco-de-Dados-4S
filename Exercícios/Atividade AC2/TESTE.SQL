USE PersonagemDB;
GO

-- ============================================
-- AC2 - Atividade 2: Triggers (Gatilhos)
-- ============================================

-- ============================================
-- Questão 1: Criar tabela de auditoria
-- ============================================
-- Criação da tabela AuditoriaGeral para armazenar as transações
CREATE TABLE AuditoriaGeral
(
    IDAuditoria      INT            IDENTITY (1, 1) PRIMARY KEY,
    TipoOperacao     VARCHAR(100)   NOT NULL,
    NomeTabela       VARCHAR(100)   NOT NULL,
    IDAfetado        INT            NOT NULL,
    InformacaoAntiga VARCHAR(5000)  NULL,
    InformacaoNova   VARCHAR(5000)  NULL,
    DataOperacao     DATETIME       NOT NULL DEFAULT GETDATE()
);
GO

-- Comando opcional para validação da criação:
-- SELECT * FROM AuditoriaGeral;

-- ============================================
-- Questão 2: Trigger para exclusão na tabela Raca
-- ============================================
-- Trigger para registrar exclusões na tabela Raca
CREATE TRIGGER trg_Raca_Delete
ON Raca
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeral
    (
        TipoOperacao,
        NomeTabela,
        IDAfetado,
        InformacaoAntiga,
        InformacaoNova,
        DataOperacao
    )
    SELECT
        'Delete' AS TipoOperacao,
        'Raca'   AS NomeTabela,
        d.IDRaca AS IDAfetado,
        'ID: ' + CAST(d.IDRaca AS VARCHAR(10)) +
            ', Nome: '      + ISNULL(d.Nome, 'NULL') +
            ', Descricao: ' + ISNULL(d.Descricao, 'NULL') +
            ', Origem: '    + ISNULL(d.Origem, 'NULL') AS InformacaoAntiga,
        NULL AS InformacaoNova,
        GETDATE() AS DataOperacao
    FROM deleted d;
END;
GO

-- Comandos para validação (opcionais):
-- DELETE FROM Raca WHERE IDRaca = 1;
-- SELECT * FROM AuditoriaGeral WHERE NomeTabela = 'Raca';

-- ============================================
-- Questão 3: Trigger para atualização na tabela Habilidade
-- ============================================
-- Trigger para registrar atualizações na tabela Habilidade
CREATE TRIGGER trg_Habilidade_Update
ON Habilidade
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeral
    (
        TipoOperacao,
        NomeTabela,
        IDAfetado,
        InformacaoAntiga,
        InformacaoNova,
        DataOperacao
    )
    SELECT
        'Update'           AS TipoOperacao,
        'Habilidade'       AS NomeTabela,
        d.IDHabilidade     AS IDAfetado,
        'ID: ' + CAST(d.IDHabilidade AS VARCHAR(10)) +
            ', Nome: ' + ISNULL(d.Nome, 'NULL') +
            ', MultiplicadorPoder: ' +
            ISNULL(CAST(d.MultiplicadorPoder AS VARCHAR(20)), 'NULL')
            AS InformacaoAntiga,
        'ID: ' + CAST(i.IDHabilidade AS VARCHAR(10)) +
            ', Nome: ' + ISNULL(i.Nome, 'NULL') +
            ', MultiplicadorPoder: ' +
            ISNULL(CAST(i.MultiplicadorPoder AS VARCHAR(20)), 'NULL')
            AS InformacaoNova,
        GETDATE() AS DataOperacao
    FROM deleted d
    INNER JOIN inserted i
        ON d.IDHabilidade = i.IDHabilidade;
END;
GO

-- Comandos para validação (opcionais):
-- UPDATE Habilidade
-- SET MultiplicadorPoder = 2
-- WHERE IDHabilidade = 1;
-- SELECT * FROM AuditoriaGeral WHERE NomeTabela = 'Habilidade';

-- ============================================
-- Questão 4: Trigger de auditoria geral na tabela Personagem
-- ============================================
-- Trigger para registrar INSERT, UPDATE e DELETE em Personagem
CREATE TRIGGER trg_Personagem_AuditoriaGeral
ON Personagem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Caso 1: INSERT (somente inserted preenchida)
    IF EXISTS (SELECT 1 FROM inserted)
       AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO AuditoriaGeral
        (
            TipoOperacao,
            NomeTabela,
            IDAfetado,
            InformacaoAntiga,
            InformacaoNova,
            DataOperacao
        )
        SELECT
            'Insert'       AS TipoOperacao,
            'Personagem'   AS NomeTabela,
            i.IDPersonagem AS IDAfetado,
            NULL           AS InformacaoAntiga,
            'ID: ' + CAST(i.IDPersonagem AS VARCHAR(10)) +
                ', Nome: ' + ISNULL(i.Nome, 'NULL') +
                ', Poder: ' +
                ISNULL(CAST(i.Poder AS VARCHAR(20)), 'NULL')
                AS InformacaoNova,
            GETDATE() AS DataOperacao
        FROM inserted i;
    END;

    -- Caso 2: UPDATE (inserted e deleted preenchidas)
    IF EXISTS (SELECT 1 FROM inserted)
       AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO AuditoriaGeral
        (
            TipoOperacao,
            NomeTabela,
            IDAfetado,
            InformacaoAntiga,
            InformacaoNova,
            DataOperacao
        )
        SELECT
            'Update'       AS TipoOperacao,
            'Personagem'   AS NomeTabela,
            d.IDPersonagem AS IDAfetado,
            'ID: ' + CAST(d.IDPersonagem AS VARCHAR(10)) +
                ', Nome: ' + ISNULL(d.Nome, 'NULL') +
                ', Poder: ' +
                ISNULL(CAST(d.Poder AS VARCHAR(20)), 'NULL')
                AS InformacaoAntiga,
            'ID: ' + CAST(i.IDPersonagem AS VARCHAR(10)) +
                ', Nome: ' + ISNULL(i.Nome, 'NULL') +
                ', Poder: ' +
                ISNULL(CAST(i.Poder AS VARCHAR(20)), 'NULL')
                AS InformacaoNova,
            GETDATE() AS DataOperacao
        FROM deleted d
        INNER JOIN inserted i
            ON d.IDPersonagem = i.IDPersonagem;
    END;

    -- Caso 3: DELETE (somente deleted preenchida)
    IF EXISTS (SELECT 1 FROM deleted)
       AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO AuditoriaGeral
        (
            TipoOperacao,
            NomeTabela,
            IDAfetado,
            InformacaoAntiga,
            InformacaoNova,
            DataOperacao
        )
        SELECT
            'Delete'       AS TipoOperacao,
            'Personagem'   AS NomeTabela,
            d.IDPersonagem AS IDAfetado,
            'ID: ' + CAST(d.IDPersonagem AS VARCHAR(10)) +
                ', Nome: ' + ISNULL(d.Nome, 'NULL') +
                ', Poder: ' +
                ISNULL(CAST(d.Poder AS VARCHAR(20)), 'NULL')
                AS InformacaoAntiga,
            NULL AS InformacaoNova,
            GETDATE() AS DataOperacao
        FROM deleted d;
    END;
END;
GO

-- Comandos para validação (opcionais):
-- INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder)
-- VALUES ('Teste', 'Personagem de teste', '2000-01-01', 1, 1, 100);
-- UPDATE Personagem SET Poder = 150 WHERE IDPersonagem = 1;
-- DELETE FROM Personagem WHERE IDPersonagem = 1;
-- SELECT * FROM AuditoriaGeral WHERE NomeTabela = 'Personagem';

-- ============================================
-- Questão 5: Trigger para validar Poder máximo no INSERT de Personagem
-- ============================================
-- Impede o cadastro de personagens com Poder superior a 300
CREATE TRIGGER trg_Personagem_ValidarPoder
ON Personagem
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Se existir algum registro com Poder > 300, cancela toda a inserção
    IF EXISTS
    (
        SELECT 1
        FROM inserted
        WHERE Poder > 300
    )
    BEGIN
        RAISERROR
        (
            'Erro: Não é permitido cadastrar personagens com Poder superior a 300.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Se todos estiverem dentro do limite, insere normalmente
    INSERT INTO Personagem
    (
        Nome,
        Descricao,
        DataNascimento,
        IDRaca,
        IDClasse,
        Poder
    )
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

-- Comandos para validação (opcionais):
-- INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder)
-- VALUES ('Personagem Forte', 'Deveria falhar', '2000-01-01', 1, 1, 350);
-- INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder)
-- VALUES ('Personagem Normal', 'Deve funcionar', '2000-01-01', 1, 1, 250);

-- ============================================
-- Questão 6: Trigger para impedir exclusão de menores de 18 anos
-- ============================================
-- Impede a exclusão de personagens com idade inferior a 18 anos
CREATE TRIGGER trg_Personagem_ValidarIdadeExclusao
ON Personagem
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se há algum personagem menor de 18 anos no conjunto a ser excluído
    IF EXISTS
    (
        SELECT 1
        FROM deleted
        WHERE DATEDIFF(YEAR, DataNascimento, GETDATE()) < 18
    )
    BEGIN
        RAISERROR
        (
            'Erro: Não é permitido excluir personagens com menos de 18 anos.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Se todos os registros tiverem idade >= 18, realiza a exclusão
    DELETE P
    FROM Personagem P
    INNER JOIN deleted d
        ON P.IDPersonagem = d.IDPersonagem;
END;
GO

-- Comandos para validação (opcionais):
-- DELETE FROM Personagem WHERE IDPersonagem = <id_de_um_personagem_menor_de_18>;
-- DELETE FROM Personagem WHERE IDPersonagem = <id_de_um_personagem_maior_ou_igual_a_18>;

-- ============================================
-- Questão 7: Trigger para atualizar Poder ao alterar MultiplicadorPoder
-- ============================================
-- Ao alterar o MultiplicadorPoder de uma Habilidade,
-- atualiza automaticamente o Poder dos personagens
-- relacionados, multiplicando o poder atual pelo novo valor.
CREATE TRIGGER trg_Habilidade_AtualizarPoderPersonagens
ON Habilidade
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(MultiplicadorPoder)
    BEGIN
        UPDATE P
        SET P.Poder = P.Poder * i.MultiplicadorPoder
        FROM Personagem P
        INNER JOIN Classe C
            ON P.IDClasse = C.IDClasse
        INNER JOIN inserted i
            ON C.IDHabilidade = i.IDHabilidade
        INNER JOIN deleted d
            ON i.IDHabilidade = d.IDHabilidade;
    END;
END;
GO

-- Comandos para validação (opcionais):
-- 1. Verificar o poder atual dos personagens de uma determinada classe:
-- SELECT P.IDPersonagem, P.Nome, P.Poder,
--        C.Nome AS Classe,
--        H.Nome AS Habilidade,
--        H.MultiplicadorPoder
-- FROM Personagem P
-- INNER JOIN Classe C ON P.IDClasse = C.IDClasse
-- INNER JOIN Habilidade H ON C.IDHabilidade = H.IDHabilidade;
--
-- 2. Atualizar o MultiplicadorPoder de uma habilidade (exemplo: alterar de 1 para 2):
-- UPDATE Habilidade
-- SET MultiplicadorPoder = 2
-- WHERE IDHabilidade = 1;
--
-- 3. Verificar novamente o poder dos personagens
-- (deve ter sido multiplicado pelo novo valor):
-- SELECT P.IDPersonagem, P.Nome, P.Poder,
--        C.Nome AS Classe,
--        H.Nome AS Habilidade,
--        H.MultiplicadorPoder
-- FROM Personagem P
-- INNER JOIN Classe C ON P.IDClasse = C.IDClasse
-- INNER JOIN Habilidade H ON C.IDHabilidade = H.IDHabilidade;