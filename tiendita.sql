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
