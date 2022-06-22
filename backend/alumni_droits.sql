-- MySQL Script generated by MySQL Workbench
-- Tue May 31 16:52:32 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema alumni_droits
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `alumni_droits` ;

-- -----------------------------------------------------
-- Schema alumni_droits
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alumni_droits` DEFAULT CHARACTER SET utf8 ;
USE `alumni_droits` ;

-- -----------------------------------------------------
-- Table `alumni_droits`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`user` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `role` VARCHAR(5) NOT NULL DEFAULT 'user',
  `is_valid` TINYINT NULL DEFAULT 0,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `alumni_droits`.`profession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`profession` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`profession` (
  `id` INT NOT NULL,
  `job` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `job_UNIQUE` (`job` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_droits`.`diplome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`diplome` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`diplome` (
  `id` INT NOT NULL,
  `title` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `alumni_droits`.`profile_diplome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`profile_diplome` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`profile_diplome` (
  `profile_id` INT NOT NULL,
  `diplome_id` INT NOT NULL,
  `year` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `diplome_id`),
  INDEX `fk_user_diplome_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_diplome_diplome1`
    FOREIGN KEY (`diplome_id`)
    REFERENCES `alumni_droits`.`diplome` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_diplome_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `alumni_droits`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_droits`.`profile_profession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`profile_profession` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`profile_profession` (
  `profile_id` INT NOT NULL,
  `profession_id` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `profession_id`),
  INDEX `fk_user_profession_profession1_idx` (`profession_id` ASC) VISIBLE,
  INDEX `fk_user_profession_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_profession_profession1`
    FOREIGN KEY (`profession_id`)
    REFERENCES `alumni_droits`.`profession` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_profession_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `alumni_droits`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_droits`.`master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`master` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`master` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profile_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `year` INT NOT NULL,
  `university` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_master_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_master_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `alumni_droits`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `alumni_droits`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_droits`.`profile` ;

CREATE TABLE IF NOT EXISTS `alumni_droits`.`profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `lastname` VARCHAR(80) NOT NULL,
  `firstname` VARCHAR(80) NOT NULL,
  `creation_date` DATE NOT NULL,
  `phone` VARCHAR(25) NULL,
  `emailpro` VARCHAR(80) NULL,
  `cv` VARCHAR(255) NULL,
  `profession_id` INT NOT NULL,
  `employeur` VARCHAR(255) NULL,
  `poste` VARCHAR(255) NULL,
  `bio` LONGTEXT NULL,
  `siteweb` VARCHAR(255) NULL,
  `facebook` VARCHAR(100) NULL,
  `linkedin` VARCHAR(100) NULL,
  `twitter` VARCHAR(100) NULL,
  `instagram` VARCHAR(100) NULL,
  `photo` VARCHAR(255) NULL,
  `is_private` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `user_id`, `profession_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_profile_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_profile_profession1_idx` (`profession_id1` ASC) VISIBLE,
  UNIQUE INDEX `facebook_UNIQUE` (`facebook` ASC) VISIBLE,
  UNIQUE INDEX `linkedin_UNIQUE` (`linkedin` ASC) VISIBLE,
  UNIQUE INDEX `twitter_UNIQUE` (`twitter` ASC) VISIBLE,
  UNIQUE INDEX `instagram_UNIQUE` (`instagram` ASC) VISIBLE,
  UNIQUE INDEX `photo_UNIQUE` (`photo` ASC) VISIBLE,
  UNIQUE INDEX `cv_UNIQUE` (`cv` ASC) VISIBLE,
  CONSTRAINT `fk_profile_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `alumni_droits`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_profession1`
    FOREIGN KEY (`profession_id1`)
    REFERENCES `alumni_droits`.`profession` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `alumni_droits`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (100, 'password', 'email@verif.com', 'admin', true);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (1, 'modgftdepasse', 'email2@verif.com', 'user', true);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (2, 'motdepagdsse', 'emai2@verif.com', 'user', true);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (3, 'modfgtdepasse', 'emil2@verif.com', 'user', true);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (4, 'motdergepasse', 'eail2@verif.com', 'user', true);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (5, 'motdescpasse', 'mail2@verif.com', 'user', false);
INSERT INTO `alumni_droits`.`user` (`id`, `password`, `email`, `role`, `is_valid`) VALUES (6, 'motdepsdcasse', 'emaskdnfl2@verif.com', 'user', false);

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni_droits`.`profession`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (1, 'Administrateur judiciaire');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (2, 'Avocat');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (3, 'Avocat au Conseil d&apos;Etat et à la Cour de cassation');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (4, 'Commissaire de justice');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (5, 'Etudiant');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (6, 'Fonctionnaire');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (7, 'Juriste d’entreprise');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (8, 'Magistrat');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (9, 'Notaire');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (10, 'Officier');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (11, 'Universitaire');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (12, 'Autres professions juridiques');
INSERT INTO `alumni_droits`.`profession` (`id`, `job`) VALUES (13, 'Autres professions');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni_droits`.`diplome`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`diplome` (`id`, `title`) VALUES (1, 'Diplôme du Collège de Droit');
INSERT INTO `alumni_droits`.`diplome` (`id`, `title`) VALUES (2, 'Certificat de l&apos;Ecole de Droit');
INSERT INTO `alumni_droits`.`diplome` (`id`, `title`) VALUES (3, 'Diplôme de l&apos;Ecole de Droit');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni_droits`.`profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (1, 'CHAKRI','Emilien','2022-05-31', '', 'emilien@alumni.com', 'http://dummyimage.com/165x100.png/dddddd/000000', 11, 'Université Paris Panthéon-Assas', 'A.T.E.R.', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', 'https://odnoklassniki.ru/posuere/cubilia/curae/duis/faucibus/accumsan.jpg', 'https://java.com/lacus/purus.xml', 'https://senate.gov/in/faucibus/orci/luctus/et/ultrices/posuere.aspx', 'http://bbc.co.uk/nunc/vestibulum/ante/ipsum/primis/in/faucibus.aspx', 'http://vistaprint.com/ut/nulla/sed/accumsan/felis.xml', '../src/assets/homme1.jpg', false);
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (2, 'LE PAPE-GARDEUX', 'Alexandre', '2022-05-31', '', 'alexandre@alumni.com', 'http://dummyimage.com/202x100.png/5fa2dd/ffffff', 11, 'Université Paris Panthéon-Assas', 'Doctorant contractuel', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 'http://macromedia.com/mattis/nibh/ligula/nec/sem.jpg', 'http://dot.gov/augue/luctus.png', 'https://google.ca/et/ultrices/posuere/cubilia/curae/mauris/viverra.js', 'http://zdnet.com/dapibus/at/diam/nam.aspx', 'https://ox.ac.uk/quam/nec.json', '../src/assets/homme2.jpg', false);
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (3, 'PARMENTIER', 'Sarah', '2022-05-31', '', 'sarah@alumni.com', 'http://dummyimage.com/177x100.png/ff4444/ffffff', 5, 'CNEN, DGCL, Ministère de l’Intérieur', 'Stagiaire', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 'https://phpbb.com/nulla/tempus/vivamus/in/felis/eu.xml', 'http://t-online.de/turpis/nec.html', 'https://paginegialle.it/cum/sociis/natoque/penatibus/et/magnis.jpg', 'https://g.co/dui/maecenas.png', 'http://zdnet.com/morbi.html', '../src/assets/femme2.jpg', true);
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (4, 'PETRILLO', 'Réan', '2022-05-31', '', 'rean@alumni.com', 'http://dummyimage.com/153x100.png/ff4444/ffffff', 8, 'ENM', 'Auditrice de Justice', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lore(igula. Suspendisse ornare consequat lectus.', 'http://rediff.com/nunc/viverra/dapibus.xml', 'http://sfgate.com/hac/habitasse/platea/dictumst/aliquam.aspx', 'http://oaic.gov.au/justo/aliquam.js', 'https://parallels.com/interdum/mauris.aspx', 'https://wufoo.com/vestibulum/quam/sapien/varius.jsp', '../src/assets/femme1.jpg', false);
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (5, 'PEROT', 'Pierre', '2022-05-31', '', 'pierre@alumni.com', 'http://dummyimage.com/237x100.png/dddddd/000000', 2, 'Cabinet Hoyng Rokh Monégier', 'Collaborateur', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 'null', 'https://elpais.com/convallis/duis/consequat/dui/nec/nisi.jpg', 'https://yellowpages.com/scelerisque.json', 'http://earthlink.net/vestibulum/ante/ipsum.js', 'http://4shared.com/pede/libero/quis.jpg', '../src/assets/homme3.jpg', true);
INSERT INTO `alumni_droits`.`profile` ( `user_id`, `lastname`, `firstname`, `creation_date`, `phone`, `emailpro`, `cv`, `profession_id1`, `employeur`, `poste`, `bio`, `siteweb`, `facebook`, `linkedin`, `twitter`, `instagram`, `photo`, `is_private`) VALUES (6, 'CHARRIÈRE', 'Mathilde', '2022-05-31', '', 'mathilde@alumni.com', 'http://dummyimage.com/148x100.png/5fa2dd/ffffff',11, 'Université Paris Panthéon-Assas', 'Doctorante contractuelle', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', 'http://google.es/pede.xml', 'https://clickbank.net/sem/sed/sagittis.js', 'http://sakura.ne.jp/molestie/hendrerit/at.png', 'http://google.ca/convallis/tortor/risus.jpg', 'https://foxnews.com/dui/proin/leo/odio.html', '../src/assets/femme3.jpg', false);
COMMIT;

-- -----------------------------------------------------
-- Data for table `alumni_droits`.`profile_diplome`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (1, 1, 2015);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (1, 2, 2016);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (2, 1, 2018);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (2, 3, 2020);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (3, 1, 2018);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (3, 3, 2020);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (4, 1, 2018);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (4, 2, 2019);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (4, 3, 2020);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (5, 1, 2012);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (5, 3, 2014);
INSERT INTO `alumni_droits`.`profile_diplome` (`profile_id`, `diplome_id`, `year`) VALUES (6, 1, 2015);

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni_droits`.`master`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni_droits`;
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (1, 'Master 2 DPG', 2017, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (2, 'Master 2 DPG', 2020, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (3, 'Master 2 DPE', 2020, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (3, 'Master 2 P', 2021, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (4, 'Master 2 Droit pénal et sciences pénales', 2020, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (5, 'Master 2 PLAI', 2014, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (6, 'Master 2 DPG', 2017, 'Université Paris Panthéon-Assas');
INSERT INTO `alumni_droits`.`master` (`profile_id`, `title`, `year`, `university`) VALUES (6, 'Master 2 PLAI', 2018, 'Université Paris Panthéon-Assas');

COMMIT;

