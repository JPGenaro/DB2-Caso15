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
  fechaInicio DATE,
  fechaFinal DATE,
  idObra INT,
  FOREIGN KEY (idObra) REFERENCES Obra(idObra) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Proyecto (
  idProyecto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  montoExtra DECIMAL(10,2),
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