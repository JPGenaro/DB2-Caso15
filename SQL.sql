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

CREATE TABLE RegistroCalidad (
  idRegistroCalidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  fecha DATE,
  idObra INT,
  idEstadoRegistroCalidad INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  FOREIGN KEY (idEstadoRegistroCalidad) REFERENCES EstadoRegistroCalidad(idEstadoRegistroCalidad) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE Cronograma (
  idCronograma INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  idObra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
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

CREATE TABLE UnidadMedida (
  idUnidadMedida INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200)
);

CREATE TABLE Material (
  idMaterial INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion TEXT,
  precioUnitario DECIMAL(10,2),
  idUnidadMedida INT,
  FOREIGN KEY (idUnidadMedida) REFERENCES UnidadMedida(idUnidadMedida) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TABLE EstadoInventario (
  idEstadoInventario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(200)
);

CREATE TABLE Inventario (
  idInventario INT AUTO_INCREMENT PRIMARY KEY,
  cantMaterial INT,
  fechaActual DATE,
  precioUnitarioActual DECIMAL(10,2),
  idProyecto INT,
  idMaterial INT,
  idEstadoInventario INT,

  FOREIGN KEY (idProyecto) REFERENCES Proyecto(idProyecto) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
  FOREIGN KEY (idMaterial) REFERENCES Material(idMaterial) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
  FOREIGN KEY (idEstadoInventario) REFERENCES EstadoInventario(idEstadoInventario) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);



#Inserts
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

INSERT INTO EstadoObra (nombre, descripcion) VALUES
('En Proceso', 'Obra en construcción'),
('Finalizado', 'Obra completada'),
('Cancelado', 'Obra cancelada'),
('En Espera', 'Obra en espera'),
('Suspendido', 'Obra suspendida');

INSERT INTO Obra (direccion, fechaInicio, fechaFinal, idCliente, idEstadoObra) VALUES
('Calle piola 1441', '2022-11-10', NULL, 1, 1),
('Avenida 456', '2021-10-20', '2022-04-15', 2, 2),
('La manzana 675 de Newton 21', '2022-12-05', '2023-06-30', 5, 1),
('Juan Lantin 432', '2021-08-15', '2022-02-28', 6, 2),
('La calle 8789', '2022-01-01', NULL, 8, 3);



INSERT INTO GastosAsociados (nombre, descripcion, monto, fechaActual, idObra)
VALUES
('Impuestos', 'Pago de impuestos anuales', 1500.00, '2022-03-01', 1),
('Impuestos', 'Pago de impuestos anuales', 5000.00, '2022-04-15', 2),
('Transporte', 'Gastos en transporte de materiales', 3000.00, '2023-03-28', 3),
('Publicidad', 'Gastos en publicidad para promocionar la obra', 2000.00, '2022-04-10', 1),
('Transporte', 'Gastos en transporte de materiales', 1000.00, '2022-05-05', 5);

INSERT INTO Evaluacion (titulo, critica, valoracion, fecha, idObra) VALUES
('Excelente', 'La obra empieza excelente en todos los aspectos', 5, '2023-01-20', 1),
('Mala actuación', 'La actuación de los obreros fue indisiplanada en la ultima semana', 2, '2023-02-05', 1),
('Muy Mal Desempeño', 'Muy mala en todos los sentidos, una caca', 1, '2022-08-10', 3),
('Excelente', 'La obra empieza excelente en todos los aspectos, y fuimos campeones del mundo osea', 4, '2022-12-18', 4),
('Desempeño Normal', 'El desempeño de la obra ni pincha ni corta', 3, '2022-05-15', 3);

INSERT INTO EstadoCambioExtra (nombre, descripcion) VALUES
('En proceso', 'Cambio extra en proceso'),
('Aprobado', 'Cambio extra aprobado'),
('Rechazado', 'Cambio extra rechazado'),
('Pendiente', 'Cambio extra esta pendiente'),
('Cancelado', 'Cambio extra fue cancelado');

INSERT INTO CambioExtra (nombre, descripcion, fecha, idObra, idEstadoCambioExtra) VALUES
('Otro baño', 'Quiero un baño extra para mi suegra', '2023-01-02', 1, 1),
('Un Bunker AntiBombas', 'Quiero un bunker anti-bombas', '2022-03-22', 5, 3),
('Un Nuevo Revoque De Piso', 'Cambiar el piso de color', '2022-12-30', 1, 2),
('Un Asador', 'Un Asador bien fachero', '2022-08-20', 3, 2),
('Otro baño', 'Quiero un baño extra', '2023-01-10', 3, 3);

INSERT INTO EstadoRegistroCalidad (nombre, descripcion) VALUES
('En proceso', 'Registro de calidad en proceso'),
('Aprobado', 'Registro de calidad aprobado'),
('Rechazado', 'Registro de calidad rechazado'),
('Pendiente', 'Registro de calidad esta pendiente'),
('Cancelado', 'Registro de calidad fue cancelado');

INSERT INTO RegistroCalidad (nombre, descripcion, fecha, idObra, idEstadoRegistroCalidad) VALUES
('Calidad de materiales', 'Registro de calidad de los materiales utilizados', '2022-12-25', 1, 1),
('Calidad de acabados', 'Registro de calidad de los acabados de la obra', '2022-07-15', 2, 2),
('Calidad de instalaciones', 'Registro de calidad de las instalaciones de la obra', '2023-03-20', 1, 3),
('Calidad de estructura', 'Registro de calidad de la estructura de la obra', '2022-04-30', 1, 4),
('Calidad de limpieza', 'Registro de calidad de la limpieza de la obra', '2022-05-10', 5, 5),
('Calidad de limpieza', 'Registro de calidad de la limpieza de la obra', '2022-12-28', 1, 3),
('Calidad de acabados', 'Registro de calidad de los acabados de la obra', '2023-01-12', 1, 4);

INSERT INTO EstadoProyecto (nombre, descripcion) VALUES
('Progreso', 'Proyecto en desarrollo'),
('Finalizado', 'Proyecto completado'),
('Cancelado', 'Proyecto cancelado'),
('En Espera', 'Proyecto en espera'),
('Suspendido', 'Proyecto suspendido');

INSERT INTO Cronograma (nombre, descripcion, idObra) VALUES
('Cronograma de construcción', 'Cronograma de construcción de la obra', 1),
('Cronograma de remodelación', 'Cronograma de remodelación de la obra', 1),
('Cronograma de ampliación', 'Cronograma de ampliación de la obra', 3),
('Cronograma de rehabilitación', 'Cronograma de rehabilitación de la obra', 4),
('Cronograma de demolicion', 'Cronograma de demolicion de la obra', 2);

INSERT INTO Proyecto (nombre, descripcion, montoExtra, fechaInicio, fechaFinal, idCronograma, idEstadoProyecto) VALUES
('Construcción de baño', 'Proyecto de Construcción de baño', 100000.00, DATE_SUB(NOW(), INTERVAL 4 MONTH) + INTERVAL 19 DAY, '2023-01-01', 1, 1),
('Construccion de living', 'Proyecto de Construccion de living', 200000.00, '2022-02-01', '2022-12-01', 1, 2),
('Construccion de cocina', 'Proyecto de Construccion de cocina', 250000.00, '2022-03-01', '2022-10-01', 2, 1),
('Contruccion de baño', 'Proyecto de Contruccion de baño', 120000.00, '2022-04-01', '2023-04-01', 4, 4),
('Construccion de bunker', 'Proyecto de Construccion de bunker', 300000.00, '2022-05-01', '2022-08-01', 5, 5);

INSERT INTO EmpleadosProyecto (idEmpleado, idProyecto) VALUES
(3, 1),
(3, 2),
(4, 1),
(7, 2),
(9, 3),
(10, 3);

INSERT INTO UnidadMedida (nombre, descripcion) VALUES
('Bolsa', 'Unidad de medida equivalente a una bolsa'),
('Litro', 'Unidad de medida de volumen'),
('Kilogramo', 'Unidad de medida de peso'),
('Unidad', 'Unidad de medida de unidad'),
('Tablas', 'Unidad de medida de tablas');

INSERT INTO Material (nombre, descripcion, precioUnitario, idUnidadMedida) VALUES
('Cemento', 'Material de construcción', 50.00, 1),
('Arena', 'Material de construcción', 20.00, 3),
('Ladrillo', 'Material de construcción', 1.50, 4),
('Pintura', 'Material de acabado', 25.00, 2),
('Madera', 'Material de construcción', 100.00, 5);

INSERT INTO EstadoInventario (nombre, descripcion) VALUES
('Disponible', 'El material está disponible para su uso'),
('En uso', 'El material se encuentra en uso'),
('Agotado', 'El material se ha terminado'),
('Requerido', 'El material no se encuentra, pero se requiere'),
('Cancelado', 'El material fue cancelado');

INSERT INTO Inventario (cantMaterial, fechaActual, precioUnitarioActual, idProyecto, idMaterial, idEstadoInventario) VALUES
(100, '2023-03-28', 50.00, 1, 1, 1),
(200, '2023-02-12', 20.00, 1, 2, 1),
(500, '2023-01-17', 1.50, 2, 3, 4),
(50, '2022-08-28', 25.00, 3, 4, 1),
(1000, '2022-03-03', 50.00, 2, 5, 5),
(9, '2022-03-03', 50.00, 2, 1, 4);





#1 
SELECT P.nombre,EP.nombre,P.fechaInicio
FROM Proyecto P JOIN EstadoProyecto EP ON P.idEstadoProyecto = EP.idEstadoProyecto
WHERE EP.nombre = 'Progreso' AND P.fechaInicio = DATE(DATE_SUB(NOW(), INTERVAL 4 MONTH) + INTERVAL 19 DAY);


#2
SELECT * from (
  SELECT P.idProyecto,P.nombre as NombreProyecto,SUM(I.precioUnitarioActual*I.cantMaterial) + P.montoExtra as precio_total
  FROM Proyecto P 
  JOIN Inventario I ON P.idProyecto = I.idProyecto
  JOIN EstadoProyecto EP ON P.idEstadoProyecto = EP.idEstadoProyecto
  WHERE EP.nombre = 'Finalizado' AND P.fechaFinal >= DATE(DATE_SUB(NOW(), INTERVAL 6 MONTH))
  GROUP BY P.idProyecto
) AS FinalizadoEnUltimos6Meses
UNION ALL
SELECT * FROM(
  SELECT P.idProyecto,P.nombre as NombreProyecto,SUM(I.precioUnitarioActual*I.cantMaterial) + P.montoExtra as precio_total
  FROM Proyecto P 
  JOIN Inventario I ON P.idProyecto = I.idProyecto
  JOIN EstadoProyecto EP ON P.idEstadoProyecto = EP.idEstadoProyecto
  GROUP BY P.idProyecto
  ORDER BY precio_total ASC
  LIMIT 1
) AS PrecioMaximo
UNION ALL
SELECT * FROM(
  SELECT P.idProyecto,P.nombre as NombreProyecto,SUM(I.precioUnitarioActual*I.cantMaterial) + P.montoExtra as precio_total
  FROM Proyecto P 
  JOIN Inventario I ON P.idProyecto = I.idProyecto
  JOIN EstadoProyecto EP ON P.idEstadoProyecto = EP.idEstadoProyecto
  GROUP BY P.idProyecto
  ORDER BY precio_total DESC
  LIMIT 1
) AS PrecioMinimo;


#3
SELECT P.idProyecto,P.nombre as NombreProyecto,EP.nombre as EstadoProyecto,M.nombre as Material,I.cantMaterial as CantidadMaterial,UM.nombre as UnidadMedida,EI.nombre as EstadoInventario,EO.nombre as EstadoObra
from Obra O
JOIN EstadoObra EO on O.idEstadoObra = EO.idEstadoObra
JOIN Cronograma C on O.idObra = C.idObra 
JOIN Proyecto P on C.idCronograma = P.idCronograma
JOIN EstadoProyecto EP on P.idEstadoProyecto = EP.idEstadoProyecto
JOIN Inventario I on P.idProyecto = I.idProyecto
JOIN EstadoInventario EI on I.idEstadoInventario = EI.idEstadoInventario
JOIN Material M on I.idMaterial = M.idMaterial
JOIN UnidadMedida UM on M.idUnidadMedida = UM.idUnidadMedida
WHERE EI.nombre = 'Requerido' or EI.nombre =  'Disponible' and EO.nombre = 'En Proceso';

 

#4
SELECT O.idObra,P.idProyecto,P.nombre as NombreProyecto,RC.nombre as VisitasPeriodicas,I.cantMaterial,M.nombre as Material,UM.nombre as UnidadMedida,EI.nombre as EstadoInventario
from RegistroCalidad RC
JOIN EstadoRegistroCalidad ERC on RC.idEstadoRegistroCalidad = ERC.idEstadoRegistroCalidad
JOIN Obra O on  RC.idObra = O.idObra
JOIN Cronograma C on O.idObra = C.idObra 
JOIN Proyecto P on C.idCronograma = P.idCronograma
JOIN EstadoProyecto EP on P.idEstadoProyecto = EP.idEstadoProyecto
JOIN Inventario I on P.idProyecto = I.idProyecto
JOIN EstadoInventario EI on I.idEstadoInventario = EI.idEstadoInventario
JOIN Material M on I.idMaterial = M.idMaterial
JOIN UnidadMedida UM on M.idUnidadMedida = UM.idUnidadMedida
WHERE I.cantMaterial = 9 and EI.nombre = 'Requerido' and M.nombre = 'Cemento' and UM.nombre = 'Bolsa' and 
RC.idObra in (
  select id from (
    select COUNT(*) as cant,Obra.idObra as id from Obra
    JOIN RegistroCalidad on Obra.idObra = RegistroCalidad.idObra
    group By Obra.idObra
  )AS cantidad
    where cant>=5
  )
;


#5

SELECT idEmpleado,Nombre,Apellido,SUM(SueldoPorProyecto) as SueldoTotal,MAX(SueldoPorProyecto) as MaximoSueldoProyecto,MIN(SueldoPorProyecto) as MinimoSueldoProyecto from (
  SELECT Persona.idPersona as idEmpleado,Persona.nombre as Nombre,Persona.apellido as Apellido,P.nombre as NombreProyecto,P.idProyecto,proyecto_data.precio_total/100 as SueldoPorProyecto
  FROM EmpleadosProyecto E_P
  JOIN Empleado E on E_P.idEmpleado = E.idEmpleado
  JOIN Personas Persona on E.idEmpleado = Persona.idPersona
  JOIN Proyecto P on E_P.idProyecto = P.idProyecto
  JOIN (
    SELECT P.idProyecto,P.nombre as NombreProyecto,SUM(I.precioUnitarioActual*I.cantMaterial) + P.montoExtra as precio_total
    FROM Proyecto P 
    JOIN Inventario I ON P.idProyecto = I.idProyecto
    JOIN EstadoProyecto EP ON P.idEstadoProyecto = EP.idEstadoProyecto
    GROUP BY P.idProyecto
  ) proyecto_data on P.idProyecto = proyecto_data.idProyecto
) Empleados
GROUP BY idEmpleado
;







