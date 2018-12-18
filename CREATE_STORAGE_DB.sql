-- MySQL Script generated by MySQL Workbench
-- Вт 18 дек 2018 05:54:55
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema storagedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `storagedb` ;

-- -----------------------------------------------------
-- Schema storagedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `storagedb` ;
USE `storagedb` ;

-- -----------------------------------------------------
-- Table `storagedb`.`product_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`product_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`product_dim` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`provider_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`provider_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`provider_dim` (
  `ProviderID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  `contact` VARCHAR(150) NULL,
  PRIMARY KEY (`ProviderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`date_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`date_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`date_dim` (
  `DateID` INT NOT NULL AUTO_INCREMENT,
  `year` INT NULL,
  `month` INT NULL,
  `day_of_month` INT NULL,
  `holiday` TINYINT NULL,
  `weekend` TINYINT NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`DateID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`category_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`category_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`category_dim` (
  `CategoryID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`shop_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`shop_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`shop_dim` (
  `ShopID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  `city` VARCHAR(150) NULL,
  `address` VARCHAR(150) NULL,
  `contact` VARCHAR(150) NULL,
  PRIMARY KEY (`ShopID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`order_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`order_dim` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`order_dim` (
  `ShopOrderID` INT NULL,
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `creation_date` DATETIME NULL,
  `total_cost` DOUBLE NULL,
  PRIMARY KEY (`OrderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`sales_fact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`sales_fact` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`sales_fact` (
  `product_dim_productID` INT NOT NULL,
  `provider_dim_providerID` INT NOT NULL,
  `date_dim_dateID` INT NOT NULL,
  `category_dim_categoryID` INT NOT NULL,
  `shop_dim_shopID` INT NOT NULL,
  `order_dim_orderID` INT NOT NULL,
  `quantity` INT NULL,
  `sell_price` DOUBLE NULL,
  `product_price` DOUBLE NULL,
  PRIMARY KEY (`product_dim_productID`, `provider_dim_providerID`, `date_dim_dateID`, `category_dim_categoryID`, `shop_dim_shopID`, `order_dim_orderID`),
  CONSTRAINT `fk_fact_sales_product_dim1`
    FOREIGN KEY (`product_dim_productID`)
    REFERENCES `storagedb`.`product_dim` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_sales_provider_dim1`
    FOREIGN KEY (`provider_dim_providerID`)
    REFERENCES `storagedb`.`provider_dim` (`ProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_sales_date_dim1`
    FOREIGN KEY (`date_dim_dateID`)
    REFERENCES `storagedb`.`date_dim` (`DateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_sales_category_dim1`
    FOREIGN KEY (`category_dim_categoryID`)
    REFERENCES `storagedb`.`category_dim` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_shop_dim1`
    FOREIGN KEY (`shop_dim_shopID`)
    REFERENCES `storagedb`.`shop_dim` (`ShopID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_order_dim1`
    FOREIGN KEY (`order_dim_orderID`)
    REFERENCES `storagedb`.`order_dim` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storagedb`.`shop_popular_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storagedb`.`shop_popular_categories` ;

CREATE TABLE IF NOT EXISTS `storagedb`.`shop_popular_categories` (
  `PopularCategoriesID` INT NOT NULL,
  `shop_name` VARCHAR(150) NULL,
  `shop_address` VARCHAR(150) NULL,
  `category_name` VARCHAR(150) NULL,
  `quantity` INT NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  PRIMARY KEY (`PopularCategoriesID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
