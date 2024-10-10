-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cinepucp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cinepucp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinepucp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cinepucp` ;

-- -----------------------------------------------------
-- Table `cinepucp`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `duration` INT NOT NULL,
  `releaseDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`movieprojections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`movieprojections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movieId` INT NULL DEFAULT NULL,
  `roomId` INT NULL DEFAULT NULL,
  `projectionDate` DATETIME NOT NULL,
  `availableSeats` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `movieId` (`movieId` ASC) VISIBLE,
  INDEX `roomId` (`roomId` ASC) VISIBLE,
  CONSTRAINT `movieprojections_ibfk_1`
    FOREIGN KEY (`movieId`)
    REFERENCES `cinepucp`.`movies` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `movieprojections_ibfk_2`
    FOREIGN KEY (`roomId`)
    REFERENCES `cinepucp`.`rooms` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `roleId` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `roleId` (`roleId` ASC) VISIBLE,
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`roleId`)
    REFERENCES `cinepucp`.`roles` (`id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`roomseats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`roomseats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `roomId` INT NULL DEFAULT NULL,
  `seatNumber` VARCHAR(10) NOT NULL,
  `rowNumber` CHAR(2) NOT NULL,
  `isAvailable` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `roomId` (`roomId` ASC) VISIBLE,
  CONSTRAINT `roomseats_ibfk_1`
    FOREIGN KEY (`roomId`)
    REFERENCES `cinepucp`.`rooms` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cinepucp`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinepucp`.`reservations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NULL DEFAULT NULL,
  `movieProjectionId` INT NULL DEFAULT NULL,
  `roomSeatId` INT NULL DEFAULT NULL,
  `startDatetime` DATETIME NOT NULL,
  `endDatetime` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `userId` (`userId` ASC) VISIBLE,
  INDEX `movieProjectionId` (`movieProjectionId` ASC) VISIBLE,
  INDEX `roomSeatId` (`roomSeatId` ASC) VISIBLE,
  CONSTRAINT `reservations_ibfk_1`
    FOREIGN KEY (`userId`)
    REFERENCES `cinepucp`.`users` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_2`
    FOREIGN KEY (`movieProjectionId`)
    REFERENCES `cinepucp`.`movieprojections` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_3`
    FOREIGN KEY (`roomSeatId`)
    REFERENCES `cinepucp`.`roomseats` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into cinepucp.roles(name) values("ADMIN"),
("GERENTE"),("CLIENTE");
