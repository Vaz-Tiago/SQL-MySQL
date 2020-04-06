CREATE TABLE campeonato
(
	nometime	VARCHAR(30) NOT NULL,
    pontos		INT NOT NULL
);

INSERT INTO campeonato VALUES ('Palmeiras','53');
INSERT INTO campeonato VALUES ('Grêmio','43');
INSERT INTO campeonato VALUES ('Santos','41');
INSERT INTO campeonato VALUES ('Corinthians','40');
INSERT INTO campeonato VALUES ('Flamengo','38');
INSERT INTO campeonato VALUES ('Cruzeiro','37');
INSERT INTO campeonato VALUES ('Botafogo','37');
INSERT INTO campeonato VALUES ('Atlético-PR','34');
INSERT INTO campeonato VALUES ('Vasco','31');
INSERT INTO campeonato VALUES ('Atlético-MG','31');
INSERT INTO campeonato VALUES ('Fluminense','31');
INSERT INTO campeonato VALUES ('Sport','29');
INSERT INTO campeonato VALUES ('Avaí','29');
INSERT INTO campeonato VALUES ('Chapecoense','28');
INSERT INTO campeonato VALUES ('Ponte Preta','28');
INSERT INTO campeonato VALUES ('Bahia','27');
INSERT INTO campeonato VALUES ('São Paulo','27');
INSERT INTO campeonato VALUES ('Coritiba','27');
INSERT INTO campeonato VALUES ('Vitória','26');
INSERT INTO campeonato VALUES ('Atlético-GO','22');

-- Criando Classificação de Campeonato
-- CONTADOR VIA SQL


-- SET @ PARA DEFINIR UMA VARIAVEL
-- Setado o valor zero e cada vez que roda o select acrescenta 1
SET @posicao = 0;
SELECT @posicao := @posicao+1 AS posicao, nometime, pontos
FROM campeonato
ORDER BY pontos DESC;


-- rankear estados pelo numero de municipios
-- Interessante aqui é que o primeiro from traz o resultado do segundo from
SELECT
	@posicao := @posicao +1 AS posicao,
    prequery.estado,
    prequery.qtd_cidades
FROM
	(SELECT @POSICAO := 0 ) variavel,
    (SELECT estado, COUNT(cod_mun) qtd_cidades
	FROM senso
    WHERE ano = '2014'
	GROUP BY estado
	ORDER BY COUNT(cod_mun) DESC ) prequery;
    
    
-- Rankeamento geral e por estado
SET @prev 			:= null;
SET @pos_geral 		:= 0;
SET @pos_estado		:= 0;

SELECT
	@pos_geral := @pos_geral + 1 AS posicao_geral,
    IF (@prev <> estado, @pos_estado:= 1, @pos_estado := @pos_estado +1) AS posicao_estado,
    @prev := estado AS Estado,
    nome_mun,
    populacao
FROM senso
WHERE ano = '2014'
ORDER BY estado, populacao DESC;
