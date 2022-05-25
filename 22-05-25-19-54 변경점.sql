drop table commonmaintainitem;
drop table eachfeeitem;

-- -----------------------------------------------------
-- Table `happyhouse`.`commonMaintainItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`commonMaintainItem` (
  `boardNo` INT NOT NULL,
  `item` VARCHAR(10) NOT NULL,
  INDEX `fk_commonMaintainItem_tradeboard1_idx` (`boardNo` ASC) VISIBLE,
  PRIMARY KEY (`boardNo`, `item`),
  CONSTRAINT `fk_commonMaintainItem_tradeboard1`
    FOREIGN KEY (`boardNo`)
    REFERENCES `happyhouse`.`tradeboard` (`boardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happyhouse`.`eachFeeItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`eachFeeItem` (
  `boardNo` INT NOT NULL,
  `item` VARCHAR(10) NOT NULL,
  INDEX `fk_eachFeeItem_tradeboard1_idx` (`boardNo` ASC) VISIBLE,
  PRIMARY KEY (`boardNo`, `item`),
  CONSTRAINT `fk_eachFeeItem_tradeboard1`
    FOREIGN KEY (`boardNo`)
    REFERENCES `happyhouse`.`tradeboard` (`boardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;