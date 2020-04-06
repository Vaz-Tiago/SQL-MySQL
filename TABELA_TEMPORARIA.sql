-- TEMP TABLE - TABELA TEMPORARIA

-- TEMPORARY - INDICA QUE A TABELA É TEMPORARIA, OU SEJA, 
-- ELA EXPIRA ASSIM QUE A SUA SESSÃO NO MYSQL TERMINAR

-- MUITO UTIL PARA FAZER TESTES NO BD

-- ALGUMAS OPERAÇÕES REQUEREM QUE A EXISTENCIA DE ALGUMAS INFORMAÇÕES SEJA
-- CURTA E QUE ELAS SEJAM REMOVIDAS QUANDO NÃO FOREM MAIS NECESSÁRIAS

-- A PARTE DA REMOÇÃO PODE SER FEITA AUTOMATICAMENTE PELO MYSQL.

-- importante alem de definir como temporary é setar o engine = memory
CREATE TEMPORARY TABLE tmp_senso1
	(
		id INT PRIMARY KEY AUTO_INCREMENT,
        cod_mun char(7),
        nome_mun VARCHAR(80)
	)
ENGINE = MEMORY;

-- inserindo dados de uma tabela existente na nova tabela
INSERT INTO tmp_senso1 (cod_mun, nome_mun)
SELECT cod_mun, nome_mun FROM senso;

-- selecionando dados da tabela temporaria
SELECT * FROM tmp_senso1;


-- CRIANDO TEMP ATRAVES DE SELECT
CREATE TEMPORARY TABLE tmp_senso2
SELECT * FROM senso;


SELECT * FROM tmp_senso2;


-- EXPLAIN - RETONA A ESTRUTURA DA TABELA
EXPLAIN tmp_senso1;
EXPLAIN tmp_senso2;
EXPLAIN senso;


-- DELETANDO A TABELA
DROP TEMPORARY TABLE tmp_senso1;




