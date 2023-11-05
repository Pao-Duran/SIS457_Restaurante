CREATE DATABASE Restaurante;

USE master
GO
CREATE LOGIN usrrest WITH PASSWORD=N'123456',
	DEFAULT_DATABASE=Restaurante,
	CHECK_EXPIRATION=OFF,
	CHECK_POLICY=ON
GO
USE Restaurante
GO
CREATE USER usrrest FOR LOGIN usrrest
GO
ALTER ROLE db_owner ADD MEMBER usrrest
GO

--ELIMINAR TABLAS 
DROP TABLE Cliente;
DROP TABLE Empleado;
DROP TABLE Mesa;
DROP TABLE Platos;
DROP TABLE Factura;
DROP TABLE detalleFactura;
DROP TABLE Reserva;
DROP TABLE Bebida;
DROP TABLE Usuario
--CREACION DE TABLAS 
CREATE TABLE Usuario (
  id INT PRIMARY KEY IDENTITY (1,1),
  nombre VARCHAR(30) NOT NULL,
  clave VARCHAR(10) NOT NULL,
  idEmpleado INT NOT NULL,

  CONSTRAINT fk_Usuario_Empleado FOREIGN KEY(idEmpleado) REFERENCES Empleado(id)

);



CREATE TABLE Cliente (
id INT PRIMARY KEY IDENTITY (1,1),
nombre VARCHAR (50) NOT NULL,
primerApellido VARCHAR (30) NOT NULL,
segundoApellido VARCHAR(30) NOT NULL,
cedulaIdentidad VARCHAR (10) NOT NULL,
telefono BIGINT NOT NULL
);

CREATE TABLE Empleado (
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(30) NOT NULL,
primerApellido VARCHAR (30) NOT NULL,
segundoApellido VARCHAR(30) NOT NULL,
telefono BIGINT NOT NULL,
direccion VARCHAR(30) NOT NULL,
cargo VARCHAR(30) NOT NULL
);

CREATE TABLE Mesa (
id INT PRIMARY KEY IDENTITY(1,1),
numMesa NUMERIC NOT NULL,

);

CREATE TABLE Platos (
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR (50) NOT NULL,
precio DECIMAL NOT NULL
);

CREATE TABLE Factura (
id INT PRIMARY KEY IDENTITY(1,1),
idCliente INT NOT NULL,
fecha DATE NOT NULL DEFAULT GETDATE(),

  CONSTRAINT fk_Factura_Cliente FOREIGN KEY(idCliente) REFERENCES Cliente(id)

);

CREATE TABLE detalleFactura (
id INT PRIMARY KEY IDENTITY(1,1),
idFactura INT NOT NULL,
idEmpleado INT NOT NULL,
idPlato INT NOT NULL,
idBebida INT NOT NULL,
idMesa INT NOT NULL,

 CONSTRAINT fk_detalleFactura_Factura FOREIGN KEY(idFactura) REFERENCES Factura(id),
 CONSTRAINT fk_detalleFactura_Empleado FOREIGN KEY(idEmpleado) REFERENCES Empleado(id),
 CONSTRAINT fk_detalleFactura_Platos FOREIGN KEY(idPlato) REFERENCES Platos(id),
 CONSTRAINT fk_detalleFactura_Mesa FOREIGN KEY(idMesa) REFERENCES Mesa(id),
 CONSTRAINT fk_detalleFactura_Bebida FOREIGN KEY(idBebida) REFERENCES Bebida(id),

);

CREATE TABLE Reserva (
id INT PRIMARY KEY IDENTITY(1,1),
idCliente INT NOT NULL,
idMesa INT NOT NULL,
fechaReserva DATETIME NOT NULL,

CONSTRAINT fk_Reserva_Cliente FOREIGN KEY(idCliente) REFERENCES Cliente(id),
CONSTRAINT fk_Reserva_Mesa FOREIGN KEY(idMesa) REFERENCES Mesa(id)

);

CREATE TABLE Bebida (
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR (50) NOT NULL,
precio DECIMAL NOT NULL,
marca VARCHAR(50),
descripcion VARCHAR(100) NOT NULL
);

ALTER TABLE Usuario  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Usuario ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Usuario ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo


ALTER TABLE Cliente  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Cliente ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Cliente ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE detalleFactura  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE detalleFactura ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE detalleFactura ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Empleado  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Empleado ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Empleado ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Factura  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Factura ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Factura ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Mesa  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Mesa ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Mesa ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Platos  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Platos ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Platos ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Reserva  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Reserva ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Reserva ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

ALTER TABLE Bebida  ADD usuarioRegistro VARCHAR (20) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Bebida ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Bebida ADD estado SMALLINT NOT NULL DEFAULT 1; -- -1: eliminacion logica, 0: inactivo, 1: activo

--USUARIO
CREATE PROC paUsuarioListar @parametro VARCHAR(50)
AS
  SELECT id,nombre,clave,idEmpleado,usuarioRegistro,fechaRegistro, estado
  FROM Usuario
  WHERE estado <> -1 AND nombre LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  SELECT *FROM Usuario

--CLIENTES
CREATE PROC paClienteListar @parametro Varchar(50)
AS
  SELECT id,nombre,primerApellido,segundoApellido,cedulaIdentidad,Telefono
  FROM Cliente
  WHERE estado <> -1 AND nombre LIKE '%'+ REPLACE (@parametro,' ','%')+'%';

INSERT INTO Cliente(nombre,primerApellido,segundoApellido,cedulaIdentidad,Telefono)
VALUES ('Luis','Perez','Mendoza','14181556','47852136');
INSERT INTO Cliente(nombre,primerApellido,segundoApellido,cedulaIdentidad,Telefono)
VALUES ('Pablo','Padilla','Arandia ','14181556','47852136');
INSERT INTO Cliente(nombre,primerApellido,segundoApellido,cedulaIdentidad,Telefono)
VALUES ('Mariana','Velazco','Gutierrez','7895411','16457845');

SELECT *FROM Cliente 

-- PLATOS
CREATE PROC paPlatoListar @parametro VARCHAR(50) 
AS
  SELECT id,nombre,precio,usuarioRegistro,fechaRegistro, estado 
  FROM Platos
  WHERE estado <> -1 AND nombre LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO Platos(nombre,precio)
  VALUES ('Lasaña',45);

  SELECT *FROM Platos 

  --EMPLEADO
CREATE PROC paEmpleadoListar @parametro VARCHAR(50) 
AS
  SELECT id,nombre,primerApellido,segundoApellido,telefono,direccion,cargo,usuarioRegistro,fechaRegistro, estado 
  FROM Empleado
  WHERE estado <> -1 AND nombre LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO Empleado(nombre,primerApellido,segundoApellido,telefono,direccion,cargo)
  VALUES ('Paola','Duran','Hinojosa',78963254,'avaroa 47','Gerente');

  INSERT INTO Empleado(nombre,primerApellido,segundoApellido,telefono,direccion,cargo)
  VALUES ('Lorenzo','Cordova','Llanos',7892547,'mendizabal 7','Cajero');


  SELECT *FROM Empleado

  --MESA
  CREATE PROC paMesaListar @parametro VARCHAR(50) 
AS
  SELECT id,numMesa,usuarioRegistro,fechaRegistro, estado 
  FROM Mesa
  WHERE estado <> -1 AND numMesa LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO Mesa(numMesa)
  VALUES (1);


  SELECT *FROM Mesa 

  --FACTURA
  CREATE PROC paFacturaListar @parametro VARCHAR(50) 
AS
  SELECT id,idCliente,fecha,usuarioRegistro,fechaRegistro, estado 
  FROM Factura
  WHERE estado <> -1 AND idCliente LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO Factura(idCliente,fecha)
  VALUES ('1','10/25/2023');


  SELECT *FROM Factura 

  --DETALLE FACTURA
  CREATE PROC paDetalleFacturaListar @parametro VARCHAR(50) 
AS
  SELECT id,idFactura,idEmpleado,idPlato,idMesa,usuarioRegistro,fechaRegistro, estado 
  FROM detalleFactura
  WHERE estado <> -1 AND idFactura LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO detalleFactura(idFactura,idEmpleado,idPlato,idMesa)
  VALUES (1,2,1,1);


  SELECT *FROM detalleFactura

  --RESERVA

  CREATE PROC paReservaListar @parametro VARCHAR(50) 
AS
  SELECT id,idCliente,idMesa,fechaReserva,usuarioRegistro,fechaRegistro, estado 
  FROM Reserva
  WHERE estado <> -1 AND idCliente LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


  INSERT INTO Reserva(idCliente,idMesa,fechaReserva)
  VALUES (1,1,'11/14/2023');


  SELECT *FROM Reserva 

--BEBIDA
CREATE PROC paBebidaListar @parametro VARCHAR(50)
AS
  SELECT id, nombre, precio, marca, descripcion, usuarioRegistro,fechaRegistro, estado 
  FROM Bebida
  WHERE estado <> -1 AND descripcion LIKE '%'+ REPLACE (@parametro,' ','%')+'%';

  INSERT INTO Bebida(nombre, precio,marca,descripcion)
  VALUES ('Coca Cola', 14,'Company Coca Cola', 'bebida gaseosa de 3 lts.');


  SELECT *FROM Bebida 