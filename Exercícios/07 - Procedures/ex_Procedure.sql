-- 1. Criar uma Stored Procedure que retorna à quantidade de Cargos cadastrados. 

CREATE OR ALTER PROCEDURE spQuantidadeCargos
AS
BEGIN
  SELECT COUNT(*) Quantidade_Cargos
    FROM Cargo; 
END;
GO

EXEC spQuantidadeCargos;
GO

-- 2. Criar uma Stored Procedure que recebe como parâmetro o nome da Cidade e retorno a quantidade de empregados na mesma. 

CREATE OR ALTER PROCEDURE spQuantidadeEmpregadosPorCidade
  @Cidade varchar(150)
AS
BEGIN
  SELECT COUNT(*) Empregados, Cidade
  FROM Empregado
    WHERE Cidade = @Cidade
    GROUP BY Cidade;
END;
GO

EXEC spQuantidadeEmpregadosPorCidade @Cidade = 'Sorocaba';
GO

-- 3. Criar uma Stored Procedure que realiza a inserção de um Cargo (todos os campos devem ser informados via parâmetro). 

CREATE OR ALTER PROCEDURE spInserirCargo
  @Nome varchar(250),
  @Nivel varchar(255),
  @Salario decimal(10,2)
AS
BEGIN
  INSERT INTO Cargo (Nome, Nivel, SalarioBase) 
    VALUES(@Nome, @Nivel, @Salario);
END;
GO

EXEC spInserirCargo 
  @Nome = 'Administrador de Banco de Dados',
  @Nivel = 'Sênior',
  @Salario = 6000.00;
GO

-- 4. Criar uma Stored Procedure que realiza a inserção de um Departamento (somente o nome deve ser informado via parâmetro).

CREATE OR ALTER PROCEDURE spInserirDepartamento
  @Nome varchar(250)
AS
BEGIN 
  INSERT INTO Departamento (Nome) VALUES(@Nome);
END;
GO

EXEC spInserirDepartamento 
  @Nome = 'Logística';
GO


-- 5. Criar uma Stored Procedure que recebe como parâmetro o Nome do Empregado e retorna via parâmetro de OUTPUT o ano e mês da sua contratação. 

CREATE OR ALTER PROCEDURE spDataContratacaoEmpregado
  @Nome varchar(250),
  @AnoContratacao int OUTPUT,
  @MesContratacao int OUTPUT
AS
BEGIN
  SELECT 
    @AnoContratacao = YEAR(DataContratacao),
    @MesContratacao = MONTH(DataContratacao)
  FROM Empregado
    WHERE Nome = @Nome;
END;
GO

DECLARE 
  @Ano int,
  @Mes int;

EXEC spDataContratacaoEmpregado 
  @Nome = 'Ana Paula',
  @AnoContratacao = @Ano OUTPUT,
  @MesContratacao = @Mes OUTPUT;

SELECT @Ano Ano_Contratacao, @Mes Mes_Contratacao;
GO
-- 6. Criar uma Stored Procedure que recebe 3 (três) valores decimais, e retorna via parâmetro de OUTPUT a média aritmética entre eles. 

CREATE OR ALTER PROCEDURE spTresValoresMedia
  @Valor1 numeric,
  @Valor2 numeric,
  @Valor3 numeric,
  @Media numeric OUTPUT
AS
BEGIN
  SET @Media = (@Valor1 + @Valor2 + @Valor3) / 3;
END;
GO

DECLARE @Media numeric;

EXEC spTresValoresMedia
  @Valor1 = 60,
  @Valor2 = 5,
  @Valor3 = 25,
  @Media = @Media OUTPUT;
SELECT @Media Media_Aritmetica;
GO

-- 7. Criar uma Stored Procedure que realiza a inserção de um Empregado (somente os campos obrigatórios (not null) devem ser informados via parâmetro). Realizar o tratamento de erros 

CREATE OR ALTER PROCEDURE spInserirEmpregado
  @Nome varchar(250),
  @Cidade varchar(150),
  @DataContratacao date,
  @IDDepartamento int,
  @IDCargo int
AS
BEGIN
  BEGIN TRY
    INSERT INTO Empregado (Nome, Cidade, DataContratacao, IDDepartamento, IDCargo)
    VALUES (@Nome, @Cidade, @DataContratacao, @IDDepartamento, @IDCargo);
  END TRY
  BEGIN CATCH
    SELECT ERROR_MESSAGE() Mensagem, ERROR_NUMBER() Codigo, ERROR_LINE() Linha;
    RAISERROR('Erro tratado', 16, 1);
  END CATCH
END;
GO

EXEC spInserirEmpregado
  @Nome = 'Mr Paxe',
  @Cidade = 'Tatuí',
  @DataContratacao = '2002-01-15',
  @IDDepartamento = 3,
  @IDCargo = 65;
GO