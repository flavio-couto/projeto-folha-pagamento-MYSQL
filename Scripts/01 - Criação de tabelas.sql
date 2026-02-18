-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema couto_corporation
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema couto_corporation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `couto_corporation` DEFAULT CHARACTER SET utf8 ;
USE `couto_corporation` ;

-- -----------------------------------------------------
-- Table `couto_corporation`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couto_corporation`.`cargos` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `tipo` ENUM('Operacional', 'Tatico', 'Estrategico') NOT NULL COMMENT 'Ver se desmenbra o TIPO para uma outra tabela',
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couto_corporation`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couto_corporation`.`departamentos` (
  `id_departamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `despesa` ENUM('Direta', 'Indireta') NOT NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couto_corporation`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couto_corporation`.`funcionarios` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(250) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` ENUM('masculino', 'feminino') NULL,
  `admissao` DATE NOT NULL,
  `demissao` DATE NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `ativo` ENUM('Sim', 'Nao') NOT NULL DEFAULT 'Sim',
  `id_cargo` INT NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`, `id_cargo`, `id_departamento`),
  INDEX `fk_funcionarios_cargos_idx` (`id_cargo` ASC) VISIBLE,
  INDEX `fk_funcionarios_departamentos1_idx` (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_funcionarios_cargos`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `couto_corporation`.`cargos` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionarios_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `couto_corporation`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couto_corporation`.`folha_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couto_corporation`.`folha_pagamento` (
  `id_folha` INT NOT NULL AUTO_INCREMENT,
  `id_funcionario` INT NOT NULL,
  `competencia` DATE NOT NULL,
  `salario_base` DECIMAL(10,2) NULL,
  `adicionais` DECIMAL(10,2) NULL,
  `inss` DECIMAL(10,2) NULL,
  `irrf` DECIMAL(10,2) NULL,
  `outros_descontos` DECIMAL(10,2) NULL,
  `total_proventos` DECIMAL(10,2) NULL,
  `total_descontos` DECIMAL(10,2) NULL,
  `liquido` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_folha`),
  INDEX `fk_folha_pagamento_funcionarios1_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_folha_pagamento_funcionarios1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `couto_corporation`.`funcionarios` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couto_corporation`.`tb_inss`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couto_corporation`.`tb_inss` (
  `id_inss` INT NOT NULL AUTO_INCREMENT,
  `faixa_inicial` DECIMAL(10,2) NOT NULL,
  `faixa_final` DECIMAL(10,2) NOT NULL,
  `aliquota` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_inss`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
