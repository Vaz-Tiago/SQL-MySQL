-- FUNÇOES DE CONVERSÃO
-- Converte um tipo de dados em outro, são elas CAST e CONVERT


-- CONVERT
-- CONVERTENDO ENCODING
SET @palavra = BINARY 'São Paulo';
SELECT	LOWER(@palavra) Retorno1,
		LOWER(CONVERT(@palavra USING latin1)) Retorno2;
        
SET @palavra = BINARY 'São Paulo';
SELECT 	LOWER(@palavra)Retorno1,
		LOWER(CONVERT(@palavra USING utf8))UTF8,
		CONVERT(@palavra USING utf8)ConvertPURO,
		LOWER(CONVERT(@palavra USING ascii))ASCII;


-- CONVERTENDO DATAS COM CAST
SELECT NOW();
SELECT CAST(NOW() AS DATE);
SELECT CAST(NOW() AS TIME);
SELECT CAST(NOW() AS CHAR);
SELECT CAST(NOW() AS CHAR(7));


-- CONVERTENDO DATAS COM CONVERT
SELECT NOW();
SELECT CONVERT(NOW(), DATE);
SELECT CONVERT(NOW(), TIME);
SELECT CONVERT(NOW(), CHAR);
SELECT CONVERT(NOW(), CHAR(7));


-- CONVERTENDO INT em DECIMAL
-- CAST e CONVERT
SELECT 	@expr1 := 1 VALOR,
		CAST(@expr1 AS DECIMAL(10,2)) CAST1,
        CONVERT(@expr1, DECIMAL(10,3)) CONVERT1,
        CAST(CONVERT(@expr1, DECIMAL(10,3)) AS SIGNED INTEGER) AS CONVERT2;
 
 
 -- SCRIPT CAST E CONVERT MAIS OPERAÇÃO
 SELECT (CAST(10 AS DECIMAL)) + 10 AS RESULTADO;
 
 -- A OPERAÇÃO HERDA O DECIMAL ATRIBUIDO
 SELECT CONVERT(10,DECIMAL(10,2)) + 10 AS RESULTADO;