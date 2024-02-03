/*
  Warnings:

  - You are about to drop the column `Metodo_Pago` on the `pagos` table. All the data in the column will be lost.
  - You are about to alter the column `Referencia` on the `pagos` table. The data in that column could be lost. The data in that column will be cast from `VarChar(100)` to `Char(10)`.
  - You are about to drop the column `Fecha_Actualizacion` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the column `Fecha_Creacion` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the column `Token` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the `permisos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `roles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `roles_permisos` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `MetodoPago` to the `pagos` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `roles` DROP FOREIGN KEY `roles_ibfk_1`;

-- DropForeignKey
ALTER TABLE `roles_permisos` DROP FOREIGN KEY `roles_permisos_ibfk_1`;

-- DropForeignKey
ALTER TABLE `roles_permisos` DROP FOREIGN KEY `roles_permisos_ibfk_2`;

-- AlterTable
ALTER TABLE `actividadesextra` MODIFY `Fecha_Inicio` DATE NULL,
    MODIFY `Fecha_Fin` DATE NULL;

-- AlterTable
ALTER TABLE `pagos` DROP COLUMN `Metodo_Pago`,
    ADD COLUMN `MetodoPago` INTEGER NOT NULL,
    MODIFY `Referencia` CHAR(10) NOT NULL;

-- AlterTable
ALTER TABLE `periodos` MODIFY `Fecha_Inicio` DATE NULL,
    MODIFY `Fecha_Fin` DATE NULL;

-- AlterTable
ALTER TABLE `usuarios` DROP COLUMN `Fecha_Actualizacion`,
    DROP COLUMN `Fecha_Creacion`,
    DROP COLUMN `Token`,
    ADD COLUMN `Rol` VARCHAR(50) NULL,
    MODIFY `Id_Periodo` INTEGER NULL,
    MODIFY `Id_Grado` INTEGER NULL,
    MODIFY `Id_Grupo` INTEGER NULL;

-- DropTable
DROP TABLE `permisos`;

-- DropTable
DROP TABLE `roles`;

-- DropTable
DROP TABLE `roles_permisos`;

-- CreateTable
CREATE TABLE `metodospago` (
    `Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(50) NULL,
    `Descripcion` VARCHAR(200) NULL,

    PRIMARY KEY (`Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
