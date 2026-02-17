-- Questão 1. Crie uma Stored Procedure para inserir novos personagens na tabela Personagem. Os parâmetros devem incluir: @Nome, @Descricao, @DataNascimento, @IDRaca, @IDClasse, @Poder. Utilize TRY...CATCH para tratamento de erros e RAISERROR em caso de falha. 

CREATE OR ALTER PROCEDURE spInserirPersonagem
  -- definição de parametros.
  @Nome VARCHAR(100),
  @Descricao VARCHAR(500),
  @DataNascimento DATE,
  @IDRaca INT,
  @IDClasse INT,
  @Poder INT
AS
BEGIN
  BEGIN TRY
    -- Inserção do novo personagem
    INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder)
      VALUES (@Nome, @Descricao, @DataNascimento, @IDRaca, @IDClasse, @Poder);
  END TRY
  BEGIN CATCH
    -- Caso algo de errado, exibe a mensagem de erro
    PRINT 'Algo deu errado!';
    -- Exibe detalhes do erro
    SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
    RAISERROR('Erro tratado', 16, 1);
  END CATCH
END;
GO

-- Execução Valida
EXEC spInserirPersonagem 'MrPaxe2', 'Super mega paxe', '28-10-2024', 1, 1, 250;

-- Execução com erro (IDRaca inválido)
EXEC spInserirPersonagem 'MrPaxe3', 'Super mega paxe', '28-10-2024', 100, 1, 250;
SELECT * FROM Personagem; 
GO

-- Questão 2. Crie uma Stored Procedure para atualizar o campo Poder de um personagem específico com base no @IDPersonagem. Cancelar a atualização caso o valor informado para o Poder seja negativo, exibindo uma mensagem de erro personalizada por meio de RAISERROR. Utilize BEGIN TRANSACTION,COMMIT e ROLLBACK para garantir consistência.

CREATE OR ALTER PROCEDURE spAtualizarPoder
  -- Definição de parâmetros
  @IDPersonagem INT,
  @NovoPoder INT
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    -- Verifica se o novo poder é negativo
    IF (@NovoPoder < 0)
    BEGIN
      -- Sobe um erro caso o poder seja negativo
      RAISERROR('O valor do poder não pode ser negativo.', 16, 1);
      ROLLBACK TRANSACTION;
      RETURN;
    END
    -- Atualiza o poder do personagem
    UPDATE Personagem SET Poder = @NovoPoder
      WHERE IDPersonagem = @IDPersonagem;
    COMMIT TRANSACTION;
    PRINT 'Poder atualizado com sucesso.';
  END TRY
  BEGIN CATCH
    PRINT 'Algo deu errado!';
    -- Exibe detalhes do erro
    SELECT ERROR_MESSAGE() AS Mensagem, ERROR_NUMBER() AS Codigo, ERROR_LINE() AS Linha;
    ROLLBACK TRANSACTION;
    -- Dispara erro tratado
    RAISERROR('Erro tratado.', 16, 1);
  END CATCH
END;
GO

EXEC spAtualizarPoder 1, 500; -- Atualização válida
EXEC spAtualizarPoder 2, -100; -- Atualização inválida
GO

-- Questão 3. Crie uma Stored Procedure com parâmetro OUTPUT que receba como entrada o @IDRaca e retorne como saída (OUTPUT) a soma de poder de todos os personagens dessa raça.

CREATE OR ALTER PROCEDURE spSomaPoderPorRaca
  -- Definição de parâmetros
  @IDRaca INT,
  @SomaPoder INT OUTPUT
AS
BEGIN
  -- Inicializa o parâmetro de saída
  SET @SomaPoder = 0;
  -- Calcula a soma, usando ISNULL para tratar casos onde não há personagens
  SELECT @SomaPoder = ISNULL(SUM(Poder), 0) FROM Personagem
    WHERE IDRaca = @IDRaca;
END;
GO

DECLARE @Resultado INT;

EXEC spSomaPoderPorRaca @IDRaca = 1, @SomaPoder = @Resultado OUTPUT;
PRINT 'Soma de poder dos Humanos: ' + CAST(@Resultado AS VARCHAR(100));
GO

-- Questão 4. Crie uma Stored Procedure que deve receber dois parâmetros @IDPersonagemOrigem e @IDPersonagemDestino, além do valor @PoderTransferido. A procedure deve verificar se o personagem origem possui poder suficiente e subtrair o valor do poder de origem e somar ao destino, além de garantir que os personagens de origem e destino existam. Caso ocorra alguma das inconsistências, uma mensagem personalizada com RAISERROR deve ser exibida. 

CREATE OR ALTER PROCEDURE spTransferirPoder
  -- Definição de parâmetros
  @IDPersonagemOrigem INT,
  @IDPersonagemDestino INT,
  @PoderTransferido INT
AS
BEGIN
  -- Declaração de variáveis
  DECLARE @PoderOrigem INT;
  DECLARE @NomeOrigem VARCHAR(100);
  DECLARE @NomeDestino VARCHAR(100);
 
  BEGIN TRY
    -- Valida se o valor de poder transferido é positivo
    IF @PoderTransferido <= 0
    BEGIN
      RAISERROR('Erro: O valor de poder a ser transferido deve ser maior que zero.', 16, 1);
      RETURN;
    END
    -- Valida se os personagens não podem ser iguais
    IF @IDPersonagemOrigem = @IDPersonagemDestino
    BEGIN
      RAISERROR('Erro: Um personagem não pode transferir poder para si mesmo.', 16, 1);
      RETURN;
    END
    -- Verifica se o personagem de origem existe e obtém dados
    SELECT @PoderOrigem = Poder, @NomeOrigem = Nome FROM Personagem 
      WHERE IDPersonagem = @IDPersonagemOrigem;
    
    IF @PoderOrigem IS NULL
    BEGIN
      RAISERROR('Erro: Personagem de origem (ID: %d) não existe no banco de dados.', 16, 1, @IDPersonagemOrigem);
      RETURN;
    END
    
    -- Verifica se o personagem de destino existe
    SELECT @NomeDestino = Nome FROM Personagem 
      WHERE IDPersonagem = @IDPersonagemDestino;
    
    IF @NomeDestino IS NULL
    BEGIN
      RAISERROR('Erro: Personagem de destino (ID: %d) não existe no banco de dados.', 16, 1, @IDPersonagemDestino);
      RETURN;
    END
    
    -- Verifica se o personagem de origem possui poder suficiente
    IF @PoderOrigem < @PoderTransferido
    BEGIN
      RAISERROR('Erro: O personagem %s (ID: %d) possui apenas %d de poder, insuficiente para transferir %d.', 
        16, 1, @NomeOrigem, @IDPersonagemOrigem, @PoderOrigem, @PoderTransferido);
      RETURN;
    END
    
    -- Executa a transferência de poder
    UPDATE Personagem SET Poder = Poder - @PoderTransferido
      WHERE IDPersonagem = @IDPersonagemOrigem;
    
    UPDATE Personagem SET Poder = Poder + @PoderTransferido
      WHERE IDPersonagem = @IDPersonagemDestino;
    
    -- Mensagem de sucesso
    PRINT 'Transferência realizada com sucesso :3';
    PRINT 'Transferido ' + CAST(@PoderTransferido AS VARCHAR(10)) + ' pontos de poder';
    PRINT 'De: ' + @NomeOrigem;
    PRINT 'Para: ' + @NomeDestino;
  END TRY
  BEGIN CATCH
    -- Captura e relança erro tratado
    PRINT 'Algo deu errado!';
    SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
    RAISERROR('Erro tratado', 16, 1);
  END CATCH
END;
GO

-- Transferência válida
EXEC spTransferirPoder @IDPersonagemOrigem = 1, @IDPersonagemDestino = 2, @PoderTransferido = 50;
-- Erro - Personagem inexistente
EXEC spTransferirPoder @IDPersonagemOrigem = 999, @IDPersonagemDestino = 2, @PoderTransferido = 50;
-- Erro - Poder insuficiente
EXEC spTransferirPoder @IDPersonagemOrigem = 1, @IDPersonagemDestino = 2, @PoderTransferido = 1000;
-- Erro - Valor inválido
EXEC spTransferirPoder @IDPersonagemOrigem = 1, @IDPersonagemDestino = 2, @PoderTransferido = -10;
GO

-- Questão 5. Crie uma Scalar Function que receba o @IDClasse como parâmetro e retorne o MultiplicadorPoder da habilidade associada à classe.

CREATE OR ALTER FUNCTION dbo.fnObterMultiplicadorPoder(@IDClasse INT)
  RETURNS INT
AS
BEGIN
  -- Declara variável para o multiplicador
  DECLARE @MultiplicadorPoder INT;
  -- Busca o MultiplicadorPoder da habilidade da classe por ID
  SELECT @MultiplicadorPoder = H.MultiplicadorPoder
  FROM Classe C
    INNER JOIN Habilidade H 
      ON C.IDHabilidade = H.IDHabilidade
  WHERE C.IDClasse = @IDClasse;
  
  -- Se a classe não existir ou não tiver habilidade associada, retorna 1 (multiplicador neutro)
  IF @MultiplicadorPoder IS NULL
      SET @MultiplicadorPoder = 1;
  RETURN @MultiplicadorPoder;
END;
GO

SELECT dbo.fnObterMultiplicadorPoder(1) MultiplicadorMago;
SELECT dbo.fnObterMultiplicadorPoder(2) MultiplicadorGuerreiro;
SELECT dbo.fnObterMultiplicadorPoder(6) MultiplicadorDragao;
SELECT dbo.fnObterMultiplicadorPoder(999) MultiplicadorInexistente;
GO


-- Questão 6. Crie uma Scalar Function que receba uma @DataNascimento e retorna à idade em anos.


CREATE OR ALTER FUNCTION dbo.fnCalcularIdade(@DataNascimento DATETIME)
  RETURNS INT
AS
BEGIN
  DECLARE @Idade INT;
  -- Calcula a diferença em anos entre a data atual e a data de nascimento
  SET @Idade = DATEDIFF(YEAR, @DataNascimento, GETDATE());
  -- Verifica se o aniversário ja ocorreu
  IF(MONTH(@DataNascimento) > MONTH(GETDATE())) 
    OR (MONTH(@DataNascimento) = MONTH(GETDATE()) AND DAY(@DataNascimento) > DAY(GETDATE()))
  BEGIN
    -- Caso tenha ocorrido subtrai 1 ano
    SET @Idade = @Idade - 1;
  END
  RETURN @Idade;
END;
GO

SET DATEFORMAT DMY
SELECT dbo.fnCalcularIdade('15-07-1992') Idade_01;
SELECT dbo.fnCalcularIdade('22-10-1997') Idade_02;
GO


-- Questão 7. Crie uma Table Function Inline que retorne uma tabela contendo o Nome da raça e o  Poder médio dos personagens dessa raça

CREATE OR ALTER FUNCTION dbo.fnObterNomeClasse(@IDPersonagem INT)
RETURNS VARCHAR(100)
AS
BEGIN
  DECLARE @NomeClasse VARCHAR(100);
  -- Busca o nome da classe referente ao personagem
  SELECT @NomeClasse = C.Nome FROM Personagem P
    INNER JOIN Classe C 
      ON P.IDClasse = C.IDClasse
  WHERE P.IDPersonagem = @IDPersonagem;
  
  -- Se o personagem não existir, retorna 'Classe Indefinida'
  IF @NomeClasse IS NULL
      SET @NomeClasse = 'Classe Indefinida';
  RETURN @NomeClasse;
END;
GO

SELECT dbo.fnObterNomeClasse(1) AS ClasseElias;
SELECT dbo.fnObterNomeClasse(2) AS ClasseMarian;
SELECT dbo.fnObterNomeClasse(5) AS ClasseAeron;
SELECT dbo.fnObterNomeClasse(999) AS ClasseInexistente;
GO

-- Questão 8. Crie uma Table Function Multi Statement que retorne o Nome do personagem, Idade calculada (com base em DataNascimento), Nome da Classe, Nome da Raça. 

CREATE OR ALTER FUNCTION dbo.fnListarPersonagensCompleto()
RETURNS @TabelaPersonagens TABLE (
  NomePersonagem VARCHAR(100),
  Idade INT,
  NomeClasse VARCHAR(100),
  NomeRaca VARCHAR(100)
)
AS
BEGIN
  INSERT INTO @TabelaPersonagens (NomePersonagem, Idade, NomeClasse, NomeRaca)
  -- Seleciona os ano de nascimento e calcula a idade corretamente
  SELECT 
    P.Nome,
    DATEDIFF(YEAR, P.DataNascimento, GETDATE()) - 
    CASE 
      WHEN MONTH(P.DataNascimento) > MONTH(GETDATE()) 
        OR (MONTH(P.DataNascimento) = MONTH(GETDATE()) AND DAY(P.DataNascimento) > DAY(GETDATE()))
      THEN 1 
      ELSE 0 
    END AS Idade,
    C.Nome,
    R.Nome
  FROM Personagem P
  INNER JOIN Classe C 
    ON P.IDClasse = C.IDClasse
  INNER JOIN Raca R 
    ON P.IDRaca = R.IDRaca;
  RETURN;
END;
GO

SELECT * FROM dbo.fnListarPersonagensCompleto() ORDER BY NomePersonagem;
SELECT * FROM dbo.fnListarPersonagensCompleto() WHERE Idade > 30 ORDER BY Idade DESC;
SELECT * FROM dbo.fnListarPersonagensCompleto() WHERE NomeRaca = 'Humano';
GO

-- Questão 9. Crie uma Table Function Multi Statement que retorne para cada raça o Nome da raça, Quantidade de personagens, Soma total do poder, Poder médio dos personagens e quantidade de classes diferentes associadas aos personagens da raça.

CREATE OR ALTER FUNCTION dbo.fnListarRacasComInformacoes()
RETURNS @TabelaRacas TABLE (
  NomeRaca VARCHAR(100),
  QuantidadePersonagens INT,
  SomaTotalPoder INT,
  PoderMedio DECIMAL(10, 2),
  QuantidadeClassesDiferentes INT
)
AS
BEGIN
  INSERT INTO @TabelaRacas (NomeRaca, QuantidadePersonagens, 
  SomaTotalPoder, PoderMedio, QuantidadeClassesDiferentes)
  -- Seleciona as informações agregadas por raça
  SELECT 
    R.Nome,
    COUNT(P.IDPersonagem) AS QuantidadePersonagens,
    SUM(P.Poder) AS SomaTotalPoder,
    AVG(P.Poder) AS PoderMedio,
    COUNT(DISTINCT P.IDClasse) AS QuantidadeClassesDiferentes
  FROM Raca R
  LEFT JOIN Personagem P ON R.IDRaca = P.IDRaca
  GROUP BY R.Nome;

  RETURN;
END;
GO

SELECT * FROM dbo.fnListarRacasComInformacoes();
SELECT * FROM dbo.fnListarRacasComInformacoes() WHERE QuantidadePersonagens > 4;
SELECT * FROM dbo.fnListarRacasComInformacoes() WHERE PoderMedio > 50;
SELECT * FROM dbo.fnListarRacasComInformacoes() WHERE QuantidadeClassesDiferentes > 1;
GO
