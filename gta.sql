/*
Usuarios: id,nombre,nivel, psn_user
UsuariosArmas: usuario_id, arma_id, municion
Armas: id, modelo, tipo, maximo
Misiones: id, nombre, nivel_minimo, dinero, experiencia
UsuariosMisiones: usuarios_id, mision_id, terminado
*/

--｡･:*:･ﾟ★,｡･:*:･ﾟ☆QUERIES･ﾟ☆｡･:*:･ﾟ★,｡･:*:｡･-- 

--1. Nombre de usuarios que tienen el arma "Lanza Cohetes Teledirigido" con su municion al maximo
SELECT psn_user FROM usuarios JOIN UsuarioArmas ON UsuariosArmas.usuario_id = usuario.id JOIN armas ON armas.id = UsuariosArmas.arma_id WHERE armas.modelo = "Lanza Cohetes Teledirigido" AND armas.maximo = "TRUE";

--2. Nombre de usuarios de que han terminado exactamente 5 misiones
SELECT psn_user FROM usuarios JOIN (SELECT usuario_id, COUNT(*) FROM UsuariosMisiones WHERE terminado = TRUE GROUP BY usuario_id) AS t1 ON t1.usuario_id = usuarios.id WHERE t1.COUNT = 5;

--3. Nombre de usuarios que tienen sus armas con sus municiones al maximo.
SELECT psn_user FROM usuarios JOIN (SELECT usuario_id, COUNT(*) FROM usuariosarmas GROUP BY usuario_id) as t1 ON usuarios.id = t1.usuario_id JOIN
(SELECT COUNT(*), usuario_id FROM usuariosarmas JOIN armas ON armas.id = usuariosarmas.arma_id WHERE municion = maximo GROUP BY usuario_id) as t2 ON t2.usuario_id = t1.usuario_id
...

--4. Nombre del personaje que la suma de dinero que ha ganado sea mas de 1.000.000 dolares
SELECT nombre FROM usuarios(SELECT usuario_id, SUM(dinero) FROM usuariosmisiones JOIN misiones ON misiones.id = usuariosmisiones.mision_id WHERE terminado = TRUE GROUP BY usuario_id) AS t1
ON t1.usuario_id = usuarios.idWHERE t1.dinero = 1000000;

--5. Cuales son los usuarios que han realizado mas misiones distintas
SELECT psn_user FROM (SELECT MAX(COUNT) FROM (SELECT usuario_id, COUNT(*) FROM 
(SELECT usuario_id, mision_id FROM usuariosmisiones GROUP BY usuario_id, mision_id) as t1) as t2) JOIN (SELECT usuario_id, COUNT(*) FROM 
(SELECT usuario_id, mision_id FROM usuariosmisiones GROUP BY usuario_id, mision_id) as t3) as t4 ON t4.COUNT = t2.MAX JOIN usuarios ON usuarios.id = t4.usuario_id

--6. Cuales son los usuarios con mas armas.
SELECT psn_user FROM (SELECT MAX(COUNT) FROM (SELECT usuario_id, COUNT(*) FROM usuariosarmas GROUP BY usuario_id )as t1) as t2 
JOIN (SELECT usuario_id, COUNT(*) FROM usuariosarmas GROUP BY usuario_id )as t3 ON t3.COUNT = t2.MAX JOIN usuarios ON usuarios.id = t3.usuario_id;