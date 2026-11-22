-- =====================================================
-- Jogo de RPG online - Criação do banco e das tabelas
-- Sintaxe: MySQL / MariaDB
-- =====================================================

CREATE DATABASE IF NOT EXISTS rpg_online
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE rpg_online;

-- -----------------------------------------------------
-- Tabela USUARIOS
-- -----------------------------------------------------
CREATE TABLE USUARIOS (
    UsuarioId  INT AUTO_INCREMENT,
    Email      VARCHAR(150) NOT NULL,
    SenhaHash  VARCHAR(255) NOT NULL,
    CONSTRAINT pk_usuarios PRIMARY KEY (UsuarioId),
    CONSTRAINT uq_usuarios_email UNIQUE (Email)
);

-- -----------------------------------------------------
-- Tabela CLASSES
-- -----------------------------------------------------
CREATE TABLE CLASSES (
    ClasseId   INT AUTO_INCREMENT,
    Nome       VARCHAR(50)  NOT NULL,
    Descricao  VARCHAR(255),
    CONSTRAINT pk_classes PRIMARY KEY (ClasseId),
    CONSTRAINT uq_classes_nome UNIQUE (Nome)
);

-- -----------------------------------------------------
-- Tabela HABILIDADES
-- -----------------------------------------------------
CREATE TABLE HABILIDADES (
    HabilidadeId  INT AUTO_INCREMENT,
    Nome          VARCHAR(50) NOT NULL,
    CONSTRAINT pk_habilidades PRIMARY KEY (HabilidadeId),
    CONSTRAINT uq_habilidades_nome UNIQUE (Nome)
);

-- -----------------------------------------------------
-- Tabela PERSONAGENS
-- USUARIOS 1:N PERSONAGENS | CLASSES 1:N PERSONAGENS
-- -----------------------------------------------------
CREATE TABLE PERSONAGENS (
    PersonagemId    INT AUTO_INCREMENT,
    NomePersonagem  VARCHAR(50) NOT NULL,
    UsuarioId       INT NOT NULL,
    ClasseId        INT NOT NULL,
    CONSTRAINT pk_personagens PRIMARY KEY (PersonagemId),
    CONSTRAINT uq_personagens_nome UNIQUE (NomePersonagem),
    CONSTRAINT fk_personagens_usuario FOREIGN KEY (UsuarioId)
        REFERENCES USUARIOS (UsuarioId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_personagens_classe FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela associativa CLASSES_HABILIDADES
-- Resolve a relação N:N entre CLASSES e HABILIDADES
-- -----------------------------------------------------
CREATE TABLE CLASSES_HABILIDADES (
    ClasseId      INT NOT NULL,
    HabilidadeId  INT NOT NULL,
    CONSTRAINT pk_classes_habilidades PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT fk_ch_classe FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ch_habilidade FOREIGN KEY (HabilidadeId)
        REFERENCES HABILIDADES (HabilidadeId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Índices para acelerar consultas pelas chaves estrangeiras
-- -----------------------------------------------------
CREATE INDEX idx_personagens_usuario ON PERSONAGENS (UsuarioId);
CREATE INDEX idx_personagens_classe  ON PERSONAGENS (ClasseId);
CREATE INDEX idx_ch_habilidade       ON CLASSES_HABILIDADES (HabilidadeId);
