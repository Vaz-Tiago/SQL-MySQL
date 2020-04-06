-- CRIPTOGRAFANDO - FUNÇÕES MD5, SHA, SHA1 E SHA2

-- FUNÇÃO MD5
SELECT MD5('123456789123456789123456789123456789dfgsdfgsdfghjhtrss');

-- CRIAR TABELA PARA TESTE
-- Importante lembrar que no campo senha, o tamanho deve ser de 32 bitts, pois esperamos esse resultado
-- da criptografia não importa o tamaho da senha, o resulçtado será sempre uma chave de 32 bits
CREATE TABLE usuario
	(
		id_usuario 	INT NOT NULL AUTO_INCREMENT,
        nome		VARCHAR(20),
        senha		VARCHAR(32),
        PRIMARY KEY (id_usuario)
	);
-- iNSERINDO VALOR CRIPTOGRAFADO
INSERT INTO usuario (nome,senha) VALUES ('André', MD5('123456'));

SELECT * FROM usuario;

-- ATUALIZANDO SENHA
UPDATE usuario SET senha = MD5('654321abdc')
WHERE id_usuario = '1';


-- MESMA CRIPTOGRAFIA SHA E SHA1
SELECT	SHA('123456') AS SHA,
		SHA1('123456') AS SHA1;
        

-- SHA2 HASHS - (SHA-224, SHA-256, SHA-384 E SHA-512)
-- Podemos aumentar a segurança definindo o tipo de criptografia, definindo o valor antes da virgula
-- e a criptografia que será utilizada após a virgula.
SELECT	SHA2('ABC', 224) AS HASH224,
		SHA2('ABC', 256) AS HASH256,
        SHA2('ABC', 384) AS HASH384,
        SHA2('ABC', 512) AS HASH512;
        

-- EVIDENCIANDO A DIFERENÇA DE BITS DE SEGURANÇA
-- Importante se atentar ao espaço utlizado, sendo que cada resgistro em um nivel alto de segurança
-- chega a ocupar 1 kb só a senha, tornando um bd com muitos usuários gigante
SELECT	BIT_LENGTH(SHA2('ABC', 224)) AS HASH224,
		BIT_LENGTH(SHA2('ABC', 256)) AS HASH256,
        BIT_LENGTH(SHA2('ABC', 384)) AS HASH384,
        BIT_LENGTH(SHA2('ABC', 512)) AS HASH512;
        
        
-- EVIDENIANDO A QUANTIDADE DE CARACTERES DO CAMPO
-- Importante para quando for criada a tabela definir o VARCHAR de acordo com essa quantidade
SELECT	LENGTH(SHA2('ABC', 224)) AS HASH224,
		LENGTH(SHA2('ABC', 256)) AS HASH256,
        LENGTH(SHA2('ABC', 384)) AS HASH384,
        LENGTH(SHA2('ABC', 512)) AS HASH512;

