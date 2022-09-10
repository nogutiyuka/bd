DROP DATABASE IF EXISTS projeto_bd;

CREATE DATABASE projeto_bd;

USE projeto_bd;

DROP TABLE IF EXISTS chamada;

CREATE TABLE chamada (
id INT NOT NULL AUTO_INCREMENT
,presente CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_chamada PRIMARY KEY (id)
,CONSTRAINT chamada_deve_ser_S_ou_N CHECK (presente in ('S', 'N'))
);

INSERT INTO chamada (presente)
VALUES (DEFAULT);

INSERT INTO chamada (presente)
VALUES ('S');

INSERT INTO chamada (presente)
VALUES ('N');

SELECT * FROM chamada;

DROP TABLE IF EXISTS contrato;

CREATE TABLE contrato (
id INT NOT NULL AUTO_INCREMENT
,contrato_assinado CHAR(1) NOT NULL DEFAULT 'S'
,tipo_pagamento VARCHAR(200) NOT NULL
,CONSTRAINT pk_contrato PRIMARY KEY (id)
,CONSTRAINT contrato_assinado_S_ou_N CHECK (contrato_assinado IN ('S', 'N'))
);

INSERT INTO contrato (contrato_assinado, tipo_pagamento)
VALUES (DEFAULT, 'CARTÃO DE CRÉDITO');

INSERT INTO contrato (contrato_assinado, tipo_pagamento)
VALUES ('N', 'BOLETO');

INSERT INTO contrato (contrato_assinado, tipo_pagamento)
VALUES ('S', 'PIX');

SELECT * FROM contrato;

DROP TABLE IF EXISTS aluno;

CREATE TABLE aluno (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL
,sobrenome VARCHAR(100) NOT NULL
,email VARCHAR(100) NOT NULL UNIQUE
,cpf CHAR(15) NOT NULL
,data_nascimento DATE NOT NULL
,CONSTRAINT pk_aluno PRIMARY KEY (id)
);

INSERT INTO aluno (nome, sobrenome, email, cpf, data_nascimento)
VALUES ('JOÃO', 'SILVA', 'joao.silva@hotmail.com', '123.456.789-10', '2000-05-05');

INSERT INTO aluno (nome, sobrenome, email, cpf, data_nascimento)
VALUES ('MARIA', 'OLIVEIRA', 'maria.oliveira@gmail.com', '321.654.987-01', '1999-04-06');

INSERT INTO aluno (nome, sobrenome, email, cpf, data_nascimento)
VALUES ('MIGUEL', 'SOUZA', 'miguel_souza@gmail.com', '321.123.654-12', '1990-10-10');

SELECT * FROM aluno;

DROP TABLE IF EXISTS telefone;

CREATE TABLE telefone (
id INT NOT NULL AUTO_INCREMENT
,telefone CHAR(11) NOT NULL
,aluno_id INT NOT NULL
,CONSTRAINT pk_telefone PRIMARY KEY (id)
,CONSTRAINT fk_aluno FOREIGN KEY (aluno_id) REFERENCES aluno (id)
);

INSERT INTO telefone (telefone, aluno_id)
VALUES ('99999-1234', 1);

INSERT INTO telefone (telefone, aluno_id)
VALUES ('98888-1234', 2);

INSERT INTO telefone (telefone, aluno_id)
VALUES ('98777-1234', 3);

SELECT * FROM telefone;

DROP TABLE IF EXISTS estado;

CREATE TABLE estado (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL
,sigla CHAR(2) NOT NULL
,CONSTRAINT ok_estado PRIMARY KEY (id)
);

INSERT INTO estado (nome, sigla)
VALUES ('PARANÁ', 'PR');

INSERT INTO estado (nome, sigla)
VALUES ('RIO DE JANEIRO', 'RJ');

INSERT INTO estado (nome, sigla)
VALUES ('ACRE', 'AC');

SELECT * FROM estado;

DROP TABLE IF EXISTS cidade;

CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL
,estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
);

INSERT INTO cidade (nome, estado_id)
VALUES ('PARANAVAÍ', 1);

INSERT INTO cidade (nome, estado_id)
VALUES ('NITERÓI', 2);

INSERT INTO cidade (nome, estado_id)
VALUES ('RIO BRANCO', 3);

SELECT * FROM cidade;

DROP TABLE IF EXISTS endereco;

CREATE TABLE endereco (
id INT NOT NULL AUTO_INCREMENT
,rua_avenida VARCHAR(200) NOT NULL
,numero INT NOT NULL
,bairro VARCHAR(100) NOT NULL
,cep CHAR(10) NOT NULL
,cidade_id INT NOT NULL
,aluno_id INT NOT NULL
,CONSTRAINT pk_endereco PRIMARY KEY (id)
,CONSTRAINT fk_endereco_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT fk_endereco_aluno FOREIGN KEY (aluno_id) REFERENCES aluno (id)
);

INSERT INTO endereco (rua_avenida, numero, bairro, cep, cidade_id, aluno_id)
VALUES ('AVENIDA PARANÁ', 340 , 'CENTRO', '12.345-678', 1, 1);

INSERT INTO endereco (rua_avenida, numero, bairro, cep, cidade_id, aluno_id)
VALUES ('AVENIDA IPIRANGA', 1100 , 'CENTRO', '21.543-876', 2, 2);

INSERT INTO endereco (rua_avenida, numero, bairro, cep, cidade_id, aluno_id)
VALUES ('RUA MARTE', 260 , 'JARDIM BRASIL', '87.654-321', 3, 3);

SELECT * FROM endereco;

DROP TABLE IF EXISTS professor; 

CREATE TABLE professor (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL
,sobrenome VARCHAR (100) NOT NULL
,cpf CHAR(15) NOT NULL UNIQUE
,data_nascimento DATE NOT NULL
,endereco_id INT NOT NULL
,CONSTRAINT pk_professor PRIMARY KEY (id)
,CONSTRAINT fk_professor_endereco FOREIGN KEY (endereco_id) REFERENCES endereco (id)
);

INSERT INTO professor (nome, sobrenome, cpf, data_nascimento, endereco_id)
VALUES ('LUIZ', 'VIEIRA', '543.876.987-12', '1998-02-04', 1);

INSERT INTO professor (nome, sobrenome, cpf, data_nascimento, endereco_id)
VALUES ('FERNANDA', 'FERNANDES', '298.764.123-94', '2000-12-09', 2);

INSERT INTO professor (nome, sobrenome, cpf, data_nascimento, endereco_id)
VALUES ('BIANCA', 'FONSECA', '543.821.836-11', '2001-01-01', 3);

SELECT * FROM professor;

DROP TABLE IF EXISTS calendario_pedagogico;

CREATE TABLE calendario_pedagogico (
id INT NOT NULL AUTO_INCREMENT
,feriados DATE NOT NULL DEFAULT '0000-00-00'
,ferias_inicio DATE NOT NULL DEFAULT '0000-00-00'
,ferias_fim DATE NOT NULL DEFAULT '0000-00-00'
,folgas_inicio DATE NOT NULL DEFAULT '0000-00-00'
,folgas_fim DATE NOT NULL DEFAULT '0000-00-00'
,horario_aula_inicio TIME NOT NULL
,horario_aula_fim TIME NOT NULL
,CONSTRAINT pk_calendario_pedagogico PRIMARY KEY (id)
);

INSERT INTO calendario_pedagogico (horario_aula_inicio, horario_aula_fim)
VALUES ('8:00', '12:00');

INSERT INTO calendario_pedagogico (horario_aula_inicio, horario_aula_fim)
VALUES ('8:30', '13:30');

INSERT INTO calendario_pedagogico (horario_aula_inicio, horario_aula_fim)
VALUES ('15:00', '19:00');

SELECT * FROM calendario_pedagogico;

DROP TABLE IF EXISTS cronograma;

CREATE TABLE cronograma (
id INT NOT NULL AUTO_INCREMENT
,data_inicial DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,dia_semana VARCHAR(15) NOT NULL
,calendario_pedagogico_id INT NOT NULL
,CONSTRAINT pk_cronograma PRIMARY KEY (id)
,CONSTRAINT fk_cronograma_calendario_pedagogico FOREIGN KEY (calendario_pedagogico_id) REFERENCES calendario_pedagogico (id)
);

INSERT INTO cronograma (dia_semana, calendario_pedagogico_id)
VALUES ('SEGUNDA-FEIRA', 1);

INSERT INTO cronograma (dia_semana, calendario_pedagogico_id)
VALUES ('TERÇA-FEIRA', 2);

INSERT INTO cronograma (dia_semana, calendario_pedagogico_id)
VALUES ('SEXTA-FEIRA', 3);

SELECT * FROM cronograma;

DROP TABLE IF EXISTS turma;

CREATE TABLE turma (
id INT NOT NULL AUTO_INCREMENT
,carga_horaria INT NOT NULL
,presencial CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_turma PRIMARY KEY (id)
,CONSTRAINT presencial_deve_ser_S_ou_N CHECK (presencial IN ('S', 'N'))
);

INSERT INTO turma (carga_horaria)
VALUES (100);

INSERT INTO turma (carga_horaria, presencial)
VALUES (30, 'N');

INSERT INTO turma (carga_horaria)
VALUES (42);

SELECT * FROM turma;

DROP TABLE IF EXISTS matricula;

CREATE TABLE matricula (
turma_id INT NOT NULL
,aluno_id INT NOT NULL
,CONSTRAINT fk_matricula_turma FOREIGN KEY (turma_id) REFERENCES turma (id)
,CONSTRAINT fk_matricula_aluno FOREIGN KEY (aluno_id) REFERENCES aluno (id)
);

INSERT INTO matricula (turma_id, aluno_id)
VALUES (1, 1);

INSERT INTO matricula (turma_id, aluno_id)
VALUES (2, 2);

INSERT INTO matricula (turma_id, aluno_id)
VALUES (3, 3);

SELECT * FROM matricula;

DROP TABLE IF EXISTS agendamento;

CREATE TABLE agendamento (
id INT NOT NULL AUTO_INCREMENT
,tipo_atendimento VARCHAR(45) NOT NULL
,tipo_aula VARCHAR(45) NOT NULL
,qtd_total_hrs INT NOT NULL
,cronograma_id INT NOT NULL
,professor_id INT NOT NULL
,CONSTRAINT pk_agendamento PRIMARY KEY (id)
,CONSTRAINT fk_agendamento_cronograma FOREIGN KEY (cronograma_id) REFERENCES cronograma (id)
,CONSTRAINT fk_agendamento_professor FOREIGN KEY (professor_id) REFERENCES professor (id)
);

INSERT INTO agendamento (tipo_atendimento, tipo_aula, qtd_total_hrs, cronograma_id, professor_id)
VALUES ('PRESENCIAL', 'EM TURMA', 100, 1, 1);

INSERT INTO agendamento (tipo_atendimento, tipo_aula, qtd_total_hrs, cronograma_id, professor_id)
VALUES ('ONLINE', 'VIP', 30, 2, 2);

INSERT INTO agendamento (tipo_atendimento, tipo_aula, qtd_total_hrs, cronograma_id, professor_id)
VALUES ('PRESENCIAL', 'EM TURMA', 42, 3, 3);

SELECT * FROM agendamento;

DROP TABLE IF EXISTS aula;

CREATE TABLE aula (
id INT NOT NULL AUTO_INCREMENT
,categoria VARCHAR(100) NOT NULL
,data_aula DATETIME NOT NULL
,conteudo VARCHAR(500) NOT NULL
,agendamento_id INT NOT NULL
,CONSTRAINT pk_aula PRIMARY KEY (id)
,CONSTRAINT fk_aula_agendamento FOREIGN KEY (agendamento_id) REFERENCES agendamento (id)
);

INSERT INTO aula (categoria, data_aula, conteudo, agendamento_id)
VALUES ('SPEAKING', '2022-09-09', 'VOCABULARY', 1);

INSERT INTO aula (categoria, data_aula, conteudo, agendamento_id)
VALUES ('WRITING', '2022-10-10', 'PREPOSITIONS', 2);

INSERT INTO aula (categoria, data_aula, conteudo, agendamento_id)
VALUES ('LISTENING', '2022-11-11', 'LIKING WORDS', 3);

SELECT * FROM aula;