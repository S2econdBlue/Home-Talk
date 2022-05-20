-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema happyhouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema happyhouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `happyhouse` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `happyhouse` ;

-- -----------------------------------------------------
-- Table `happyhouse`.`sidocode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`sidocode` (
  `sidoCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`sidoCode`),
  UNIQUE INDEX `sidoName` (`sidoName` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`dongcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`dongcode` (
  `dongCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`dongCode`),
  INDEX `sidoName` (`sidoName` ASC) VISIBLE,
  CONSTRAINT `dongcode_ibfk_1`
    FOREIGN KEY (`sidoName`)
    REFERENCES `happyhouse`.`sidocode` (`sidoName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`aroundbusinessarea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`aroundbusinessarea` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `businessName` VARCHAR(50) NULL DEFAULT NULL,
  `businessType` VARCHAR(30) NULL DEFAULT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  `let` VARCHAR(20) NULL DEFAULT NULL,
  `lng` VARCHAR(20) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_aroundBusinessArea_dongcode1_idx` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `aroundBusinessArea_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 314636
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`baseaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`baseaddress` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `lat` VARCHAR(20) NULL DEFAULT NULL,
  `lng` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `baseaddress_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 3597
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`userinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`userinfo` (
  `id` VARCHAR(15) NOT NULL,
  `pw` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `age` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `grade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`threadboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`threadboard` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(15) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(500) NULL DEFAULT NULL,
  `time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `opt` INT NULL DEFAULT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_threadboard_userinfo1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_threadboard_userinfo1`
    FOREIGN KEY (`id`)
    REFERENCES `happyhouse`.`userinfo` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`boardlike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`boardlike` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `no` INT NOT NULL,
  `userinfo_id` VARCHAR(15) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_boardlike_threadboard1_idx` (`no` ASC) VISIBLE,
  INDEX `fk_boardlike_userinfo1_idx` (`userinfo_id` ASC) VISIBLE,
  PRIMARY KEY (`no`),
  CONSTRAINT `fk_boardlike_threadboard1`
    FOREIGN KEY (`no`)
    REFERENCES `happyhouse`.`threadboard` (`no`),
  CONSTRAINT `fk_boardlike_userinfo1`
    FOREIGN KEY (`userinfo_id`)
    REFERENCES `happyhouse`.`userinfo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`guguncode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`guguncode` (
  `gugunCode` VARCHAR(10) NOT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`gugunCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`houseinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`houseinfo` (
  `aptCode` INT NOT NULL,
  `aptName` VARCHAR(50) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `buildYear` INT NULL DEFAULT NULL,
  `jibun` VARCHAR(30) NULL DEFAULT NULL,
  `lat` VARCHAR(30) NULL DEFAULT NULL,
  `lng` VARCHAR(30) NULL DEFAULT NULL,
  `img` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`aptCode`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `houseinfo_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`housedeal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`housedeal` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `aptCode` INT NULL DEFAULT NULL,
  `dealAmount` VARCHAR(20) NULL DEFAULT NULL,
  `dealYear` INT NULL DEFAULT NULL,
  `dealMonth` INT NULL DEFAULT NULL,
  `dealDay` INT NULL DEFAULT NULL,
  `area` VARCHAR(30) NULL DEFAULT NULL,
  `floor` VARCHAR(30) NULL DEFAULT NULL,
  `type` VARCHAR(30) NULL DEFAULT NULL,
  `rentMoney` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `aptCode` (`aptCode` ASC) VISIBLE,
  CONSTRAINT `housedeal_ibfk_1`
    FOREIGN KEY (`aptCode`)
    REFERENCES `happyhouse`.`houseinfo` (`aptCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 68865
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`imgboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`imgboard` (
  `filename` VARCHAR(50) NOT NULL,
  `no` INT NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`filename`),
  INDEX `fk_imgboard_threadboard1_idx` (`no` ASC) VISIBLE,
  CONSTRAINT `fk_imgboard_threadboard1`
    FOREIGN KEY (`no`)
    REFERENCES `happyhouse`.`threadboard` (`no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`interestarea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`interestarea` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(15) NOT NULL,
  `dongCode` VARCHAR(10) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`no`),
  INDEX `fk_userinfo_has_dongcode_dongcode1_idx` (`dongCode` ASC) VISIBLE,
  INDEX `fk_userinfo_has_dongcode_userinfo1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_userinfo_has_dongcode_dongcode1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`),
  CONSTRAINT `fk_userinfo_has_dongcode_userinfo1`
    FOREIGN KEY (`id`)
    REFERENCES `happyhouse`.`userinfo` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`observelocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`observelocation` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `local_name` VARCHAR(10) NULL DEFAULT NULL,
  `observe_station` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB
AUTO_INCREMENT = 515
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`seller_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`seller_book` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `book_id` VARCHAR(15) NOT NULL,
  `seller_id` VARCHAR(15) NOT NULL,
  `title` VARCHAR(500) NOT NULL,
  `created_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `book_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_seller_book_userinfo1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_seller_book_userinfo2_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `fk_seller_book_userinfo1`
    FOREIGN KEY (`book_id`)
    REFERENCES `happyhouse`.`userinfo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seller_book_userinfo2`
    FOREIGN KEY (`seller_id`)
    REFERENCES `happyhouse`.`userinfo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happyhouse`.`subway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`subway` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `line` VARCHAR(50) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `lat` VARCHAR(45) NOT NULL,
  `lng` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happyhouse`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`table1` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
