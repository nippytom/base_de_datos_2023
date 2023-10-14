/* EMPLEADOS: rut, nombre, cargo, rut_jefe, sueldo, comision, numdep
DEPTOS: numdep, nombre, ciudad
GRADOS: grado, sueldo_inf, sueldo_sup
CLIENTES: rut, nombre, comuna
PRODUCTOS: codigo, nombre, precio
VENTAS: num_venta, monto, fecha, rut_vende, rut_cliente
VENTAS_DETALLE: num_venta, cod_producto, cantidad */

--20. Rut de los clientes y monto total comprado por cada uno de ellos
SELECT rut_cliente, SUM(monto) FROM ventas GROUP BY ventas.rut_cliente;

--21. Nombre de los clientes y monto total comprado por cada uno de ellos
SELECT clientes.nombre, SUM(monto) FROM clientes JOIN ventas ON ventas.rut_cliente = clientes.rut GROUP BY clientes.rut, clientes.nombre;

--22. Nombre de los vendedores y monto total vendido por cada uno de ellos
SELECT empleados.nombre, SUM(monto) FROM empleados JOIN ventas ON ventas.rut_vende = empleados.rut GROUP BY empleados.rut, empleados.nombre;

--23. Nombre del producto menos vendido
SELECT productos.nombre FROM (SELECT MIN(SUM) FROM (SELECT SUM(cantidad) FROM ventas_detalle GROUP BY cod_producto) as suma) as minimo JOIN 
(SELECT cod_producto, SUM(cantidad) FROM ventas_detalle GROUP BY cod_producto) as suma2 ON minimo.MIN = suma2.SUM JOIN productos ON productos.codigo = suma2.cod_producto;

--24. Nombre del cliente que ha comprado mas veces en la tienda
SELECT clientes.nombre FROM (SELECT MAX(COUNT) FROM (SELECT COUNT(*) FROM ventas GROUP BY rut_cliente) as t1) as t2 JOIN (SELECT rut_cliente, COUNT(*) FROM ventas GROUP BY rut_cliente) as t3
ON t2.MAX = t3.COUNT JOIN clientes ON clientes.rut = t3.rut_cliente;

--25. Nombre del producto que nunca se ha vendido
SELECT productos.nombre FROM productos WHERE productos.codigo NOT IN (SELECT cod_producto FROM ventas_detalle);

--26. Comuna en la que vive el cliente que ha comprado menos televisores
SELECT comuna FROM (SELECT MIN(SUM) FROM (SELECT SUM(cantidad) FROM ventas_detalle JOIN productos ON productos.codigo = ventas_detalle.cod_producto WHERE productos.nombre = 'televisor'
GROUP BY num_venta) as t1) as t2 JOIN (SELECT num_venta, SUM(cantidad) FROM ventas_detalle JOIN productos ON productos.codigo = ventas_detalle.cod_producto WHERE productos.nombre = 'televisor'
GROUP BY num_venta) as t3 ON t3.SUM = t2.MIN JOIN ventas ON ventas.num_venta = t3.num_venta JOIN clientes ON clientes.rut = ventas.rut_cliente;

--27. Nombre del vendedor que ha vendido menos dvd's
SELECT empleados.nombre FROM (SELECT MIN(SUM) FROM (SELECT SUM(cantidad) FROM ventas_detalle JOIN productos ON productos.codigo = ventas_detalle.cod_producto WHERE productos.nombre = 'dvd' GROUP BY num_venta)
as t1) as t2 JOIN (SELECT num_venta, SUM(cantidad) FROM ventas_detalle JOIN productos ON productos.codigo = ventas_detalle.cod_producto WHERE productos.nombre = 'dvd' GROUP BY num_venta)
as t3 ON t3.SUM = t2.MIN JOIN ventas ON ventas.num_venta = t3.num_venta JOIN empleados ON empleados.rut = ventas.rut_vende GROUP BY empleados.nombre;

--28. 