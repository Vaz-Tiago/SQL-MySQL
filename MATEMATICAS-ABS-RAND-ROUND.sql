-- FUNÇÕES MATEMÁTICAS

-- ABS
-- Uma função matemática que retorna o valor absoluto (Positivo)
-- da expressão numérica especificada
-- O valor sempre será positivo.
SELECT	ABS(-1.0),
		ABS(0.0),
        ABS(1.0),
        ABS(-9.0),
        ABS(-5.4),
        ABS(5.4)
        
        
-- RAND
-- Retorna um valor float pseudoaleatório de 0 a 1, exclusivo.
SELECT RAND()
UNION
SELECT RAND()
UNION
SELECT RAND()
UNION
SELECT RAND()


-- ROUND
-- Retorna o valor numérico, arredondado, para o comprimento ou precisãp especificados.
-- Antes da vírgula o número e depois da virgula a quantidade de casa decimais exibidas
SELECT	ROUND(123.9994,3), -- 0,1,2,3,4 < Arredonda para baixo
		ROUND(123.9995,3); -- 5,6,7,8,9 > Arredonda para cima
        
-- Outro exemplo
-- Quando solicitado a remoção de duas casas, ele ignora a virgula e arredonda o número em si,
-- ou seja, 123 para 100 e 193 para 200. nao utliza o 150 como parametro
SELECT ROUND(123.4545, 2) RETORNO
UNION ALL
SELECT ROUND(123.45, -2)
UNION ALL
SELECT ROUND(193.45, -2)
UNION ALL
SELECT ROUND(249.45, -2)
UNION ALL
SELECT ROUND(251.45, -2);

-- Outro exemplo
-- Ele arredonda apenas o que está depois da virgula e exibe apenas um numero depois da vigula
SELECT ROUND(150.75,0)
UNION ALL
SELECT ROUND(150.75,1);


-- TRUNCATE
-- Quando positivo ele ignora o terceiro numero depois da virgula.
SELECT TRUNCATE(1.223, 2) RESULTADO;

-- Quando negativo depois da virgula, no caso o -2, ele olha o segundo numero e arredonda para o mais
-- próximo, no caso do 2 é zero, então o 122 é arredondado para 100
SELECT TRUNCATE(122, -2) RESULTADO;

-- Também pode ser utilizado em expressões.
SELECT TRUNCATE(10.28*100,0) RESULTADO;

SELECT TRUNCATE(10.28*100,3) RESULTADO;


-- FUNÇÃO SQRT QUADRATICA
SELECT SQRT(4) RESULTADO;

SELECT SQRT(20) RESULTADO;

SELECT SQRT(-16) RESULTADO;


-- SIGN - RETORNA -1 PARA NUMEROS NEGATIVOS, 0 PARA NEUTROS E 1 PARA NUMEROS POSITIVOS
SELECT SIGN(-235) RESULTADO;

SELECT SIGN(0) RESULTADO;

SELECT SIGN(235) RESULTADO;


-- POW - CALCULA A POTENCIA
-- ANTES DA VIRGULA O NUMERO DEPOIS DA VIRGULA A POTENCIA
SELECT POW(2,2) RESULTADO;

SELECT POW(3,2) RESULTADO;

SELECT POW(2,-2) RESULTADO;


-- MOD - TRAZ A DIFERENÇA DO RESULTADO DA DIVISÃO
-- ANTES DA VIRGULA O NUMERO E DEPOIS PELO QUAL SERA DIVIDIDO;
SELECT MOD(5,2) RESULTADO;

SELECT MOD(27,3) RESULTADO;

SELECT MOD (20,3) RESULTADO;