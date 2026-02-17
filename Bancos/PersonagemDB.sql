USE master;
GO
DROP DATABASE PersonagemDB;
GO
CREATE DATABASE PersonagemDB;
GO
USE PersonagemDB;
GO

CREATE TABLE Raca(
	IDRaca int not null identity,
	Nome varchar(100) not null,
	Descricao varchar(500),
	Origem varchar(150) not null,
	CONSTRAINT PKIDRaca PRIMARY KEY (IDRaca)
)
GO

CREATE TABLE Habilidade(
	IDHabilidade int not null identity,
	Nome varchar(200) not null,
	MultiplicadorPoder int,
	CONSTRAINT PKIDHabilidade PRIMARY KEY (IDHabilidade)
)
GO

CREATE TABLE Classe(
	IDClasse int not null identity,
	Nome varchar(100) not null,
	Caracteristicas varchar(500),
	IDHabilidade int,
	CONSTRAINT PKIDClasse PRIMARY KEY (IDClasse),
	CONSTRAINT FKIDHabilidadeClasse FOREIGN KEY (IDHabilidade) REFERENCES Habilidade(IDHabilidade)
)
GO

CREATE TABLE Personagem(
	IDPersonagem int not null identity,
	Nome varchar(100) not null,
	Descricao varchar(500) not null,
	DataNascimento datetime not null,
	IDRaca int not null,
	IDClasse int not null,
	Poder int not null,
	CONSTRAINT PKIDPersonagem 
    PRIMARY KEY (IDPersonagem),
	CONSTRAINT FKIDPersonagemRaca 
    FOREIGN KEY (IDRaca) 
    REFERENCES Raca(IDRaca),
	CONSTRAINT FKIDPersonagemClasse 
    FOREIGN KEY (IDClasse) 
    REFERENCES Classe(IDClasse)
)
GO

INSERT INTO Raca (Nome, Descricao, Origem) VALUES
  ('Humano', 'Versátil e adaptável', 'Diversos continentes'),
  ('Elfo', 'Seres de orelhas pontudas e grande afinidade com a natureza', 'Floresta de Eldar'),
  ('Anão', 'Baixos e robustos, mestres da forja', 'Montanhas de Durin'),
  ('Orc', 'Fortes e agressivos, vindos das terras sombrias', 'Montes Cinzentos'),
  ('Draconato', 'Descendentes de dragões, imponentes e sábios', 'Reinos Dracônicos'),
  ('Goblin', 'Pequenos, rápidos e astutos', 'Cavernas do Norte'),
  ('Troll', 'Criaturas grandes e resistentes', 'Pântanos de Borran'),
  ('Fada', 'Pequenas criaturas mágicas aladas', 'Floresta Encantada'),
  ('Vampiro', 'Seres noturnos que vivem da energia vital', 'Terras Sombrias'),
  ('Licantropo', 'Humanos amaldiçoados que se transformam em lobos', 'Região do Norte Gelado');
GO

INSERT INTO Habilidade (Nome, MultiplicadorPoder) VALUES
  ('Magia Arcana', 2),
  ('Fúria Bárbara', 3),
  ('Disparo Preciso', 2),
  ('Camuflagem Sombria', 4),
  ('Canto Sagrado', 1),
  ('Sopro de Fogo', 5),
  ('Golpe Giratório', 2),
  ('Invocação Espiritual', 3),
  ('Mordida Sombria', 4),
  ('Regeneração Selvagem', 3),
  ('Magia Proíbida', 9),
  ('Manipulação Temporal', 10);
GO

INSERT INTO Classe (Nome, Caracteristicas, IDHabilidade) VALUES
  ('Mago', 'Especialista em magias', 1),
  ('Guerreiro', 'Especialista em combate corpo a corpo', 2),
  ('Arqueiro', 'Perito em ataques à distância', 3),
  ('Assassino', 'Mestre da furtividade e ataques críticos', 4),
  ('Clérigo', 'Curandeiro e defensor divino', 5),
  ('Dragão Ancião', 'Domina poderes elementais antigos', 6),
  ('Bárbaro', 'Movido por fúria incontrolável', 2),
  ('Xamã', 'Conector entre o mundo espiritual e o físico', 8),
  ('Vampiro Nobre', 'Habilidade sobrenatural em combate e magia', 9),
  ('Lobisomem', 'Guia-se pelo instinto e pela força bruta', 10),
  ('Cronox', 'Seres Semi Onipotentes que manipulam o tempo', 10);
GO

SET DATEFORMAT DMY;
-- Humanos com classes variadas
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Elias', 'Humano guerreiro disciplinado', '15-07-1992', 1, 2, 240),
  ('Marian', 'Humana arqueira de elite', '22-10-1997', 1, 3, 230),
  ('Lucian', 'Humano assassino ágil', '18-03-1995', 1, 4, 270),
  ('Helena', 'Humana clériga devota', '11-06-1994', 1, 5, 200),
  ('Aeron', 'Humano mago de batalhas', '10-09-1989', 1, 1, 260);
GO

-- Elfos com classes diferentes
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Thalindra', 'Elfa maga especialista em feitiços arcanos', '09-02-1993', 2, 1, 290),
  ('Faelar', 'Elfo guerreiro das árvores', '03-03-1985', 2, 2, 310),
  ('Neriel', 'Elfa curandeira espiritual', '14-11-1998', 2, 5, 210),
  ('Lareth', 'Elfo xamã das florestas antigas', '19-08-1980', 2, 8, 320);
GO

-- Anões com profissões diversas
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Gorim', 'Anão xamã dos espíritos da terra', '07-07-1982', 3, 8, 280),
  ('Borin', 'Anão bárbaro destemido', '03-10-1976', 3, 7, 330);
GO

-- Orcs com funções variadas
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Grash', 'Orc guerreiro das planícies', '04-04-1990', 4, 2, 340),
  ('Urmak', 'Orc clérigo do caos', '08-08-1986', 4, 5, 310),
  ('Zog', 'Orc mago das trevas', '13-12-1992', 4, 1, 270),
  ('Kroth', 'Orc arqueiro selvagem', '19-06-1995', 4, 3, 260),
  ('Throg', 'Orc xamã das cinzas', '02-02-1980', 4, 8, 350);
GO

-- Draconatos com classes variadas
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Valen', 'Draconato guerreiro flamejante', '05-07-1981', 5, 2, 460),
  ('Zerath', 'Draconato mago elemental', '29-09-1984', 5, 1, 480),
  ('Rhazor', 'Draconato clérigo dracônico', '16-03-1978', 5, 5, 450),
  ('Thalgron', 'Draconato bárbaro colossal', '21-01-1975', 5, 7, 490);
GO

-- Goblins com várias ocupações
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Rug', 'Goblin arqueiro de precisão', '04-05-2013', 6, 3, 130),
  ('Tuk', 'Goblin guerreiro impulsivo', '11-12-2010', 6, 2, 140),
  ('Mog', 'Goblin xamã tribal', '02-04-2012', 6, 8, 170),
  ('Pik', 'Goblin assassino sorrateiro', '25-06-2014', 6, 4, 160);
GO

-- Vampiros em diferentes funções
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Valenor', 'Vampiro mago ancestral', '10-10-1920', 9, 1, 430),
  ('Cassian', 'Vampiro guerreiro imortal', '14-04-1810', 9, 2, 410),
  ('Mara', 'Vampira clériga corrompida', '06-06-1870', 9, 5, 390),
  ('Draven', 'Vampiro assassino das sombras', '21-09-1900', 9, 4, 420);
GO

-- Lobisomens com papéis variados
INSERT INTO Personagem (Nome, Descricao, DataNascimento, IDRaca, IDClasse, Poder) VALUES
  ('Ragnar', 'Lobisomem guerreiro das colinas', '22-02-1999', 10, 2, 350),
  ('Fenra', 'Lobisomem clériga da lua', '10-01-2002', 10, 5, 300),
  ('Kaen', 'Lobisomem xamã lunar', '09-09-2001', 10, 8, 340);
GO