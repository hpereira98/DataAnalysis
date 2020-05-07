-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dw_northwind
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dw_northwind
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_northwind` DEFAULT CHARACTER SET utf8 ;
USE `dw_northwind` ;

-- -----------------------------------------------------
-- Table `dw_northwind`.`local_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`local_dim` (
  `key_local` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  PRIMARY KEY (`key_local`),
  UNIQUE INDEX `local_unique` (`country` ASC, `city` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`supplier_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`supplier_dim` (
  `key_supplier` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) NULL,
  `key_local` INT NOT NULL,
  `id_supplier` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_supplier`),
  INDEX `fk_supplier_dim_local_dim1_idx` (`key_local` ASC) VISIBLE,
  UNIQUE INDEX `id_supplier_UNIQUE` (`id_supplier` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_dim_local_dim1`
    FOREIGN KEY (`key_local`)
    REFERENCES `dw_northwind`.`local_dim` (`key_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`product_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`product_dim` (
  `key_product` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `code` VARCHAR(25) NULL,
  `category` VARCHAR(50) NULL,
  `quantity_per_unit` VARCHAR(50) NULL,
  `standard_cost` DOUBLE NULL,
  `list_price` DOUBLE NOT NULL,
  `id_product` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_product`),
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`time_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`time_dim` (
  `key_time` INT NOT NULL AUTO_INCREMENT,
  `day` INT NULL,
  `month` INT NULL,
  `year` INT NULL,
  `week_day` INT NULL,
  `full_date` DATETIME NULL,
  PRIMARY KEY (`key_time`),
  UNIQUE INDEX `full_date_UNIQUE` (`full_date` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`purchase_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`purchase_fact` (
  `key_purchase` INT NOT NULL AUTO_INCREMENT,
  `quantity` DOUBLE NULL,
  `total_cost` DOUBLE NULL,
  `key_supplier` INT NOT NULL,
  `key_product` INT NOT NULL,
  `key_time` INT NOT NULL,
  `id_purchase` INT NULL,
  `id_purchase_details` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_purchase`),
  INDEX `fk_purchase_fact_supplier_dim_idx` (`key_supplier` ASC) VISIBLE,
  INDEX `fk_purchase_fact_product_dim1_idx` (`key_product` ASC) VISIBLE,
  INDEX `fk_purchase_fact_time_dim1_idx` (`key_time` ASC) VISIBLE,
  UNIQUE INDEX `purchase_unique` (`id_purchase` ASC, `id_purchase_details` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_fact_supplier_dim`
    FOREIGN KEY (`key_supplier`)
    REFERENCES `dw_northwind`.`supplier_dim` (`key_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_fact_product_dim1`
    FOREIGN KEY (`key_product`)
    REFERENCES `dw_northwind`.`product_dim` (`key_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_fact_time_dim1`
    FOREIGN KEY (`key_time`)
    REFERENCES `dw_northwind`.`time_dim` (`key_time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`client_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`client_dim` (
  `key_client` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) NULL,
  `full_name` VARCHAR(101) NULL,
  `key_local` INT NOT NULL,
  `id_client` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_client`),
  INDEX `fk_client_dim_local_dim1_idx` (`key_local` ASC) VISIBLE,
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_client_dim_local_dim1`
    FOREIGN KEY (`key_local`)
    REFERENCES `dw_northwind`.`local_dim` (`key_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`shipper_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`shipper_dim` (
  `key_shipper` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) NULL,
  `key_local` INT NOT NULL,
  `id_shipper` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_shipper`),
  INDEX `fk_shipper_dim_local_dim1_idx` (`key_local` ASC) VISIBLE,
  UNIQUE INDEX `id_shipper_UNIQUE` (`id_shipper` ASC) VISIBLE,
  CONSTRAINT `fk_shipper_dim_local_dim1`
    FOREIGN KEY (`key_local`)
    REFERENCES `dw_northwind`.`local_dim` (`key_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`employee_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`employee_dim` (
  `key_employee` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) NULL,
  `full_name` VARCHAR(101) NULL,
  `id_employee` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_employee`),
  UNIQUE INDEX `id_employee_UNIQUE` (`id_employee` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_northwind`.`sale_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_northwind`.`sale_fact` (
  `key_sale` INT NOT NULL AUTO_INCREMENT,
  `quantity` DOUBLE NULL,
  `total_cost` DOUBLE NULL,
  `discount` DOUBLE NULL,
  `key_product` INT NOT NULL,
  `key_time` INT NOT NULL,
  `key_client` INT NOT NULL,
  `key_shipper` INT NOT NULL,
  `key_employee` INT NOT NULL,
  `id_sale` INT NULL,
  `id_sale_details` INT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`key_sale`),
  INDEX `fk_sale_fact_product_dim1_idx` (`key_product` ASC) VISIBLE,
  INDEX `fk_sale_fact_time_dim1_idx` (`key_time` ASC) VISIBLE,
  INDEX `fk_sale_fact_client_dim1_idx` (`key_client` ASC) VISIBLE,
  INDEX `fk_sale_fact_shipper_dim1_idx` (`key_shipper` ASC) VISIBLE,
  INDEX `fk_sale_fact_employee_dim1_idx` (`key_employee` ASC) VISIBLE,
  UNIQUE INDEX `sale_unique` (`id_sale` ASC, `id_sale_details` ASC) VISIBLE,
  CONSTRAINT `fk_sale_fact_product_dim1`
    FOREIGN KEY (`key_product`)
    REFERENCES `dw_northwind`.`product_dim` (`key_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_fact_time_dim1`
    FOREIGN KEY (`key_time`)
    REFERENCES `dw_northwind`.`time_dim` (`key_time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_fact_client_dim1`
    FOREIGN KEY (`key_client`)
    REFERENCES `dw_northwind`.`client_dim` (`key_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_fact_shipper_dim1`
    FOREIGN KEY (`key_shipper`)
    REFERENCES `dw_northwind`.`shipper_dim` (`key_shipper`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_fact_employee_dim1`
    FOREIGN KEY (`key_employee`)
    REFERENCES `dw_northwind`.`employee_dim` (`key_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
