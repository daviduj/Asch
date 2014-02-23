SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `asch` DEFAULT CHARACTER SET latin1 ;
USE `asch` ;

-- -----------------------------------------------------
-- Table `asch`.`Car_History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Car_History` (
  `id_diagnostic` INT(255) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id_diagnostic`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Client` (
  `vehicle_identification` INT(255) NOT NULL,
  `identification` INT(20) NOT NULL,
  `name` TEXT NOT NULL,
  `lastname` TEXT NOT NULL,
  `is_commercial` TINYINT(1) NOT NULL,
  PRIMARY KEY (`vehicle_identification`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Diagnostics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Diagnostics` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `vehicle` INT(255) NOT NULL,
  `id_history` INT(255) NOT NULL,
  `id_mechanic` INT(255) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Diagnostics_Car_History1_idx` (`id_history` ASC),
  CONSTRAINT `fk_Diagnostics_Car_History1`
    FOREIGN KEY (`id_history`)
    REFERENCES `asch`.`Car_History` (`id_diagnostic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Employee` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `identification_number` INT(20) NOT NULL,
  `name` TEXT NOT NULL,
  `lastname` TEXT NOT NULL,
  `vehicle_id` INT(255) NOT NULL,
  `asigned_vehicles` INT(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Parts` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `provider` INT(100) NOT NULL,
  `in_stock` INT(255) NOT NULL,
  `part_number` INT(255) NOT NULL,
  `quantity` INT(255) NOT NULL,
  `cost` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Vehicle` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `brand` TEXT NOT NULL,
  `model` TEXT NOT NULL,
  `style` TEXT NOT NULL,
  `color` TEXT NOT NULL,
  `transmision` TEXT NOT NULL,
  `gas_type` INT(255) NOT NULL,
  `cabin_type` TEXT NOT NULL,
  `manufacture_year` TEXT NOT NULL,
  `cylinder` INT(255) NOT NULL,
  `doors` TEXT NOT NULL,
  `fk_diagnostics` INT(255) NOT NULL,
  `fk_orders` INT(255) NOT NULL,
  `fk_parts` INT(255) NOT NULL,
  `fk_vehicle_identification` INT(255) NOT NULL,
  `employee` INT(255) NULL,
  `service` INT(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vehicle_identification` (`fk_vehicle_identification` ASC),
  INDEX `fk_Vehicle_Diagnostics1_idx` (`fk_diagnostics` ASC),
  INDEX `fk_Vehicle_Parts1_idx` (`fk_parts` ASC),
  CONSTRAINT `vehicle_ibfk_1`
    FOREIGN KEY (`fk_vehicle_identification`)
    REFERENCES `asch`.`Client` (`vehicle_identification`),
  CONSTRAINT `fk_Vehicle_Diagnostics1`
    FOREIGN KEY (`fk_diagnostics`)
    REFERENCES `asch`.`Diagnostics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicle_Parts1`
    FOREIGN KEY (`fk_parts`)
    REFERENCES `asch`.`Parts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Vehicle_has_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Vehicle_has_employee` (
  `Vehicle_id` INT(255) NOT NULL,
  `employee_id` INT(255) NOT NULL,
  PRIMARY KEY (`Vehicle_id`, `employee_id`),
  INDEX `fk_Vehicle_has_employee_employee1_idx` (`employee_id` ASC),
  INDEX `fk_Vehicle_has_employee_Vehicle1_idx` (`Vehicle_id` ASC),
  CONSTRAINT `fk_Vehicle_has_employee_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `asch`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicle_has_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `asch`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `asch`.`Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Services` (
  `id_services` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `cost` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`id_services`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asch`.`Vehicle_has_Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asch`.`Vehicle_has_Services` (
  `Vehicle_id` INT(255) NOT NULL,
  `Services_id_services` INT NOT NULL,
  `date_service` DATETIME NOT NULL,
  PRIMARY KEY (`Vehicle_id`, `Services_id_services`),
  INDEX `fk_Vehicle_has_Services_Services1_idx` (`Services_id_services` ASC),
  INDEX `fk_Vehicle_has_Services_Vehicle1_idx` (`Vehicle_id` ASC),
  CONSTRAINT `fk_Vehicle_has_Services_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `asch`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicle_has_Services_Services1`
    FOREIGN KEY (`Services_id_services`)
    REFERENCES `asch`.`Services` (`id_services`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
