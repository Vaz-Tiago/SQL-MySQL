-- Caracteres

-- ASCII Exemplo:

SELECT ASCII('SQL')	AS RETORNO;
SELECT ASCII('S')	AS RETORNO;
SELECT ASCII('Q')	AS RETORNO;
SELECT ASCII('L')	AS RETORNO;


-- LTRIM
-- RETORNA UMA EXPRESSÃO DE CARACTERES DEPOIS DE REMOVER OS ESPAÇOES EM BRANCO A ESQUERDA
SET @FRASE_PARA_LTRIM:= '     CINCO ESPAÇOS NO INICIO.';
SELECT CONCAT('TEXTO SEM ESPAÇO:',LTRIM(@FRASE_PARA_LTRIM)) AS RETORNO
UNION ALL
SELECT CONCAT('TEXTO COM ESPAÇO:',@FRASE_PARA_LTRIM);


-- RTRIM
-- RETORNA UMA EXPRESSÃO REMOVENDO OS ESPAÇOS À DIREITA
SET @FRASE_RTRIM:= 'CINCO ESPAÇOS NO FINAL.     ';
SELECT CONCAT(RTRIM(@FRASE_RTRIM),'SEM ESPAÇO NO FINAL') AS RETORNO
UNION ALL
SELECT CONCAT(@FRASE_RTRIM,'TEXTO COM ESPAÇO NO FINAL');


-- TRIM
-- RETORNA A EXPRESSÃO REMOVENDO OS ESPAÇOS EM AMBOS OS LADOS
SET @FRASE_TRIM:= '     CINCO ESPAÇOS ANTES E DEPOIS.     ';
SELECT CONCAT('COM TRIM.',TRIM(@FRASE_TRIM),'.COM TRIM') AS RETORNO
UNION ALL
SELECT CONCAT('SEM O TRIM.', @FRASE_TRIM, '.SEM O TRIM');


-- STRCMP
-- COMPARA O COMPRIMENTO DAS STRINGS.
-- RETORNA 0 PARA IGUAL, -1 SE O PRIMEIRO ARGUMENTO É MENOR QUE O SEGUNDO E 1 SE FOR MAIOR
-- MAS NÃO É O COMPRIMENTO MAS PELO CÓDIGO ASCII
SELECT STRCMP('SQL','SQL2')RETORNO;
SELECT STRCMP('MYSQL','MY')RETORNO;
SELECT STRCMP('SQL','SQL')RETORNO;


-- CONCAT
-- CONCATENA VALORES - SEPARADOS POR UMA VIRGULA -
-- RETORNA UMA CADEIA DE CARACTERES QUE É O RESULTADO DA CONCATENAÇÃO DE DOIS OU MAIS VALORES
SELECT CONCAT('MY','S','Q','L')RETORNO;

-- OUTRO EXEMPLO
-- PEGANDO A DATA ANUAL SEPARADAMENTE POR FUNÇÃO SQL
SELECT CONCAT('Olá ',current_user(), 'Seu saldo é R$', 11.00, ' em ',
				DAY(NOW()),'/',
                MONTH(NOW()),'/',
                YEAR(NOW())) AS Resultado;


-- CONCAT_WS
-- DEFINE UM SEPARADOR SEMPRE QUE HOUVER UMA CONCATENAÇÃO.
SELECT CONCAT('BEM-VINDO! ', CONCAT_WS(',', 'ROSA','ANDRE'))RETORNO;


-- REPLACE
-- Substitui todas as ocorrências de um valor da cadeia de caracteres específicado
-- por outro valor de cadeia de caracteres. Case sensitive  ativado

-- REPLACE funciona da seguinte maneira:
-- REPLACE(variavel ou string, 'caracteres que serão substituidos', 'caracteres que substituirão')
-- No exemplo abaixo, BALA vira MOLA
SET @PALAVRA:='BALA';
SELECT @PALAVRA DE,
	REPLACE (@PALAVRA, 'BA','MO') PARA;

-- O exemplo acima utilizou uma variavel, no de baixo vai usar uma cadei de caracteres:
SELECT 'Isto é teste' de,
	REPLACE ('Isto é teste', 'teste','producao') para;

-- REPLACE no SELECT
USE world;
SELECT Name, Continent,
	REPLACE (Continent, 'South America', 'America do Sul') Trocado
FROM country

-- Exemplo de UPDATE utilizando REPLACE

USE curso;

-- Criar tabela para exemplo
CREATE TABLE pessoas
(
	nome VARCHAR (30)
);

-- Inserir nomes com acento
INSERT INTO pessoas VALUES ('José');
INSERT INTO pessoas VALUES ('André');
INSERT INTO pessoas VALUES ('Helem');

-- Atualizar a tabela para que a acentuação de todos os nomes seja retirada:
UPDATE pessoas SET nome = REPLACE(nome, 'é','e');


-- LPAD
-- Repete um valor da cadeia de caracteres um numero especificado de vezes A ESQUERDA
-- por exemplo, em uma sequencia de 6 caracteres, voce precisa que esta cadeia possua 10 caracteres,
-- ele preenche com o caracteres desejado à esquerda até que tenha tamanho 10
SELECT LPAD('123456',10,'0') AS RETORNO;

-- Criando tabela para exemplo
CREATE TABLE tst
(
	c1 VARCHAR	(3),
    c2 CHAR		(3)
);

INSERT INTO tst VALUES ('2','2');
INSERT INTO tst VALUES ('37','37');
INSERT INTO tst VALUES ('597','597');

SELECT c1, c2,
	LPAD(c1,5,'0')LPAD_C1,
    LPAD(c2,10,'0')LPAD_C2
FROM tst;


-- RPAD
-- Funciona da mesma forma que o LPAD, porém preenche a direita
SELECT c1, c2,
	RPAD(c1,5,'0')RPAD_C1,
    RPAD(c2,10,'0')RPAD_C2
FROM tst;


-- LEFT
-- Exibe apenas a quantidade de caracteres desejada iniciando à esquerda
USE sakila;
SELECT FIRST_NAME,
	LEFT(FIRST_NAME,5) RETORNO
FROM actor;


-- RIGHT
-- Igual o left, porem inica à direita
SELECT FIRST_NAME,
	RIGHT(FIRST_NAME,5) RETORNO
FROM actor;


-- UPPER
-- Altera tudo para letras maiusculas
USE world;
SELECT name,
	UPPER(name) Retorno
FROM country;


-- LOWER
-- MESMA COISA QUE O UPPER, POREM COM LETRAS MINUSCULAS
SELECT name,
	LOWER(name) Retorno
FROM country;


-- REVERSE
-- Inverte a string, deixa as palavras ao contrario. Tiago fica ogaiT
SELECT name,
	REVERSE(name) Retorno
FROM country;


-- CHAR_LENGTH
-- Conta a quantidade de caracteres da string
USE curso;
SELECT	c1,
		c2,
        CHAR_LENGTH(c1) LEN_c1,
        CHAR_LENGTH(c2) LEN_c2
FROM tst;


-- LENGTH
-- Funciona igual o CHAR_LENGTH - AMBAS TEM O MESMO RETORNO
SELECT	c1,
		c2,
        LENGTH(c1) LEN_c1,
        LENGTH(c2) LEN_c2
FROM tst;


-- BIT_LENGTH
-- Retrona a quatida de bit
SELECT	c1,
		c2,
        BIT_LENGTH(c1) LEN_c1,
        BIT_LENGTH(c2) LEN_c2
FROM tst;


-- FIELD
-- Retorna o inteiro da posicao
-- O primeiro '' depois do (), representa a busca, e depois vem a array que ele vai buscar e retornar
SELECT FIELD('QUA', 'SEG', 'TER', 'QUA', 'QUI', 'SEX') RETORNO;


-- FIND_IN_SET
-- Mesma função do FIELD, mas pesquisa de maneira diferente, em apenas uma ''
SELECT FIND_IN_SET('b', 'a,b,c,d,e') retorno;


-- MAKE_SET
-- Contrario do FIELD, pois aqui você coloca a posição e ele retorna o conteudo desta posição
SELECT MAKE_SET(2, 'a','b','c')retorno;

-- mais de um retorno
SELECT MAKE_SET(1 | 4 , 'ola','oi','mundo') retorno;


-- SUBSTRING
-- Neste exempo selecionaremos a quantidade de caracteres que uma substring vai trazer
-- (Campo, qual caractere inicia, quantidade de caracteres apresentado)
USE world;
SELECT	name,
		SUBSTRING(name,1,3) AS nome1,
		SUBSTRING(name,4,3) AS nome2,
		SUBSTRING(name,7,5) AS nome3
FROM country;        