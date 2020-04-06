-- PROCEDURE PARA RETORNAR SELECT

DELIMITER //

CREATE PROCEDURE proc_qtd_val (p_cod_mat INT)
	BEGIN
		SELECT a.nome, a.custo, b.qtd, a.custo*b.qtd Total
			FROM material a
				INNER JOIN estoque b
					ON a.cod_mat = b.cod_mat
			WHERE a.cod_mat = p_cod_mat;
            SELECT 'Consulta realizada com sucesso' AS msg;
END //

DELIMITER ;

CALL proc_qtd_val(3)