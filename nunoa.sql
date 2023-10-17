/*REPRESENTANTES: id, rut, dv, email, passwd, nombre_social, nombre, apellido, telefono, celular
COMUNAS: id, nombre
JUNTAS_VECINOS: id, numero, nombre, comunas_id
LOCALES: id, rol, pago, direccion, giro, patentes_id, representantes_id, juntas_vecinos_id, comunas_id
PATENTES: id, nombre, tipo*/

--｡･:*:･ﾟ★,｡･:*:･ﾟ☆QUERIES･ﾟ☆｡･:*:･ﾟ★,｡･:*:｡･-- 

--1. Mostrar el nombre social del rut perteneciente a 97004000-5
SELECT nombre_social FROM representantes WHERE rut = 97004000 AND dv = '5';