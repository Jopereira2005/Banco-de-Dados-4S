-- 1. Inserir em cada uma das tabelas pelo menos 5 (cinco) linhas de dados 
-- • Atenção para a ordem de inserção das informações nas tabelas 
-- • Inserir um empregado com o nome “João da Silva” 
-- • Inserir um departamento com o nome “Judicial” 

INSERT INTO Departamento (Nome) VALUES
  ('Recursos Humanos'),
  ('Financeiro'),
  ('Judicial'),
  ('Tecnologia da Informação'),
  ('Marketing'),
  ('Operacional');
GO

INSERT INTO Cargo (Nome, Nivel, SalarioBase) VALUES
  ('Desenvolvedor', 'Pleno', 3000.00),
  ('Analista de Sistemas', 'Sênior', 5000.00),
  ('Tester', 'Pleno', 2500.00),
  ('Gerente de Projetos', 'Sênior', 7000.00),
  ('Suporte Técnico', 'Júnior', 1500.00),
  ('Estagiário', 'Estágio', 400.00),
  ('João da Silva', 'Tester', 100.00);
GO

SET DATEFORMAT DMY
INSERT INTO Empregado (Nome, Cidade, Estado, DataContratacao, IDDepartamento, IDCargo) VALUES
  ('Ana Paula', 'Sorocaba', 'SP', '15-01-2020', 1, 1),
  ('Carlos Eduardo', 'Rio de Janeiro', 'RJ', '22-03-2019', 2, 2),
  ('Mariana Silva', 'Belo Horizonte', 'MG', '30-07-2021', 3, 3),
  ('Lucas Fernandes', 'Vitoria', 'ES', '05-11-2018', 4, 4),
  ('Fernanda Souza', 'São Paulo', 'SP', '12-05-2022', 5, 5),
  ('João da Silva', 'São Roque', 'SP', '20-02-2023', 1, 3),
  ('Pedro Henrique', 'Campinas', 'SP', '18-09-2020', 5, 2),
  ('João da Silva', 'Santos', 'SP', '03-12-2019', 1, 1),
  ('Rafael Lima', 'Niterói', 'RJ', '25-04-2021', 2, 2),
  ('Beatriz Martins', 'Uberlândia', 'MG', '14-08-2018', 3, 3),
  ('Marcos Vinicius', 'Cachoeiro de Itapemirim', 'ES', '29-10-2022', 4, 4),
  ('Camila Ribeiro', 'São José dos Campos', 'SP', '11-03-2023', 5, 5);
GO
 
-- 2. Atualizar o Nível dos cargos para “Júnior” quando o nome for “Tester” 

UPDATE Cargo SET Nivel = 'Júnior' WHERE Nome = 'Tester';
GO

-- 3. Atualizar o Estado dos Empregados para SP, quando a cidade for Sorocaba, São Paulo ou São Roque. 

UPDATE Empregado SET Estado = 'SP' WHERE Cidade IN ('Sorocaba', 'São Paulo', 'São Roque');
GO

-- 4. Atualizar o Nome do Departamento com nome “Judicial” para “Jurídico”. 

UPDATE Departamento SET Nome = 'Jurídico' WHERE Nome = 'Judicial';
GO

-- 5. Excluir empregados com nome “João da Silva” 

DELETE FROM Empregado WHERE Nome = 'João da Silva';
GO

-- 6. Excluir os cargos com SalarioBase menores que R$ 500,00 

DELETE FROM Cargo WHERE SalarioBase < 500.00;
GO

-- 7. Excluir os departamentos com nome “Operacional”.

DELETE FROM Departamento WHERE Nome = 'Operacional';
GO
