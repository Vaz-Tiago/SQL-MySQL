

-- JOINS - 	O DOMINIO DESTA FUNÇÃO É O QUE DIFERENCIA UM BOM DE UM ÓTIMO PROFISSIONAL
-- 			QUALQUER EQUIVOCO NA APLICAÇÃO DE UM JOIN DISTORCE TODA A EXIBICAO DE INFOS

-- CRIAÇÃO DE TABELA ALUNOS
CREATE TABLE alunos
(
	id_aluno	INT NOT NULL AUTO_INCREMENT,
    nome		VARCHAR (20) NOT NULL,
    PRIMARY KEY (id_aluno)
);

-- CRIAÇÃO DE TABELA DISCIPLINA
CREATE TABLE disciplina
(
	id_disciplina 	INT NOT NULL AUTO_INCREMENT,
    nome_disc		VARCHAR(20),
    PRIMARY KEY(id_disciplina)
);

-- CRIAÇÃO DA TABELA MATRICULA

-- OBSERVAÇÃO IMPORTANTE DESTA TABELA SÃO AS DUAS PRIMARY KEY.
-- ISSO SIGNIFICA QUE A INFORMAÇÕ NÃO PODE SE REPETIR, OU SEJA, O MESMO ALUNO NÃO PODE ESTAR
-- MATRICULADO EM DUAS DISCIPLINAS DIFERENTES
-- ISSO SE CHAMA CHAVE PRIMARIA COMPOSTA
CREATE TABLE matricula
(
	id_aluno 		INT NOT NULL,
    id_disciplina 	INT NOT NULL,
    periodo 		VARCHAR(10),
    PRIMARY KEY(id_aluno, id_disciplina),
    FOREIGN KEY(id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina)
);


-- INSERINDO REGISTROS DE ALUNOS
INSERT INTO alunos(nome) VALUES ('Joao'), ('Maria'), ('Pedro'), ('Tiago'), ('Henrique');


-- EVIDENCIANDO O INSERT ALUNOS
SELECT * FROM alunos


-- INSERINDO DISCIPLINAS
INSERT INTO disciplina (nome_disc) VALUES
('Fisica'), ('Quimica'), ('Matematica'), ('Banco de Dados'), ('Programacao');


-- EVIDENCIANDO INSERT DISCIPLINA
SELECT * FROM disciplina


-- INSERINDO MATRICULAS DE ALUNO
INSERT INTO matricula VALUES ('1','1','Noturno');
INSERT INTO matricula VALUES ('1','2','Vespertino');
INSERT INTO matricula VALUES ('1','3','Matutino');

INSERT INTO matricula VALUES ('2','3','Noturno');
INSERT INTO matricula VALUES ('2','4','Noturno');

INSERT INTO matricula VALUES ('3','1','Noturno');
INSERT INTO matricula VALUES ('3','3','Noturno');
INSERT INTO matricula VALUES ('3','4','Noturno');

INSERT INTO matricula VALUES ('5','1','Matutino');
INSERT INTO matricula VALUES ('5','2','Vespertino');
INSERT INTO matricula VALUES ('5','4','Noturno');


SELECT * FROM matricula


-- ALUNO CODIGO 4 NAO TEM MATRICULA
-- DISCIPLINA CODIGO 5 NAO TEM ALUNOS

-- INNER JOIN
-- Sempre que utilizado o inner join, deve-se relacionar os campos da tabela que sao iguais
-- Isso é necessário na hora de criar selects mais rápidos e com dados concisos
SELECT a.nome, c.nome_disc, b.periodo
	FROM alunos a
		INNER JOIN matricula b
			ON a.id_aluno = b.id_aluno
		INNER JOIN disciplina c
			ON b.id_disciplina = c.id_disciplina
	ORDER BY a.nome
    

-- LEFT JOIN
-- O MESMO EXEMPLO ACIMA, FORÇANDO A PARECER TODOS OS DADOS DA TABELA A ESQUERDA,
-- OU SEJA, MESMO QUE NÃO SEJA UMA INFO COMUM, OS DADOS DA TABELA ALUNO SERÃO EXIBIDOS, ENQUANTO
-- OS DADOS DAS TABELAS A DIREITA, APENAS EXIBIRA OS COMUNS ENTRE ELAS
SELECT a.nome, c.nome_disc, b.periodo
	FROM alunos a
		LEFT JOIN matricula b
			ON a.id_aluno = b.id_aluno
		LEFT JOIN disciplina c
			ON b.id_disciplina = c.id_disciplina
	ORDER BY a.nome
    

-- RIGHT JOIN
-- MESMO EXEPLO, POREM AGORA APARECE TODOS OS DADOS DO QUE ESTÁ A DIREITA. OU SEJUA, DISCIPLINA
-- alunos está a direita pois foi o primeiro a ser citado e disciplina a direita pois foi o ultimo
SELECT a.nome, c.nome_disc, b.periodo
	FROM alunos a
		RIGHT JOIN matricula b
			ON a.id_aluno = b.id_aluno
		RIGHT JOIN disciplina c
			ON b.id_disciplina = c.id_disciplina
            
-- QUANTO MAIS TABELAS NA BUSCA MAIS LENTO, OBVIAMENTE.
-- INNER JOIN POR APRESENTAR APENAS OS DADOS RELACIONADOS, TEM MELHOR DESEMPENHO DE EXIBIÇÃO


	ORDER BY c.nome_disc