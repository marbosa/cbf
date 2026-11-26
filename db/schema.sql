CREATE TABLE jogador (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nacionalidade VARCHAR(50) NOT NULL,
    status VARCHAR(30),
    contrato VARCHAR(50),
    posicao VARCHAR(30) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    peso DECIMAL(5,2),
    altura DECIMAL(3,2)
);

CREATE TABLE membro_comissao (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    funcao VARCHAR(50),
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE federacao (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    uf CHAR(2) NOT NULL,
    data_fundacao DATE NOT NULL,
    abrangencia VARCHAR(30) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    sigla CHAR(3) NOT NULL,
    UNIQUE (sigla),
    UNIQUE (nome)
);

CREATE TABLE "time" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_federacao INT NOT NULL,
    cores VARCHAR(50),
    nome_fantasia VARCHAR(100),
    data_fundacao DATE NOT NULL,
    presidente VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    brasao BYTEA NOT NULL,
    sigla CHAR(3) NOT NULL,
    UNIQUE (sigla),
    UNIQUE (nome_fantasia)
);

CREATE TABLE campeonato (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    edicao VARCHAR(20) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    promocao VARCHAR(100) NOT NULL,
    quantidade_equipes INT NOT NULL,
    divisao VARCHAR(30) NOT NULL,
    "local" VARCHAR(100) NOT NULL,
    sistema VARCHAR(50) NOT NULL,
    apelido VARCHAR(50) NOT NULL,
    UNIQUE (nome, edicao)
);

CREATE TABLE dirigente (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_federacao INT NOT NULL,
    data_nascimento DATE,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL
);

CREATE TABLE oficial_arbitragem (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    categoria VARCHAR(30) NOT NULL
);

CREATE TABLE estadio (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    capacidade INT,
    nome VARCHAR(100) NOT NULL,
    apelido VARCHAR(50),
    tipo_gramado VARCHAR(30),
    data_inauguracao DATE,
    rua VARCHAR(100),
    estado CHAR(2),
    UNIQUE (nome)
);

CREATE TABLE partida (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_estadio INT NOT NULL,
    id_campeonato INT NOT NULL,
    publico INT,
    renda DECIMAL(12,2),
    descricao VARCHAR(255),
    etapa_campeonato VARCHAR(50) NOT NULL,
    "data" TIMESTAMP NOT NULL,
    nome VARCHAR(100) NOT NULL,
    id_time_mandante INT NOT NULL,
    id_time_visitante INT NOT NULL,
    CHECK (id_time_mandante <> id_time_visitante)
);

CREATE TABLE gol (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_partida INT NOT NULL,
    tipo_gol VARCHAR(30),
    minutagem TIME NOT NULL,
    id_jogador INT NOT NULL,
    UNIQUE (id_partida, minutagem, id_jogador)
);

CREATE TABLE falta (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_partida INT NOT NULL,
    tipo_falta VARCHAR(30) NOT NULL,
    penalidade_coletiva BOOLEAN,
    cartao VARCHAR(20),
    minutagem TIME NOT NULL,
    id_jogador INT NOT NULL
);

CREATE TABLE comando_comissao_jogador (
    id_membro_comissao INT NOT NULL,
    id_jogador INT NOT NULL,
    PRIMARY KEY (id_membro_comissao, id_jogador)
);

CREATE TABLE elenco_time (
    id_time INT NOT NULL,
    id_jogador INT NOT NULL,
    data_inicio DATE NOT NULL,
    PRIMARY KEY (id_time, id_jogador)
);

CREATE TABLE comissao_time (
    id_time INT NOT NULL,
    id_membro_comissao INT NOT NULL,
    PRIMARY KEY (id_time, id_membro_comissao)
);

CREATE TABLE organizacao_campeonato (
    id_federacao INT NOT NULL,
    id_campeonato INT NOT NULL,
    PRIMARY KEY (id_federacao, id_campeonato)
);

CREATE TABLE escalacao_arbitragem (
    id_partida INT NOT NULL,
    id_oficial_arbitragem INT NOT NULL,
    funcao VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_partida, id_oficial_arbitragem)
);

CREATE TABLE participacao_campeonato (
    id_campeonato INT NOT NULL,
    id_time INT NOT NULL,
    PRIMARY KEY (id_campeonato, id_time)
);

ALTER TABLE gol ADD FOREIGN KEY (id_partida) REFERENCES partida (id);
ALTER TABLE gol ADD FOREIGN KEY (id_jogador) REFERENCES jogador (id);
ALTER TABLE falta ADD FOREIGN KEY (id_partida) REFERENCES partida (id);
ALTER TABLE falta ADD FOREIGN KEY (id_jogador) REFERENCES jogador (id);
ALTER TABLE "time" ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE dirigente ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE partida ADD FOREIGN KEY (id_estadio) REFERENCES estadio (id);
ALTER TABLE partida ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (id);
ALTER TABLE partida ADD FOREIGN KEY (id_time_mandante) REFERENCES "time" (id);
ALTER TABLE partida ADD FOREIGN KEY (id_time_visitante) REFERENCES "time" (id);
ALTER TABLE comando_comissao_jogador ADD FOREIGN KEY (id_membro_comissao) REFERENCES membro_comissao (id);
ALTER TABLE comando_comissao_jogador ADD FOREIGN KEY (id_jogador) REFERENCES jogador (id);
ALTER TABLE elenco_time ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE elenco_time ADD FOREIGN KEY (id_jogador) REFERENCES jogador (id);
ALTER TABLE comissao_time ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE comissao_time ADD FOREIGN KEY (id_membro_comissao) REFERENCES membro_comissao (id);
ALTER TABLE organizacao_campeonato ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE organizacao_campeonato ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (id);
ALTER TABLE escalacao_arbitragem ADD FOREIGN KEY (id_partida) REFERENCES partida (id);
ALTER TABLE escalacao_arbitragem ADD FOREIGN KEY (id_oficial_arbitragem) REFERENCES oficial_arbitragem (id);
ALTER TABLE participacao_campeonato ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (id);
ALTER TABLE participacao_campeonato ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
