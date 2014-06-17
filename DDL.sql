-- MySQL Script generated by MySQL Workbench
-- 06/15/14 15:27:24
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `school` ;
CREATE SCHEMA IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `school` ;

-- -----------------------------------------------------
-- Table `school`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`user` (
  `id` INT NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `teacher` TINYINT(1) NOT NULL DEFAULT 0,
  `admin` TINYINT(1) NOT NULL DEFAULT 0,
  `name` VARCHAR(45) NULL,
  `department` VARCHAR(45) NULL,
  `resident_id` VARCHAR(20) NULL,
  `birthday` DATE NULL,
  `birthplace` VARCHAR(80) NULL,
  `sex` TINYINT(1) NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  `qq` VARCHAR(15) NULL,
  `website` VARCHAR(45) NULL,
  `address` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`student` (
  `id` INT NOT NULL CHECK (`id` in (select `id` from `user` where `teacher`=0)),
  `major` VARCHAR(45) NULL,
  `enter_date` DATE NULL,
  `study_year` INT NULL,
  `study_type` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `student_user`
    FOREIGN KEY (`id`)
    REFERENCES `school`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`teacher` (
  `id` INT NOT NULL CHECK (`id` in (select `id` from `user` where `teacher`=1)),
  `teacher_type` VARCHAR(20) NULL,
  `start_date` DATE NULL,
  `salary` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `teacher_user`
    FOREIGN KEY (`id`)
    REFERENCES `school`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`course` (
  `course_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `teacher` INT NULL,
  `season` DECIMAL(5,1) NULL,
  `place` VARCHAR(45) NULL,
  `weekday` INT NULL,
  `time` TIME NULL,
  `size` INT NULL,
  `grade` DECIMAL(2,1) NULL,
  `applying` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`course_id`),
  INDEX `teacher_idx` (`teacher` ASC),
  CONSTRAINT `course_teacher`
    FOREIGN KEY (`teacher`)
    REFERENCES `school`.`teacher` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`exam` (
  `course_id` INT NOT NULL CHECK (`course_id` in (select `course_id` from `course` where `applying`=0)),
  `place` VARCHAR(45) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  PRIMARY KEY (`course_id`),
  CONSTRAINT `exam_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`studyCourse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`studyCourse` (
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `score` INT NULL,
  PRIMARY KEY (`course_id`, `student_id`),
  INDEX `student_idx` (`student_id` ASC),
  CONSTRAINT `course_student`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `student_course`
    FOREIGN KEY (`student_id`)
    REFERENCES `school`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`notice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`notice` (
  `notice_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `href` VARCHAR(45) NULL DEFAULT '#',
  PRIMARY KEY (`notice_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`selectCourse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`selectCourse` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `select_course_idx` (`course_id` ASC),
  CONSTRAINT `student_select`
    FOREIGN KEY (`student_id`)
    REFERENCES `school`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `select_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`School`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`School` (
  `current_season` FLOAT NULL DEFAULT 2014.1)
ENGINE = InnoDB;

insert into user(id,password,name,admin,teacher) values(0,'root','Root',true,true);
insert into School(current_season) values(2014.1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
