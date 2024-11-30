--Proyecto Maricruz Gomez Reyes--
--creacion de base--
Create Database ProyectoFinalMariGRDB

Use ProyectoFinalMariGRDB
 

--Creacion tabla Membresia

Create table Membresia(
IdMembresia Int Primary key Identity(1,1),
TipoMembresia varchar (50) Not null, 
CostoAnual Decimal (10,2)Not Null,
Estado varchar (20) Not Null,
Descuento decimal (10,2) Not null
);

--Insercion de data a tabla Membresia--
INSERT INTO Membresia(TipoMembresia, CostoAnual, Estado, Descuento)
VALUES 
('Membresía Básica', 50, 'Activa', 5),
('Membresía Premium', 100, 'Activa', 10),
('Membresía VIP', 150, 'Activa', 20),
('Sin Membresía', 0, 'Inactiva', 0);
 
--Creacion tabla Cliente



Create table Cliente(
IdCliente Int Primary key Identity(1,1),
IdMembresia int,
Nombre Varchar (50) Not Null,
Contacto Varchar (10) Not Null,
Direccion varchar (100) Not Null,
Foreign Key (IdMembresia) References Membresia(IDMembresia)

);

--Insercion de data a tabla cliente--
INSERT INTO Cliente (IdMembresia, Nombre, Contacto, Direccion)
VALUES 
(2,'juan Pérez', '1234567890', 'Avenida Central, San José, Costa Rica'),
(1,'Ana García', '0987654321', 'Calle 2, Heredia, Costa Rica'),
(4,'Carlos López', '1122334455', 'Calle Real, Alajuela, Costa Rica'),
(3,'María Sánchez', '2233445566', 'Calle 5, Cartago, Costa Rica'),
(1,'Pedro Rodríguez', '3344556677', 'Avenida 1, Puntarenas, Costa Rica'),
(2,'Laura Martínez', '4455667788', 'Calle 10, Guanacaste, Costa Rica');


--Creacion tabla Venta 

Create Table Ventas(
IdVentas Int Primary key Identity(1,1),
IdCliente Int,
Cantidad Int,
FechaVenta Datetime Default GETDATE() Not Null,
DescuentoTotal Decimal (10,2),
VentaTotal Decimal (10,2) Not Null,
Foreign Key (IdCliente) References Cliente (IdCliente),
);

Select * from Ventas
--Insercion datos tabla venta
INSERT INTO Ventas (IdCliente, Cantidad, FechaVenta, DescuentoTotal, VentaTotal)
VALUES
(1, 2, '2024-10-10', 70.00, 350.00 * 2 * 0.90),  -- Cliente 1 con 10% de descuento
(2, 3, '2024-11-09', 45.00, 300.00 * 3 * 0.95),  -- Cliente 2 con 5% de descuento
(3, 5, '2024-11-29', 0.00, 1500.00 * 5);  -- Cliente 3 sin descuento

--Creacion tabla facturas 


Create Table Factura(
IdFactura Int Primary key Identity(1,1),
IdVentas Int,
IdMembresia Int,
IdCliente Int,
FechaCompra Datetime Default GETDATE(),
Detalle text,
Subtotal Decimal (10,2) Not Null,
Descuento Decimal (10,2) Default 0.00,
Total Decimal (10,2) Not Null,
Foreign Key (Idventas) References Ventas (IdVentas),
Foreign Key (IdMembresia) References Membresia (IdMembresia),
Foreign Key (IdCliente) References Cliente (IdCliente)
);

--Insercion de datos tabla factura 
INSERT INTO Factura (IdVentas, IdMembresia, IdCliente, FechaCompra, Detalle, Subtotal, Descuento, Total)
VALUES
(1, 2, 1, '2024-10-10', 'Compra de productos con descuento de 10% (Membresía Premium)', 630.00, 70.00, 560.00),
(2, 1, 2, '2024-11-09', 'Compra de productos con descuento de 5% (Membresía VIP)', 855.00, 45.00, 810.00),
(3, 4, 3, '2024-11-29', 'Compra de productos sin descuento', 7500.00, 0.00, 7500.00);

--Creacion tabla Categoria

Create table Categoria(
IdCategoria Int Primary key Identity(1,1),
TipoCategoria Varchar (50),
);

--Insercion de data a tabla Categoria
INSERT INTO Categoria (TipoCategoria)
Values
('Gama Alta'),
('Gama Media');


--Creacion tabla Proveedor 

Create table Proveedor(
IdProveedor Int Primary key Identity(1,1),
Nombre Varchar (50) Not null,
Telefono varchar (10) Not Null,
ContactoPrincipal varchar (10),
Direccion Varchar (50) Not Null,
);


--Insercion de data a tabla Proveedor
INSERT INTO Proveedor (Nombre, Telefono, ContactoPrincipal, Direccion)
VALUES 
('Proveedor TechMobile', '223456780', 'Juan Perez', 'Calle Ficticia 123, Ciudad A'),
('Proveedor DigitalCom', '234567890', 'Ana Garcia', 'Avenida Principal 456, Ciudad B'),
('Proveedor MundoElectrónico', '345678901', 'Ed Ramirez', 'Calle Comercio 789, Ciudad C'),
('Proveedor CelularesPlus', '456789012', 'Mia Soto', 'Avenida 9 de Julio 101, Ciudad D');

--Creacion tabla Compra
Create table Compra(
IdCompra Int Primary key Identity(1,1),
IdProveedor Int,
FechaCompra Datetime Default GETDATE(),
Costo Decimal (10,2) Not Null,
Cantidad Int,
ProductosAdquiridos Varchar (50) Not Null,
Foreign key (IdProveedor) References Proveedor (IdProveedor)
);

--Insercion de datos tabla compra
INSERT INTO Compra (IdProveedor, FechaCompra, Costo, Cantidad, ProductosAdquiridos)
VALUES
(1, '2024-10-01', 17500.00, 50, 'Samsung Galaxy A54'),
(2, '2024-10-05', 21000.00, 70, 'Xiaomi Redmi Note 12 Pro'),
(3, '2024-10-10', 16800.00, 60, 'Motorola Moto G73'),
(1, '2024-10-15', 45000.00, 30, 'iPhone 15 Pro Max'),
(2, '2024-10-20', 48000.00, 40, 'Samsung Galaxy S23 Ultra'),
(4, '2024-10-25', 34965.00, 35, 'Google Pixel 8 Pro');



--Creacion tabla productos 


Create Table Productos(
IdProductos Int Primary key Identity(1,1),
IdCompra Int,
IdVentas Int,
IdCategoria Int,
IdProveedor Int,
Nombre Varchar (50) Not null unique,
Descripcion Text Not null,
CantidadStock Int Not null,
PrecioUnitario Decimal (10,2) Not Null,
Foreign Key (IdCompra) References Compra (IdCompra),
Foreign Key (IdVentas) References Ventas (IdVentas),
Foreign Key (IdCategoria) References Categoria (IdCategoria),
Foreign Key (IdProveedor) References Proveedor (IdProveedor),
);

--Insercion de datos tabla Productos
INSERT INTO Productos (IdCompra, IdVentas, IdCategoria, IdProveedor, Nombre, Descripcion, CantidadStock, PrecioUnitario)
VALUES
(1, NULL, 2, 1, 'Samsung Galaxy A54', 'Celular de gama media con pantalla Super AMOLED de 6.4 pulgadas, cámara de 50 MP, procesador Exynos 1380.', 50, 350.00),  -- Sin ventas (NULL)
(2, 1, 2, 2, 'Xiaomi Redmi Note 12 Pro', 'Celular de gama media con pantalla AMOLED de 6.67 pulgadas, cámara de 108 MP, procesador Dimensity 1080.', 70, 300.00), 
(3, 2, 2, 3, 'Motorola Moto G73', 'Smartphone de gama media con pantalla IPS LCD de 6.5 pulgadas, cámara de 50 MP, procesador MediaTek Dimensity 930.', 60, 280.00),
(4, 3, 1, 1, 'iPhone 15 Pro Max', 'Celular de gama alta con pantalla OLED de 6.7 pulgadas, cámara triple de 48 MP, procesador A17 Pro.', 30, 1500.00), 
(5, NULL, 1, 2, 'Samsung Galaxy S23 Ultra', 'Smartphone de gama alta con pantalla Dynamic AMOLED 2X de 6.8 pulgadas, cámara de 200 MP, procesador Snapdragon 8 Gen 2.', 40, 1200.00),  -- Sin ventas (NULL)
(6, NULL, 1, 4, 'Google Pixel 8 Pro', 'Celular de gama alta con pantalla LTPO OLED de 6.7 pulgadas, cámara de 50 MP, procesador Tensor G3.', 35, 999.00);  -- Sin ventas (NULL)


--creacion Tabla Inventario
Create Table Inventario(
IdInventario Int Primary Key Identity(1,1),
IdProveedor Int,
IdProductos Int,
Stock Int Not null,
Descripcion varchar (255) Not null,
Foreign Key (IdProveedor) References Proveedor (IdProveedor),
Foreign Key (IdProductos) References Productos (IdProductos)
);

--Insercion datos inventario

INSERT INTO Inventario (IdProveedor, IdProductos, Stock, Descripcion)
VALUES
(1, 7, 50, 'Celular de gama media con pantalla Super AMOLED de 6.4 pulgadas, cámara de 50 MP, procesador Exynos 1380.'),  -- Samsung Galaxy A54
(2, 8, 70, 'Celular de gama media con pantalla AMOLED de 6.67 pulgadas, cámara de 108 MP, procesador Dimensity 1080.'),  -- Xiaomi Redmi Note 12 Pro
(3, 9, 60, 'Smartphone de gama media con pantalla IPS LCD de 6.5 pulgadas, cámara de 50 MP, procesador MediaTek Dimensity 930.'),  -- Motorola Moto G73
(1, 10, 30, 'Celular de gama alta con pantalla OLED de 6.7 pulgadas, cámara triple de 48 MP, procesador A17 Pro.'),  -- iPhone 15 Pro Max
(2, 11, 40, 'Smartphone de gama alta con pantalla Dynamic AMOLED 2X de 6.8 pulgadas, cámara de 200 MP, procesador Snapdragon 8 Gen 2.'),  -- Samsung Galaxy S23 Ultra
(4, 12, 35, 'Celular de gama alta con pantalla LTPO OLED de 6.7 pulgadas, cámara de 50 MP, procesador Tensor G3.');  -- Google Pixel 8 Pro

SELECT * FROM Productos

--•	Objetos Avanzados


--1. Funciones Escalares

--1.1 Calcular el valor total de inventario disponible.

Create Function dbo.TotalInventario ()
Returns Decimal (10,2)
Begin
Declare @ValorTotal Decimal (10,2)
Select @ValorTotal= Sum(I.Stock * P.Precio)
from Productos P
Inner Join Inventario I
on P.IdProductos = I.IdProductos

return @ValorTotal
End

Select dbo.TotalInventario() As TotalInventarioDispo

--1.2 Determinar el número total de productos vendidos en un período.

Create Function dbo.TotalProductosVendidos()
Returns Int
Begin
	Declare @ProductosVendidos Int
	Select @ProductosVendidos = SUM(Cantidad)
	from Ventas
	Where FechaVenta between '2024-10-01' and '2024-11-29'

	return @ProductosVendidos
End

Select dbo.TotalProductosVendidos() As ProductosVendidosNov

--2. Función de Tabla

--2.1 Generar un listado detallado de productos bajo un nivel mínimo de stock

Create Function dbo.ProductobajoStock(@MinimoStock Int)
Returns Table
AS
Return (
Select P.IdProductos, P.Nombre, I.Stock, P.PrecioUnitario
From Productos P
Inner Join Inventario I
on P.IdProductos =I.IdProductos
WHERE I.Stock<@MinimoStock
);

Select * from dbo.ProductobajoStock(40);

Drop function dbo.ProductobajoStock

--3.Procedimientos Almacenados

--3.1 Registrar una nueva venta y actualizar el stock correspondiente.
Create Procedure RegistroVenta 
@IdCliente INT,
@IdProductos INT,
@Cantidad INT, 
@VentaTotal DECIMAL (10,2)
AS
BEGIN
Insert into Ventas (Idcliente, Cantidad, FechaVenta, VentaTotal)
Values (@IdCliente, @Cantidad, GetDate(),@Ventatotal);

update Inventario
set Stock= Stock-@Cantidad
where IdProductos = @IdProductos;

Print 'Venta Exitosa'
end

Exec RegistroVenta @IdCliente = 3, @IdProductos = 12, @Cantidad = 2, @VentaTotal = 3000.00;

select * from Inventario



Select * from Compra
Select * From Productos

--3.2 Registrar una nueva compra y actualizar el stock correspondiente.

Create Procedure RegistroCompra
@IdProveedor INT,
@IdProductos INT,
@Cantidad INT, 
@Costo DECIMAL (10,2),
@Producto Varchar (50)
AS
BEGIN
Insert into Compra(IdProveedor, Cantidad, FechaCompra, Costo, ProductosAdquiridos)
Values (@IdProveedor, @Cantidad, GetDate(),@Costo,@Producto);

update Inventario
set Stock= Stock+@Cantidad
where IdProductos = @IdProductos;

Print 'Compra Exitosa'
end

Exec RegistroCompra @IdProveedor = 1, @IdProductos = 7, @Cantidad = 1, @Costo = 350.00, @Producto = 'Samsung Galaxy A54';

Select * from Compra
Select * from Productos


--4. Vistas:
--4.1 Vista de productos con sus categorías y stock actual.
Create view ProductCategorStock 
AS
Select P.IdProductos as 'ID', P.Nombre as 'Producto', C.TipoCategoria as 'Categoria',SUM(I.Stock) as 'StockActual'
from Productos P
Inner Join Categoria C
on P.IdCategoria= C.IdCategoria
Inner Join Inventario I
ON p.IdProductos = I.IdProductos
Group by P.IdProductos, P.Nombre, C.TipoCategoria;

Select * From ProductCategorStock ORDER BY StockActual DESC;

--4.2 Vista de ventas realizadas por cliente y fecha

Create View VentasFechaCliente
As
Select  C.Nombre as 'Cliente', V.FechaVenta as 'Fecha Compra', V.VentaTotal as 'Total'
from Cliente C
Inner Join Ventas V
on C.IdCliente = V.IdCliente

Select * from VentasFechaCliente Order by Cliente, [Fecha Compra] desc

--4.3	Vista de compras realizadas por proveedor y fecha.

Select * from Compra

Create View CompraProveedorFecha
AS
Select P.Nombre as 'Proveedor', C.FechaCompra as 'Fecha' , C.Cantidad as 'Cantidad' , C.ProductosAdquiridos as 'Producto'
From Compra C
Inner Join Proveedor P
on P.IdProveedor = C.IdProveedor

Select * from CompraProveedorFecha Order by Proveedor, Fecha desc

--BACK UP

BACKUP DATABASE MiBaseDeDatos
TO DISK = 'C:\Respaldo\Proyecto_MaricruzGomezR.bak';