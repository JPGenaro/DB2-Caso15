drop database if exists Caso_15;
create database Caso_15;
use Caso_15;

CREATE TABLE TipoDocumento (
  idTipoDocumento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100)
);

CREATE TABLE Personas (
  idPersona INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  email VARCHAR(100),
  numeroDocumento VARCHAR(20),
  idTipoDocumento INT,
  FOREIGN KEY (idTipoDocumento) REFERENCES TipoDocumento(idTipoDocumento)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Cliente (
  idCliente INT PRIMARY KEY,
  fechaRegistro DATE,
  FOREIGN KEY (idCliente) REFERENCES Personas(idPersona)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Empleado (
  idEmpleado INT PRIMARY KEY,
  fechaNacimiento DATE,
  FOREIGN KEY (idEmpleado) REFERENCES Personas(idPersona)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE EstadoProyecto (
  idEstadoProyecto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100)
);

CREATE TABLE EstadoObra (
  idEstadoObra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100)
);

CREATE TABLE Obra (
  idObra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  direccion VARCHAR(100),
  fechaInicio DATE,
  fechaFinal DATE,
  idCliente INT,
  idEstadoObra INT,
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  FOREIGN KEY (idEstadoObra) REFERENCES EstadoObra(idEstadoObra)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE GastosAsociados (
  idGastosAsociados INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  monto DECIMAL(10, 2),
  fechaActual DATE,
  idObra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Evaluacion (
  idEvaluacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(50),
  critica VARCHAR(100),
  valoracion INT,
  fecha DATE,
  idObra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE EstadoCambioExtra (
  idEstadoCambioExtra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100)
);

CREATE TABLE CambioExtra (
  idCambiosExtra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  fecha DATE,
  idObra INT,
  idEstadoCambioExtra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  FOREIGN KEY (idEstadoCambioExtra) REFERENCES EstadoCambioExtra(idEstadoCambioExtra) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE EstadoRegistroCalidad (
  idEstadoRegistroCalidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100)
);

CREATE TABLE registroCalidad (
  idregistroCalidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  fecha DATE,
  idObra INT,
  idEstadoRegistroCalidad INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idEstadoRegistroCalidad) REFERENCES EstadoRegistroCalidad(idEstadoRegistroCalidad) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Cronograma (
  idCronograma INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  idObra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Proyecto (
  idProyecto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  montoExtra DECIMAL(10,2),
  fechaInicio DATE,
  fechaFinal DATE,
  idCronograma INT,
  idEstadoProyecto INT,
  FOREIGN KEY (idCronograma) REFERENCES Cronograma(idCronograma) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
  FOREIGN KEY (idEstadoProyecto) REFERENCES EstadoProyecto(idEstadoProyecto) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE EmpleadosProyecto (
  idEmpleadoProyecto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idEmpleado INT,
  idProyecto INT,
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  FOREIGN KEY (idProyecto) REFERENCES Proyecto(idProyecto)
    ON UPDATE CASCADE 
    ON DELETE SET NULL
);


CREATE TABLE Inventario (
  idInventario INT AUTO_INCREMENT PRIMARY KEY,
  cantMaterial INT,
  fechaActual DATE,
  precioUnitarioActual DECIMAL(10,2),
  idProyecto INT,
  FOREIGN KEY (idProyecto) REFERENCES Proyecto(idProyecto) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE EstadoInventario (
  idEstadoInventario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion TEXT,
  idInventario INT,
  FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE Material (
  idMaterial INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion TEXT,
  precioUnitario DECIMAL(10,2),
  idInventario INT,
  FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE UnidadMedida (
  idUnidadMedida INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200),
  idMaterial INT NOT NULL,
  FOREIGN KEY (idMaterial) REFERENCES Material(idMaterial) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);


INSERT INTO TipoDocumento (nombre, descripcion) VALUES
('DNI', 'Documento Nacional de Identidad'),
('Pasaporte', 'Pasaporte internacional'),
('Cedula', 'Cedula de Identidad'),
('RUC', 'Registro Único de Contribuyentes'),
('Carnet de Extranjeria', 'Carnet para extranjeros');

INSERT INTO Personas (nombre, apellido, email, numeroDocumento, idTipoDocumento) VALUES
('Pepito', 'Peponcio', 'holasoypepito@gmail.com', '12345678', 1),
('Genaro', 'JuanCarlos', 'jcgenaro@yahoo.com', '87654321', 2),
('Joaco', 'ElCapo', 'elcapodejoaco@hotmail.com', '23456789', 3),
('María', 'Laura', 'marialaura@gmail.com', '34567890', 1),
('Armando', 'Barreras', 'acasamexico@hotmail.com', '45678901', 4),
('Ducky', 'Elpato', 'nashe@gmail.com', '3344556677', 1),
('Facha', 'Fachero', 'facher05mb@gmail.com.ar', '83289203', 2),
('Elon', 'Maskara', 'tengomoney@hotmail.com', '000000000', 5),
('Gustavo', 'Alfonso', 'gustavito@gmail.com', '3543696768', 1),
('Kiki', 'Naki', 'lakikiynaki@hotmail.com', '98765432', 1);

INSERT INTO Cliente (idCliente, fechaRegistro) VALUES
(1, '2022-01-15'),
(2, '2021-05-23'),
(5, '2022-02-28'),
(6, '2020-12-01'),
(8, '2022-03-10');

INSERT INTO Empleado (idEmpleado, fechaNacimiento) VALUES
(3, '1995-07-12'),
(4, '1987-11-30'),
(7, '1992-03-08'),
(9, '1985-05-18'),
(10, '1998-02-05');

INSERT INTO EstadoProyecto (nombre, descripcion) VALUES
('En Proceso', 'Proyecto en desarrollo'),
('Finalizado', 'Proyecto completado'),
('Cancelado', 'Proyecto cancelado'),
('En Espera', 'Proyecto en espera'),
('Suspendido', 'Proyecto suspendido');

INSERT INTO EstadoObra (nombre, descripcion) VALUES
('En Proceso', 'Obra en construcción'),
('Finalizado', 'Obra completada'),
('Cancelado', 'Obra cancelada'),
('En Espera', 'Obra en espera'),
('Suspendido', 'Obra suspendida');

INSERT INTO Obra (direccion, fechaInicio, fechaFinal, idCliente, idEstadoObra) VALUES
('Calle piola 1441', '2022-02-10', NULL, 1, 1),
('Avenida 456', '2021-10-20', '2022-04-15', 2, 2),
('La manzana 675 de Newton 21', '2022-12-05', '2023-06-30', 5, 1),
('Juan Lantin 432', '2021-08-15', '2022-02-28', 6, 2),
('La calle 8789', '2022-01-01', NULL, 8, 3);

#1 
SELECT *
FROM Proyecto
WHERE idEstadoProyecto = (SELECT idEstadoProyecto FROM EstadoProyecto WHERE nombre = 'Progreso')
AND fechaInicio = DATE_SUB(NOW(), INTERVAL 4 MONTH) + INTERVAL 19 DAY;

#2
SELECT SUM(montoExtra) AS montoTotal, MAX(montoExtra) AS maxMonto, MIN(montoExtra) AS minMonto, nombre AS proyecto
FROM Proyecto
WHERE idEstadoProyecto = 2 AND fechaFin >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY nombre;

#3
