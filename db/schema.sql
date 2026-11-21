CREATE TYPE tipo_falta_enum AS ENUM ('simples', 'grave', 'violenta');
CREATE TYPE cartao_enum AS ENUM ('nenhum', 'amarelo', 'vermelho');

CREATE TABLE "time"
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_federacao INT,
    cores VARCHAR(50),
    nome_fantasia VARCHAR(100),
    nome_de_fundacao VARCHAR(100),
    presidente VARCHAR(100),
    estado VARCHAR(50),
    transmissao_de_tv VARCHAR(100),
    abreviacao_nome VARCHAR(10)
);

CREATE TABLE jogador
(
    id_bid_jg INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    peso FLOAT,
    altura FLOAT,
    nacionalidade VARCHAR(50),
    status VARCHAR(30),
    contrato VARCHAR(100),
    posicao VARCHAR(30),
    nome VARCHAR(100),
    data_nascimento DATE,
    id_time INT
);

CREATE TABLE membro_comissao
(
    id_bid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    funcao VARCHAR(50),
    nome VARCHAR(100),
    id_time INT
);

CREATE TABLE historico_jogador_partida
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    entrada_campo TIME,
    saida_campo TIME,
    id_jogador INT,
    id_partida INT
);

CREATE TABLE gol
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_registro_jogador INT,
    tipo_gol VARCHAR(50),
    minutagem TIME
);

CREATE TABLE falta
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_registro_jogador INT,
    tipo_falta tipo_falta_enum,
    penalidade_coletiva VARCHAR(100),
    cartao cartao_enum,
    minutagem TIME
);

CREATE TABLE federacao
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sigla VARCHAR(10) UNIQUE,
    uf VARCHAR(2),
    data_fundacao DATE,
    abrangencia VARCHAR(50),
    nome VARCHAR(150)
);

CREATE TABLE campeonato
(
    codigo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    apelido VARCHAR(50),
    edicao INT,
    nome VARCHAR(150),
    promocao VARCHAR(100),
    quantidade_equipes INT,
    divisao INT,
    local VARCHAR(100),
    sistema VARCHAR(50)
);

CREATE TABLE dirigente
(
    cpf CHAR(11) PRIMARY KEY,
    id_federacao INT,
    data_nascimento DATE,
    nome VARCHAR(100),
    cargo VARCHAR(50)
);

CREATE TABLE oficial_arbitragem
(
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    categoria VARCHAR(50)
);
CREATE TABLE partida
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150),
    id_estadio INT,
    id_time_visitante INT,
    id_time_mandante INT,
    id_campeonato INT,
    publico INT,
    renda INT,
    descricao VARCHAR(255),
    etapa_campeonato INT,
    data DATE
);

CREATE TABLE estadio
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    capacidade INT,
    apelido VARCHAR(50),
    tipo_de_gramado VARCHAR(50),
    data_inauguracao DATE,
    estado VARCHAR(50),
    rua VARCHAR(150)
);

CREATE TABLE comando_comissao_jogador
(
    id_bid_cm INT,
    id_bid_jg INT,
    PRIMARY KEY (id_bid_cm, id_bid_jg)
);

CREATE TABLE elenco_time
(
    id_time INT,
    id_bid_jg INT,
    PRIMARY KEY (id_time, id_bid_jg)
);

CREATE TABLE comissao_time
(
    id_bid INT,
    id_time INT,
    PRIMARY KEY (id_bid, id_time)
);

CREATE TABLE organizacao_campeonato
(
    id_campeonato INT,
    id_federacao INT,
    PRIMARY KEY (id_campeonato, id_federacao)
);

CREATE TABLE escalacao_arbitragem
(
    id_partida INT,
    cpf CHAR(11),
    funcao VARCHAR(50),
    PRIMARY KEY (id_partida, cpf)
);

CREATE TABLE mando_campo_time
(
    id_estadio INT,
    id_time INT,
    PRIMARY KEY (id_estadio, id_time)
);

CREATE TABLE participacao_campeonato
(
    id_campeonato INT,
    id_time INT,
    PRIMARY KEY (id_campeonato, id_time)
);

ALTER TABLE historico_jogador_partida ADD FOREIGN KEY (id_jogador) REFERENCES jogador (id_bid_jg);
ALTER TABLE historico_jogador_partida ADD FOREIGN KEY (id_partida) REFERENCES partida (id);
ALTER TABLE gol ADD FOREIGN KEY (id_registro_jogador) REFERENCES historico_jogador_partida (id);
ALTER TABLE falta ADD FOREIGN KEY (id_registro_jogador) REFERENCES historico_jogador_partida (id);
ALTER TABLE jogador ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE membro_comissao ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE "time" ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE dirigente ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE partida ADD FOREIGN KEY (id_estadio) REFERENCES estadio (id);
ALTER TABLE partida ADD FOREIGN KEY (id_time_visitante) REFERENCES "time" (id);
ALTER TABLE partida ADD FOREIGN KEY (id_time_mandante) REFERENCES "time" (id);
ALTER TABLE partida ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (codigo);
ALTER TABLE comando_comissao_jogador ADD FOREIGN KEY (id_bid_cm) REFERENCES membro_comissao (id_bid);
ALTER TABLE comando_comissao_jogador ADD FOREIGN KEY (id_bid_jg) REFERENCES jogador (id_bid_jg);
ALTER TABLE elenco_time ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE elenco_time ADD FOREIGN KEY (id_bid_jg) REFERENCES jogador (id_bid_jg);
ALTER TABLE comissao_time ADD FOREIGN KEY (id_bid) REFERENCES membro_comissao (id_bid);
ALTER TABLE comissao_time ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE organizacao_campeonato ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (codigo);
ALTER TABLE organizacao_campeonato ADD FOREIGN KEY (id_federacao) REFERENCES federacao (id);
ALTER TABLE escalacao_arbitragem ADD FOREIGN KEY (id_partida) REFERENCES partida (id);
ALTER TABLE escalacao_arbitragem ADD FOREIGN KEY (cpf) REFERENCES oficial_arbitragem (cpf);
ALTER TABLE mando_campo_time ADD FOREIGN KEY (id_estadio) REFERENCES estadio (id);
ALTER TABLE mando_campo_time ADD FOREIGN KEY (id_time) REFERENCES "time" (id);
ALTER TABLE participacao_campeonato ADD FOREIGN KEY (id_campeonato) REFERENCES campeonato (codigo);
ALTER TABLE participacao_campeonato ADD FOREIGN KEY (id_time) REFERENCES "time" (id);