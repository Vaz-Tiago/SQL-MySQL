-- PROCEDURE IN e OUT Simultaneamente

DELIMITER //

CREATE PROCEDURE
	proc_ajuste_custo_2
    (
		IN p_cod_mat INT,
        taxa DECIMAL (10,2),
        OUT antes DECIMAL(10,2)
    )
    BEGIN
		-- select com atribuição dos valores
        -- INTO atribui o retorno do select a variavel antes, criada na declaracao OUT
        SELECT custo INTO antes
			FROM material
        WHERE cod_mat = p_cod_mat;
		-- update
        UPDATE material 
			SET custo = custo + custo * taxa / 100
        WHERE cod_mat = p_cod_mat;
	END //
DELIMITER ;


-- chamando a procedure: 
-- (2,7, @antes)
-- 2 - É o cod_do item a ser atualizado
-- 7 - É o valor da taxa que será aumentado
-- @antes - É a variavel que vai ser atribuida dentro da procedure

CALL proc_ajuste_custo_2(2,7,@antes);
SELECT @antes;


-- aumentando a complexidade

DELIMITER //
CREATE PROCEDURE 
	proc_ajuste_custo_3
    (
		IN p_cod_mat INT,
        taxa DECIMAL (10,2),
        OUT antes DECIMAL (10,2),
        OUT depois DECIMAL (10,2)
    )
    
    BEGIN
		-- SELECT para atribuir valores
        -- A cconta é feita duas vezes
        SELECT custo, custo+((custo*taxa)/100) AS pos INTO antes, depois
			FROM material
		WHERE cod_mat = p_cod_mat;
        
        UPDATE material 
			SET custo = custo + custo * taxa / 100
		WHERE cod_mat = p_cod_mat;
	END //
DELIMITER ;

CALL proc_ajuste_custo_3(2,7,@antes,@depois);
SELECT @antes antes, @depois depois;