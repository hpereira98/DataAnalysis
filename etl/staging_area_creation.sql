-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sa_northwind
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sa_northwind
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sa_northwind` DEFAULT CHARACTER SET utf8 ;
USE `sa_northwind` ;

-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_purchase` (
  `purchase_key` INT NOT NULL AUTO_INCREMENT,
  `quantity` DOUBLE NULL,
  `total_cost` DOUBLE NULL,
  `id_supplier` INT NOT NULL,
  `id_product` INT NOT NULL,
  `submitted_date` DATETIME NULL,
  `id_purchase` INT NULL,
  PRIMARY KEY (`purchase_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_supplier` (
  `id_supplier` INT NOT NULL,
  `company` VARCHAR(50) NULL,
  `country` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  PRIMARY KEY (`id_supplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_product` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `code` VARCHAR(25) NULL,
  `category` VARCHAR(50) NULL,
  `quantity_per_unit` VARCHAR(50) NULL,
  `standard_cost` DOUBLE NULL,
  `list_price` DOUBLE NOT NULL,
  PRIMARY KEY (`id_product`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_sale` (
  `sale_key` INT NOT NULL AUTO_INCREMENT,
  `quantity` DOUBLE NULL,
  `total_cost` DOUBLE NULL,
  `discount` DOUBLE NULL,
  `id_product` INT NOT NULL,
  `id_client` INT NOT NULL,
  `id_shipper` INT NOT NULL,
  `id_employee` INT NOT NULL,
  `order_date` DATETIME NULL,
  `id_sale` INT NULL,
  PRIMARY KEY (`sale_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_client` (
  `id_client` INT NOT NULL,
  `company` VARCHAR(50) NULL,
  `full_name` VARCHAR(101) NULL,
  `country` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_shipper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_shipper` (
  `id_shipper` INT NOT NULL,
  `company` VARCHAR(50) NULL,
  `country` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  PRIMARY KEY (`id_shipper`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sa_northwind`.`sa_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sa_northwind`.`sa_employee` (
  `id_employee` INT NOT NULL,
  `company` VARCHAR(50) NULL,
  `full_name` VARCHAR(101) NULL,
  PRIMARY KEY (`id_employee`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
