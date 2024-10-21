-- RESPUESTA NRO. 01
SELECT tm.nombre_menu
,COUNT(1) cantidad_Asistentes
FROM parranda.plato_Usuario pu
INNER JOIN parranda.Usuarios usr ON
	pu.id_usuario  = usr.id_usuario
JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu  = tm.id_tipo_menu 
WHERE pu.confirmado = 'S'
GROUP BY tm.nombre_menu
ORDER BY 2 DESC;



-- RESPUESTA NRO. 02
SELECT 
    td.nombre_dieta,
    COUNT(1) cantidad_Personas_Dieta,
    ROUND((COUNT(1) * 100.0 / (SELECT COUNT(1) 
                          FROM parranda.plato_Usuario pu2 
                          INNER JOIN parranda.Usuarios usr2 ON pu2.id_usuario = usr2.id_usuario 
                          WHERE pu2.confirmado = 'S')),2) || '%' pj
FROM 
    parranda.plato_Usuario pu
INNER JOIN 
    parranda.Usuarios usr ON pu.id_usuario = usr.id_usuario
INNER JOIN 
    parranda.tipo_Menu tm ON pu.id_tipo_menu = tm.id_tipo_menu
INNER JOIN 
    parranda.tipo_Dieta td ON tm.id_tipo_dieta = td.id_tipo_dieta 
WHERE 
    pu.confirmado = 'S'
GROUP BY 
    td.nombre_dieta
ORDER BY 
    pj DESC
LIMIT 5;



-- RESPUESTA NRO. 03
SELECT tm.nombre_genero_musical,
	COUNT(1) cant_Votos
FROM parranda.musica_Usuario mu 
INNER JOIN parranda.Usuarios u ON
	mu.id_usuario = u.id_usuario
JOIN parranda.tipo_Musica tm ON
	mu.id_tipo_musica = tm.id_tipo_musica
WHERE mu.id_usuario IN (SELECT pu.id_usuario
FROM parranda.plato_Usuario pu 
INNER JOIN 
    parranda.Usuarios usr ON pu.id_usuario = usr.id_usuario
WHERE pu.confirmado = 'S') AND tm.id_tipo_musica IN (
	SELECT tm2.id_tipo_musica
	FROM parranda.tipo_Musica tm2 
	WHERE tm2.id_tipo_musica = 9
)
GROUP BY tm.nombre_genero_musical
ORDER BY cant_votos DESC;



-- RESPUESTA NRO. 04
SELECT tm.nombre_genero_musical,
	COUNT(1) cant_Votos
FROM parranda.musica_Usuario mu 
INNER JOIN parranda.Usuarios u ON
	mu.id_usuario = u.id_usuario
JOIN parranda.tipo_Musica tm ON
	mu.id_tipo_musica = tm.id_tipo_musica
WHERE mu.id_usuario IN (SELECT pu.id_usuario
FROM parranda.plato_Usuario pu 
INNER JOIN 
    parranda.Usuarios usr ON pu.id_usuario = usr.id_usuario
WHERE pu.confirmado = 'S')
GROUP BY tm.nombre_genero_musical
ORDER BY cant_votos DESC;



-- RESPUESTA NRO. 05
SELECT 
tgp.nombre_genero_persona genero,
COUNT(1) cantidad
FROM parranda.Usuarios u
INNER JOIN parranda.plato_Usuario pu ON
	u.id_usuario = pu.id_usuario
JOIN parranda.tipo_Genero_Persona tgp ON
	u.id_genero_persona = tgp.id_genero_persona 
WHERE pu.id_usuario IN (SELECT pu.id_usuario
FROM parranda.plato_Usuario pu 
INNER JOIN 
    parranda.Usuarios usr ON pu.id_usuario = usr.id_usuario
WHERE pu.confirmado = 'S')
GROUP BY tgp.nombre_genero_persona
ORDER BY cantidad DESC;



-- RESPUESTA NRO. 06
SELECT 
tm3.nombre_menu,
COUNT(1) cant_Platos
FROM parranda.plato_Usuario pu3 
INNER JOIN parranda.Usuarios u3 ON
	pu3.id_usuario = u3.id_usuario
INNER JOIN parranda.tipo_Menu tm3 ON
	pu3.id_tipo_menu = tm3.id_tipo_menu
JOIN parranda.tipo_Dieta td3 ON
	tm3.id_tipo_dieta = td3.id_tipo_dieta 
WHERE pu3.id_tipo_menu IN (
	SELECT tm.id_tipo_menu
		FROM parranda.tipo_Menu tm 
		WHERE tm.id_tipo_dieta = 1) AND pu3.id_usuario IN (
	SELECT pu3.id_usuario
		FROM parranda.plato_Usuario pu3 
		INNER JOIN 
		    parranda.Usuarios usr3 ON pu3.id_usuario = usr3.id_usuario
		WHERE pu3.confirmado = 'S')
GROUP BY tm3.nombre_menu
ORDER BY cant_Platos DESC;



-- RESPUESTA NRO. 07
SELECT 
tm3.nombre_menu,
COUNT(1) cant_Platos
FROM parranda.plato_Usuario pu3 
INNER JOIN parranda.Usuarios u3 ON
	pu3.id_usuario = u3.id_usuario
INNER JOIN parranda.tipo_Menu tm3 ON
	pu3.id_tipo_menu = tm3.id_tipo_menu
JOIN parranda.tipo_Dieta td3 ON
	tm3.id_tipo_dieta = td3.id_tipo_dieta 
WHERE pu3.id_tipo_menu IN (
	SELECT tm.id_tipo_menu
		FROM parranda.tipo_Menu tm 
		WHERE tm.id_tipo_dieta = 4) AND pu3.id_usuario IN (
	SELECT pu3.id_usuario
		FROM parranda.plato_Usuario pu3 
		INNER JOIN 
		    parranda.Usuarios usr3 ON pu3.id_usuario = usr3.id_usuario
		WHERE pu3.confirmado = 'S')
GROUP BY tm3.nombre_menu
ORDER BY cant_Platos DESC;



-- RESPUESTA NRO. 08
SELECT pu.confirmado confirmados,
COUNT(1) cant_Confirmados
FROM parranda.plato_Usuario pu
WHERE pu.confirmado IN ('S', 'N')
GROUP BY confirmados;




-- RESPUESTA NRO. 09 / PARTE 1
-- Género musical que prefieren - LOS HOMBRES
SELECT tm.nombre_genero_musical genero_Musical
,COUNT(1) cant_Personas
FROM parranda.Usuarios u 
INNER JOIN parranda.musica_Usuario mu ON
	u.id_usuario = mu.id_usuario 
JOIN parranda.tipo_Musica tm ON
	mu.id_tipo_musica = tm.id_tipo_musica
JOIN parranda.tipo_Genero_Persona tgp ON
	u.id_genero_persona = tgp.id_genero_persona 
WHERE u.id_genero_persona IN (1)
GROUP BY genero_Musical
ORDER BY cant_Personas DESC

-- RESPUESTA NRO. 09 / PARTE 2
-- Género Musical que Prefieren - LAS MUJERES
SELECT tm.nombre_genero_musical genero_Musical,
COUNT(1) cant_Personas
FROM parranda.Usuarios u 
INNER JOIN parranda.musica_Usuario mu ON
	u.id_usuario = mu.id_usuario 
JOIN parranda.tipo_Musica tm ON
	mu.id_tipo_musica = tm.id_tipo_musica
JOIN parranda.tipo_Genero_Persona tgp ON
	u.id_genero_persona = tgp.id_genero_persona 
WHERE u.id_genero_persona IN (2)
GROUP BY genero_Musical
ORDER BY cant_Personas DESC



-- RESPUESTA NRO. 10
SELECT tm.nombre_menu nombre_Plato
,COUNT(1) cantidad_Platos
FROM parranda.plato_Usuario pu 
JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu = tm.id_tipo_menu 
WHERE pu.id_usuario IN (SELECT id_usuario
FROM parranda.musica_Usuario mu
WHERE mu.id_tipo_musica = 3) AND pu.confirmado = 'S'
GROUP BY nombre_Plato
ORDER BY cantidad_Platos DESC;



-- RESPUESTA NRO. 11
WITH personas_pescetarianas_musica AS (
	SELECT tm.id_tipo_musica id1
	,tm.nombre_genero_musical
	,COUNT(1) cant_Personas
	FROM parranda.musica_Usuario mu 
	INNER JOIN parranda.tipo_Musica tm ON
		mu.id_tipo_musica = tm.id_tipo_musica 
	WHERE mu.id_usuario IN (SELECT pu.id_usuario
	FROM parranda.plato_Usuario pu 
	WHERE pu.id_tipo_menu IN (SELECT tm2.id_tipo_menu
	FROM parranda.tipo_Dieta td 
	INNER JOIN parranda.tipo_Menu tm2 ON
		td.id_tipo_dieta = tm2.id_tipo_dieta
	WHERE tm2.id_tipo_dieta IN (1)
	ORDER BY tm2.id_tipo_menu))
	GROUP BY nombre_genero_musical, id1
	ORDER BY cant_Personas DESC
),
personas_carnivoras_musica AS (
	SELECT tm.id_tipo_musica id2
	,tm.nombre_genero_musical nombre_genero_musical2
	,COUNT(1) cant_Personas2
	FROM parranda.musica_Usuario mu 
	INNER JOIN parranda.tipo_Musica tm ON
		mu.id_tipo_musica = tm.id_tipo_musica 
	WHERE mu.id_usuario IN (SELECT pu.id_usuario
	FROM parranda.plato_Usuario pu 
	WHERE pu.id_tipo_menu IN (SELECT tm2.id_tipo_menu
	FROM parranda.tipo_Dieta td 
	INNER JOIN parranda.tipo_Menu tm2 ON
		td.id_tipo_dieta = tm2.id_tipo_dieta
	WHERE tm2.id_tipo_dieta IN (3)
	ORDER BY tm2.id_tipo_menu))
	GROUP BY nombre_genero_musical2, id2
	ORDER BY cant_Personas2 DESC
)
SELECT ppm.nombre_genero_musical nombre_Genero
,pcm.cant_Personas2 cantidad_Carnivoros
,ppm.cant_Personas cantidad_Pescetarianos
FROM personas_pescetarianas_musica ppm
JOIN personas_carnivoras_musica pcm ON
	ppm.id1 = pcm.id2
	
	
	
-- RESPUESTA NRO. 12
WITH cantidad_Asistentes_Tropical AS (
	SELECT tm.nombre_genero_musical nom_Gen_Mus
	,ROUND(COUNT(1)*100.0/(
		SELECT COUNT(1) valor_Total_Asistentes
		FROM parranda.plato_Usuario pu2
		INNER JOIN parranda.Usuarios usr2 ON 
			pu2.id_usuario = usr2.id_usuario
		WHERE pu2.confirmado <> 'N'),2) || '%'  valor_Total_Asistentes_Tropical
	FROM parranda.musica_Usuario mu 
	INNER JOIN parranda.tipo_Musica tm ON
		mu.id_tipo_musica = tm.id_tipo_musica
	WHERE mu.id_usuario IN (
		SELECT pu2.id_usuario
		FROM parranda.plato_Usuario pu2
		WHERE pu2.confirmado <> 'N'
	) AND tm.id_tipo_musica = (
		SELECT tm3.id_tipo_musica
		FROM parranda.tipo_Musica tm3
		WHERE tm3.id_tipo_musica = 6
	)
	GROUP BY nom_Gen_Mus
)
SELECT *
FROM cantidad_Asistentes_Tropical;



-- RESPUESTA NRO. 13
SELECT tm.nombre_menu nombre_Del_Menu,
	COUNT(1) cant_Personas
FROM parranda.plato_Usuario pu
INNER JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu = tm.id_tipo_menu 
WHERE pu.id_tipo_menu IN (
	SELECT tm2.id_tipo_menu
	FROM parranda.tipo_Menu tm2
	WHERE tm2.id_tipo_menu = 1
)
GROUP BY nombre_Del_Menu;



-- RESPUESTA NRO. 14 / PARTE 1
-- Cantidad de Personas por Género y Dieta
WITH personas_Por_Dieta AS (
	SELECT tgp.nombre_genero_persona genero_Persona
	,td.nombre_dieta nombre_Dieta_Por_Plato
	,tm.nombre_menu nombre_Plato_Elegido
	,COUNT(1) cantidad_Platos_Elegidos
	FROM parranda.plato_Usuario	pu
	INNER JOIN parranda.tipo_Menu tm ON
		pu.id_tipo_menu = tm.id_tipo_menu
	INNER JOIN parranda.Usuarios u ON
		pu.id_usuario = u.id_usuario 
	INNER JOIN parranda.tipo_Genero_Persona tgp ON
		u.id_genero_persona = tgp.id_genero_persona
	INNER JOIN parranda.tipo_Dieta td ON
		tm.id_tipo_dieta = td.id_tipo_dieta 
	WHERE pu.id_usuario IN (
		SELECT u2.id_usuario
		FROM parranda.plato_Usuario pu2
		INNER JOIN parranda.Usuarios u2 ON
			pu2.id_usuario = u2.id_usuario
		INNER JOIN parranda.tipo_Genero_Persona tgp2 ON
			tgp2.id_genero_persona = u2.id_genero_persona
		WHERE pu2.confirmado = 'S' AND u2.id_genero_persona IN (1,2,3)
	)
	GROUP BY nombre_Dieta_Por_Plato, nombre_Plato_Elegido, genero_Persona
	ORDER BY genero_Persona, nombre_Dieta_Por_Plato DESC, cantidad_Platos_Elegidos ASC
)
SELECT genero_Persona
,nombre_Dieta_Por_Plato
,SUM(cantidad_Platos_Elegidos) AS cantidad_Total
FROM personas_Por_Dieta
GROUP BY genero_Persona, nombre_Dieta_Por_Plato
ORDER BY genero_Persona, cantidad_Total DESC



-- RESPUESTA NRO. 14 / PARTE 2
-- Cantidad de Personas por Género y Plato (Tipo de Menú)
WITH personas_Por_Dieta AS (
	SELECT tgp.nombre_genero_persona genero_Persona
	,td.nombre_dieta nombre_Dieta_Por_Plato
	,tm.nombre_menu nombre_Plato_Elegido
	,COUNT(1) cantidad_Platos_Elegidos
	FROM parranda.plato_Usuario	pu
	INNER JOIN parranda.tipo_Menu tm ON
		pu.id_tipo_menu = tm.id_tipo_menu
	INNER JOIN parranda.Usuarios u ON
		pu.id_usuario = u.id_usuario 
	INNER JOIN parranda.tipo_Genero_Persona tgp ON
		u.id_genero_persona = tgp.id_genero_persona
	INNER JOIN parranda.tipo_Dieta td ON
		tm.id_tipo_dieta = td.id_tipo_dieta 
	WHERE pu.id_usuario IN (
		SELECT u2.id_usuario
		FROM parranda.plato_Usuario pu2
		INNER JOIN parranda.Usuarios u2 ON
			pu2.id_usuario = u2.id_usuario
		INNER JOIN parranda.tipo_Genero_Persona tgp2 ON
			tgp2.id_genero_persona = u2.id_genero_persona
		WHERE pu2.confirmado = 'S' AND u2.id_genero_persona IN (1,2,3)
	)
	GROUP BY nombre_Dieta_Por_Plato, nombre_Plato_Elegido, genero_Persona
	ORDER BY genero_Persona, nombre_Dieta_Por_Plato DESC, cantidad_Platos_Elegidos ASC
)
SELECT genero_Persona
,nombre_Plato_Elegido
,SUM(cantidad_Platos_Elegidos) AS cantidad_Total
FROM personas_Por_Dieta
GROUP BY genero_Persona, nombre_Plato_Elegido
ORDER BY genero_Persona, cantidad_Total DESC



-- RESPUESTA NRO. 15
WITH datos_Persona AS (
	SELECT mu.id_usuario
	,COUNT(mu.id_tipo_musica) AS cantidad_Generos_Elegidos
	FROM parranda.musica_Usuario mu 
	WHERE mu.id_usuario IN (
		SELECT id_usuario 
		FROM parranda.plato_Usuario pu 
		WHERE pu.confirmado = 'S'
	)
	GROUP BY mu.id_usuario
	ORDER BY cantidad_Generos_Elegidos DESC
	LIMIT 1
),
datos_Generos AS (
	SELECT mu.id_usuario
	,mu.id_tipo_musica idtpm2
	FROM parranda.musica_Usuario mu
	INNER JOIN datos_Persona dp ON
		mu.id_usuario = dp.id_usuario
	WHERE mu.id_usuario = dp.id_usuario
)
SELECT dp2.id_usuario
,(SELECT u.identificacion || ' ' || u.primer_nombre || ' ' || u.segundo_nombre || ' ' || u.primer_apellido || ' ' || u.segundo_apellido AS data_Persona
	FROM datos_Persona dp3
	INNER JOIN parranda.Usuarios u 	ON
		dp3.id_usuario = u.id_usuario) AS datos_Personales_Completos
,(SELECT dp4.cantidad_Generos_Elegidos
	FROM datos_Persona dp4
	) AS cantidad_Generos_Elegidos_Persona
,(SELECT list(tm.nombre_genero_musical) idtpm2
	FROM parranda.musica_Usuario mu
	INNER JOIN datos_Persona dp ON
		mu.id_usuario = dp.id_usuario
	INNER JOIN parranda.tipo_Musica tm ON
		mu.id_tipo_musica = tm.id_tipo_musica
	WHERE mu.id_usuario = dp.id_usuario) AS listado_Generos
FROM datos_Generos dg
INNER JOIN datos_Persona dp2 ON
	dg.id_usuario = dp2.id_usuario
GROUP BY dp2.id_usuario;



-- RESPUESTA NRO. 16
SELECT tgp.nombre_genero_persona genero_Asistente
,(SELECT u2.identificacion || ' ' || u2.primer_nombre || ' ' || u2.segundo_nombre || ' ' || u2.primer_apellido || ' ' || u2.segundo_apellido AS data_Persona
	FROM parranda.Usuarios u2
	WHERE u2.id_usuario = pu.id_usuario) AS informacion_Personal
,tm.nombre_menu nombre_Plato
,COUNT(tm.nombre_menu) AS cantidad_Platos
FROM parranda.plato_Usuario pu 
INNER JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu = tm.id_tipo_menu 
INNER JOIN parranda.Usuarios u ON
	pu.id_usuario = u.id_usuario 
INNER JOIN parranda.tipo_Genero_Persona tgp ON
	u.id_genero_persona = tgp.id_genero_persona 
WHERE pu.id_usuario IN (
	SELECT id_usuario 
	FROM parranda.plato_Usuario pu 
	WHERE pu.confirmado = 'S'
) AND tm.id_tipo_dieta IN (
	SELECT td.id_tipo_dieta
	FROM parranda.tipo_Dieta td
	WHERE td.id_tipo_dieta = 4
)
GROUP BY informacion_Personal, genero_Asistente, nombre_Plato
ORDER BY cantidad_Platos;



-- RESPUESTA NRO. 17
SELECT --mu.id_usuario 
--,mu.id_tipo_musica 
tgp.nombre_genero_persona genero_Persona
,(SELECT u2.identificacion || ' ' || u2.primer_nombre || ' ' || u2.segundo_nombre || ' ' || u2.primer_apellido || ' ' || u2.segundo_apellido AS data_Persona
	FROM parranda.Usuarios u2
	WHERE u2.id_usuario = mu.id_usuario) AS informacion_Personal
,tm.nombre_menu nombre_Comida
,COUNT(tm.nombre_menu) cantidad_Platos
FROM parranda.musica_Usuario mu 
INNER JOIN parranda.Usuarios u ON
	mu.id_usuario = u.id_usuario 
INNER JOIN parranda.plato_Usuario pu ON
	u.id_usuario = pu.id_usuario 
INNER JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu = tm.id_tipo_menu 
INNER JOIN parranda.tipo_Genero_Persona tgp ON
	u.id_genero_persona = tgp.id_genero_persona 
WHERE mu.id_tipo_musica IN (
	SELECT tm.id_tipo_musica
	FROM parranda.tipo_Musica tm
	WHERE tm.id_tipo_musica IN (4)
) AND mu.id_usuario IN (
	SELECT id_usuario 
	FROM parranda.plato_Usuario pu2 
	WHERE pu2.confirmado = 'S'
)
GROUP BY genero_Persona, informacion_Personal, nombre_Comida
ORDER BY genero_Persona DESC;



-- RESPUESTA NRO. 18
SELECT *
FROM parranda.plato_Usuario pu 
WHERE pu.confirmado = 'N' AND pu.id_tipo_menu NOT IN (
	SELECT tm.id_tipo_menu
	FROM parranda.tipo_Menu tm 
) OR pu.id_tipo_menu = NULL



-- RESPUESTA NRO. 19
WITH data_Generos AS (
	SELECT tm2.nombre_genero_musical nombre_Genero_Musical
	,tgp.nombre_genero_persona tipo_Genero
	,(SELECT u2.identificacion || ' ' || u2.primer_nombre || ' ' || u2.segundo_nombre || ' ' || u2.primer_apellido || ' ' || u2.segundo_apellido AS data_Persona
		FROM parranda.Usuarios u2
		WHERE u2.id_usuario = pu.id_usuario) AS informacion_Personal
	FROM parranda.plato_Usuario pu 
	INNER JOIN parranda.Usuarios u ON
		pu.id_usuario = u.id_usuario 
	INNER JOIN parranda.musica_Usuario mu ON
		u.id_usuario = mu.id_usuario 
	INNER JOIN parranda.tipo_Musica tm2 ON	
		mu.id_tipo_musica = tm2.id_tipo_musica 
	INNER JOIN parranda.tipo_Menu tm ON
		pu.id_tipo_menu = tm.id_tipo_menu
	INNER JOIN parranda.tipo_Genero_Persona tgp ON
		u.id_genero_persona = tgp.id_genero_persona
	WHERE pu.confirmado = 'S' AND pu.id_tipo_menu = 6
	GROUP BY nombre_Genero_Musical, tipo_Genero, informacion_Personal
	ORDER BY nombre_Genero_Musical
)
SELECT dg.tipo_Genero
,dg.informacion_Personal AS info_Personal
,COUNT(dg.nombre_Genero_Musical) AS cantidad_Generos_Musicales
,(SELECT list(dg2.nombre_Genero_Musical)
     FROM data_Generos dg2) AS lista_Categorias
FROM data_Generos dg
GROUP BY dg.informacion_Personal, dg.tipo_Genero, lista_Categorias



-- RESPUESTA NRO. 20 / PARTE 1
-- Data: Informacion Personal y Menús de quienes comieron algún Pescado o Marisco
SELECT pu.id_usuario
,td.nombre_dieta nombre_Dieta_Menu
,(SELECT u2.identificacion || ' ' || u2.primer_nombre || ' ' || u2.segundo_nombre || ' ' || u2.primer_apellido || ' ' || u2.segundo_apellido AS data_Persona
		FROM parranda.Usuarios u2
		WHERE u2.id_usuario = pu.id_usuario) AS informacion_Personal
,tm.nombre_menu 
,COUNT(tm.nombre_menu) AS cantidad_Personas
,pu.confirmado 
FROM parranda.plato_Usuario pu 
INNER JOIN parranda.tipo_Menu tm ON
	pu.id_tipo_menu = tm.id_tipo_menu 
INNER JOIN parranda.tipo_Dieta td ON
	tm.id_tipo_dieta = td.id_tipo_dieta 
WHERE td.id_tipo_dieta IN (1) AND pu.confirmado = 'S'
GROUP BY pu.id_usuario, nombre_Dieta_Menu, informacion_Personal, tm.nombre_menu, pu.confirmado 
ORDER BY cantidad_Personas

-- RESPUESTA NRO. 20 / PARTE 2
--Cantidad de Personas y Platos de quienes comieron Pescados o Mariscos
WITH data_Info_Menus AS (
	SELECT pu.id_usuario
	,tm.id_tipo_menu
	,td.nombre_dieta nombre_Dieta_Menu
	,(SELECT u2.identificacion || ' ' || u2.primer_nombre || ' ' || u2.segundo_nombre || ' ' || u2.primer_apellido || ' ' || u2.segundo_apellido AS data_Persona
			FROM parranda.Usuarios u2
			WHERE u2.id_usuario = pu.id_usuario) AS informacion_Personal
	,tm.nombre_menu 
	,COUNT(tm.nombre_menu) AS cantidad_Personas
	,pu.confirmado 
	FROM parranda.plato_Usuario pu 
	INNER JOIN parranda.tipo_Menu tm ON
		pu.id_tipo_menu = tm.id_tipo_menu 
	INNER JOIN parranda.tipo_Dieta td ON
		tm.id_tipo_dieta = td.id_tipo_dieta 
	WHERE td.id_tipo_dieta IN (1) AND pu.confirmado = 'S'
	GROUP BY pu.id_usuario, tm.id_tipo_menu, nombre_Dieta_Menu, informacion_Personal, tm.nombre_menu, pu.confirmado 
	ORDER BY cantidad_Personas
)
SELECT COUNT(dim.cantidad_Personas) AS cantidad_Total_Personas
FROM data_Info_Menus dim
GROUP BY dim.cantidad_Personas
