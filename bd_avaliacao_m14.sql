-- Teste para github
-- Base de Dados de apoio ao Trabalho de Avaliação
-- Módulo: Linguagem de Manipulação de Dados (SQL)
-- SGBD: MySQL / MariaDB
-- Objetivo: permitir aos alunos praticar SELECT, WHERE, JOIN, UNION,
-- funções de agregação, GROUP BY, HAVING e subqueries, sem avaliar a
-- criação das tabelas, chaves e registos.

DROP DATABASE IF EXISTS bd_avaliacao_m14;
CREATE DATABASE bd_avaliacao_m14
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE bd_avaliacao_m14;

-- ============================================================
-- TABELAS
-- ============================================================

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(50),
    distrito VARCHAR(50),
    data_registo DATE,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fornecedor VARCHAR(100),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE encomendas (
    id_encomenda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_encomenda DATE NOT NULL,
    estado VARCHAR(30) NOT NULL,
    desconto DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE linhas_encomenda (
    id_linha INT PRIMARY KEY AUTO_INCREMENT,
    id_encomenda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_encomenda) REFERENCES encomendas(id_encomenda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- ============================================================
-- DADOS
-- ============================================================

INSERT INTO categorias (nome, descricao) VALUES
('Computadores', 'Computadores portáteis e de secretária'),
('Componentes', 'Componentes para computadores'),
('Periféricos', 'Teclados, ratos, monitores e outros periféricos'),
('Redes', 'Equipamentos e acessórios de rede'),
('Armazenamento', 'Discos, SSD e dispositivos de armazenamento'),
('Software', 'Software e licenças'),
('Impressão', 'Impressoras e consumíveis');

INSERT INTO clientes (nome, email, cidade, distrito, data_registo, ativo) VALUES
('Ana Silva', 'ana.silva@email.pt', 'Portimão', 'Faro', '2025-01-15', TRUE),
('Bruno Costa', 'bruno.costa@email.pt', 'Lagos', 'Faro', '2025-02-10', TRUE),
('Carla Martins', 'carla.martins@email.pt', 'Faro', 'Faro', '2025-02-21', TRUE),
('Daniel Sousa', 'daniel.sousa@email.pt', 'Lisboa', 'Lisboa', '2025-03-05', TRUE),
('Eva Rodrigues', 'eva.rodrigues@email.pt', 'Setúbal', 'Setúbal', '2025-03-18', TRUE),
('Filipe Gomes', 'filipe.gomes@email.pt', 'Portimão', 'Faro', '2025-04-02', TRUE),
('Gabriela Santos', 'gabriela.santos@email.pt', 'Coimbra', 'Coimbra', '2025-04-14', TRUE),
('Hugo Almeida', 'hugo.almeida@email.pt', 'Braga', 'Braga', '2025-05-09', TRUE),
('Inês Ferreira', 'ines.ferreira@email.pt', 'Porto', 'Porto', '2025-05-20', TRUE),
('João Pereira', 'joao.pereira@email.pt', 'Faro', 'Faro', '2025-06-03', TRUE),
('Leonor Lopes', 'leonor.lopes@email.pt', 'Portimão', 'Faro', '2025-06-17', FALSE),
('Miguel Santos', 'miguel.santos@email.pt', 'Évora', 'Évora', '2025-07-01', TRUE),
('Nuno Martins', 'nuno.martins@email.pt', 'Lisboa', 'Lisboa', '2025-07-19', TRUE),
('Olívia Costa', 'olivia.costa@email.pt', 'Albufeira', 'Faro', '2025-08-11', TRUE),
('Pedro Rocha', 'pedro.rocha@email.pt', 'Porto', 'Porto', '2025-09-02', TRUE);

INSERT INTO produtos (nome, id_categoria, preco, stock, fornecedor) VALUES
('Portátil Lenovo IdeaPad', 1, 749.90, 12, 'Lenovo'),
('Portátil HP 15', 1, 699.00, 8, 'HP'),
('Desktop ASUS Expert', 1, 899.00, 5, 'ASUS'),
('Processador Intel Core i5', 2, 229.90, 15, 'Intel'),
('Processador AMD Ryzen 5', 2, 219.90, 10, 'AMD'),
('Memória RAM 16GB', 2, 64.90, 30, 'Kingston'),
('Placa Gráfica RTX 4060', 2, 349.90, 7, 'MSI'),
('Teclado Mecânico', 3, 79.90, 20, 'Logitech'),
('Rato Óptico', 3, 24.90, 40, 'Logitech'),
('Monitor 24 polegadas', 3, 159.90, 18, 'Samsung'),
('Webcam Full HD', 3, 49.90, 25, 'Logitech'),
('Router Wi-Fi 6', 4, 89.90, 14, 'TP-Link'),
('Switch 8 portas', 4, 54.90, 11, 'TP-Link'),
('SSD 500GB', 5, 59.90, 25, 'Kingston'),
('SSD 1TB', 5, 94.90, 16, 'Samsung'),
('Disco Externo 2TB', 5, 79.90, 13, 'Western Digital'),
('Windows 11 Pro', 6, 189.00, 20, 'Microsoft'),
('Microsoft 365', 6, 99.00, 35, 'Microsoft'),
('Impressora Multifunções', 7, 129.90, 6, 'Canon'),
('Tinteiro Preto', 7, 24.90, 50, 'Canon');

INSERT INTO encomendas (id_cliente, data_encomenda, estado, desconto) VALUES
(1, '2025-09-03', 'Concluída', 0),
(2, '2025-09-05', 'Concluída', 5),
(3, '2025-09-08', 'Enviada', 0),
(4, '2025-09-10', 'Pendente', 10),
(1, '2025-09-15', 'Concluída', 0),
(5, '2025-09-18', 'Cancelada', 0),
(6, '2025-09-20', 'Concluída', 5),
(7, '2025-09-22', 'Enviada', 0),
(8, '2025-09-25', 'Pendente', 0),
(9, '2025-09-28', 'Concluída', 10),
(10, '2025-10-01', 'Concluída', 0),
(11, '2025-10-03', 'Cancelada', 0),
(12, '2025-10-05', 'Enviada', 5),
(13, '2025-10-08', 'Concluída', 0),
(14, '2025-10-10', 'Pendente', 0),
(15, '2025-10-12', 'Concluída', 5),
(2, '2025-10-15', 'Concluída', 0),
(3, '2025-10-18', 'Enviada', 0),
(6, '2025-10-20', 'Pendente', 10),
(8, '2025-10-22', 'Concluída', 0);

INSERT INTO linhas_encomenda (id_encomenda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 749.90),
(1, 8, 1, 79.90),
(1, 9, 1, 24.90),

(2, 4, 1, 229.90),
(2, 6, 2, 64.90),

(3, 10, 2, 159.90),
(3, 11, 1, 49.90),

(4, 3, 1, 899.00),
(4, 14, 1, 59.90),

(5, 15, 1, 94.90),
(5, 12, 1, 89.90),
(5, 13, 1, 54.90),

(6, 19, 1, 129.90),
(6, 20, 2, 24.90),

(7, 2, 1, 699.00),
(7, 9, 1, 24.90),

(8, 5, 1, 219.90),
(8, 6, 2, 64.90),
(8, 14, 1, 59.90),

(9, 17, 1, 189.00),

(10, 1, 1, 749.90),
(10, 10, 1, 159.90),

(11, 18, 2, 99.00),
(11, 8, 1, 79.90),

(12, 16, 1, 79.90),
(12, 12, 1, 89.90),

(13, 7, 1, 349.90),
(13, 6, 2, 64.90),

(14, 10, 1, 159.90),
(14, 11, 1, 49.90),

(15, 1, 1, 749.90),
(15, 15, 1, 94.90),

(16, 19, 1, 129.90),
(16, 20, 3, 24.90),

(17, 2, 1, 699.00),
(17, 8, 1, 79.90),
(17, 9, 1, 24.90),

(18, 14, 2, 59.90),
(18, 15, 1, 94.90),

(19, 3, 1, 899.00),

(20, 10, 2, 159.90),
(20, 12, 1, 89.90),
(20, 13, 1, 54.90);

-- ============================================================
-- ÍNDICES ÚTEIS PARA CONSULTAS
-- ============================================================

CREATE INDEX idx_clientes_cidade ON clientes(cidade);
CREATE INDEX idx_clientes_distrito ON clientes(distrito);
CREATE INDEX idx_produtos_categoria ON produtos(id_categoria);
CREATE INDEX idx_produtos_preco ON produtos(preco);
CREATE INDEX idx_encomendas_cliente ON encomendas(id_cliente);
CREATE INDEX idx_encomendas_data ON encomendas(data_encomenda);
CREATE INDEX idx_encomendas_estado ON encomendas(estado);
CREATE INDEX idx_linhas_encomenda ON linhas_encomenda(id_encomenda);
CREATE INDEX idx_linhas_produto ON linhas_encomenda(id_produto);

-- ============================================================
-- NOTA PARA O PROFESSOR
-- ============================================================
-- A base foi construída para permitir exercícios sobre:
-- WHERE, operadores relacionais e lógicos, BETWEEN, IN, IS NULL,
-- LIKE, ORDER BY, DISTINCT, várias restrições, JOIN, INNER JOIN,
-- LEFT/RIGHT JOIN, UNION, COUNT, MAX, MIN, SUM, AVG,
-- GROUP BY, HAVING e subqueries correlacionadas/não correlacionadas.
--
-- Existem também clientes sem encomendas, estados diferentes de
-- encomendas e categorias/produtos variados, permitindo explorar
-- LEFT JOIN e consultas que devolvem conjuntos diferentes.
