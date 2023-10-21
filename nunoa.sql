/*REPRESENTANTES: id, rut, dv, email, passwd, nombre_social, nombre, apellido, telefono, celular
COMUNAS: id, nombre
JUNTAS_VECINOS: id, numero, nombre, comunas_id
LOCALES: id, rol, pago, direccion, giro, patentes_id, representantes_id, juntas_vecinos_id, comunas_id
PATENTES: id, nombre, tipo*/

--｡･:*:･ﾟ★,｡･:*:･ﾟ☆QUERIES･ﾟ☆｡･:*:･ﾟ★,｡･:*:｡･-- 

--1. Mostrar el nombre social del rut perteneciente a 97004000-5
SELECT nombre_social FROM representantes WHERE rut = 97004000 AND dv = '5';

--2. Mostrar las direcciones de los locales que corresponden al rut 97004000-5
SELECT direccion FROM locales JOIN representantes ON representantes.id = locales.representantes_id WHERE representantes.rut = 97004000 AND representantes.dv = '5';

--3. ¿Cuantos locales hay en comuna de Ñuñoa?
SELECT COUNT(*) FROM locales JOIN comunas ON comunas.id = locales.comunas_id WHERE comunas.nombre = "Municipalidad de Ñuñoa";

--4. ¿Cuantos locales tiene el rut 97023000-9 en la junta de vecinos numero 7?
SELECT COUNT(*) FROM locales JOIN representantes ON representantes.id = locales.representantes_id JOIN juntas_vecinos ON juntas_vecinos.id = locales.juntas_vecinos_id WHERE
representantes.rut = 97023000 AND representantes.dv = '9' AND juntas_vecinos.numero = 7;

--5. ¿Cuantos locales hay en la unidad vecinal 18?
SELECT COUNT(*) FROM locales JOIN juntas_vecinos ON juntas_vecinos.id = locales.juntas_vecinos_id WHERE juntas_vecinos.numero = 18;

--6. Mostrar la direccion con locales
--No entendi XD

--7. Mostrar el nombre social de los representantes que tengan más de 3 locales y menos de 7 locales
SELECT nombre_social FROM locales JOIN representantes ON representantes.id = locales.representantes_id GROUP BY representantes.id, representantes.nombre_social
HAVING COUNT(locales.id) > 3 AND COUNT(locales.id) < 7;

--8. Mostrar cuanto paga nombre social CENCOSUD RETAIL S.A. por la totalidad de sus patentes


--9. Mostrar ordenadamente de mayor a menor quienes tienen mas locales en la comuna


--10. Mostrar quien tiene más locales en la comuna


--11. Mostrar los representantes que no estan presente en la junta de vecinos mayores al numero 30 y menores al numero 10


--12. Mostrar el nombre social de quien más paga en las junta vecinos 4 y 16