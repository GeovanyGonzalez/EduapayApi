-- CreateTable
CREATE TABLE `actividadesextra` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(50) NULL,
    `Descripcion` VARCHAR(200) NULL,
    `Precio` DECIMAL(10, 2) NULL,
    `Imagen` VARCHAR(200) NULL,
    `Fecha_Inicio` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `Fecha_Fin` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grados` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(20) NULL,
    `IdPeriodo` INTEGER NOT NULL,

    INDEX `IdPeriodo`(`IdPeriodo`),
    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grupos` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(50) NULL,
    `Cupo` INTEGER NULL,
    `IdGrado` INTEGER NOT NULL,

    INDEX `IdGrado`(`IdGrado`),
    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pagos` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Monto` DECIMAL(10, 2) NOT NULL,
    `Fecha_Pago` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `Metodo_Pago` DECIMAL(10, 2) NOT NULL,
    `Referencia` VARCHAR(100) NOT NULL,
    `Estado` VARCHAR(50) NOT NULL,
    `Id_Usuario` INTEGER NOT NULL,
    `Id_Periodo` INTEGER NOT NULL,
    `Id_ActividadExtra` INTEGER NOT NULL,

    INDEX `Id_ActividadExtra`(`Id_ActividadExtra`),
    INDEX `Id_Periodo`(`Id_Periodo`),
    INDEX `Id_Usuario`(`Id_Usuario`),
    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `periodos` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(100) NULL,
    `Precio` DECIMAL(10, 2) NULL,
    `Fecha_Inicio` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `Fecha_Fin` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permisos` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(100) NULL,

    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(100) NULL,
    `IdUsuario` INTEGER NOT NULL,

    INDEX `IdUsuario`(`IdUsuario`),
    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles_permisos` (
    `IdRol` INTEGER NOT NULL,
    `IdPermiso` INTEGER NOT NULL,

    PRIMARY KEY (`IdRol`, `IdPermiso`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarios` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(100) NULL,
    `Apellido` VARCHAR(100) NULL,
    `CorreoElectronico` VARCHAR(50) NULL,
    `Contrasena` VARCHAR(200) NULL,
    `Token` VARCHAR(200) NULL,
    `FotoPerfil` VARCHAR(200) NULL,
    `Fecha_Creacion` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `Fecha_Actualizacion` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `Id_Periodo` INTEGER NOT NULL,
    `Id_Grado` INTEGER NOT NULL,
    `Id_Grupo` INTEGER NOT NULL,

    INDEX `Id_Grado`(`Id_Grado`),
    INDEX `Id_Grupo`(`Id_Grupo`),
    INDEX `Id_Periodo`(`Id_Periodo`),
    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `grados` ADD CONSTRAINT `grados_ibfk_1` FOREIGN KEY (`IdPeriodo`) REFERENCES `periodos`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `grupos` ADD CONSTRAINT `grupos_ibfk_1` FOREIGN KEY (`IdGrado`) REFERENCES `grados`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pagos` ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`Id_Usuario`) REFERENCES `usuarios`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pagos` ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`Id_Periodo`) REFERENCES `periodos`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pagos` ADD CONSTRAINT `pagos_ibfk_3` FOREIGN KEY (`Id_ActividadExtra`) REFERENCES `actividadesextra`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `roles` ADD CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `roles_permisos` ADD CONSTRAINT `roles_permisos_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `roles`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `roles_permisos` ADD CONSTRAINT `roles_permisos_ibfk_2` FOREIGN KEY (`IdPermiso`) REFERENCES `permisos`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `usuarios` ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Id_Periodo`) REFERENCES `periodos`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `usuarios` ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`Id_Grado`) REFERENCES `grados`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `usuarios` ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`Id_Grupo`) REFERENCES `grupos`(`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
