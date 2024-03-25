-- MySQL Script generated by MySQL Workbench
-- Mon Dec 18 22:09:17 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MicroIS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS MicroIS;

-- -----------------------------------------------------
-- Schema MicroIS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS MicroIS DEFAULT CHARACTER SET utf8;
USE MicroIS;

-- -----------------------------------------------------
-- Table OrdersAndDeliveries
-- -----------------------------------------------------
DROP TABLE IF EXISTS OrdersAndDeliveries;

CREATE TABLE IF NOT EXISTS OrdersAndDeliveries
(
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    details    VARCHAR(45)  NULL,
    status     VARCHAR(45)  NOT NULL,
    customerId INT UNSIGNED NOT NULL,
    productID  INT UNSIGNED NOT NULL,
    amount     INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT productKey
        FOREIGN KEY (productID)
            REFERENCES products (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT customerKey
        FOREIGN KEY (customerId)
            REFERENCES customers (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

CREATE INDEX productKey_idx ON OrdersAndDeliveries (productID ASC) VISIBLE;

CREATE INDEX customerKey_idx ON OrdersAndDeliveries (customerId ASC) VISIBLE;


-- -----------------------------------------------------
-- Table customers
-- -----------------------------------------------------
DROP TABLE IF EXISTS customers;

CREATE TABLE IF NOT EXISTS customers
(
    id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name      VARCHAR(45)  NOT NULL,
    address   VARCHAR(45)  NULL,
    telephone VARCHAR(45)  NULL,
    PRIMARY KEY (id)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table process
-- -----------------------------------------------------
DROP TABLE IF EXISTS process;

CREATE TABLE IF NOT EXISTS process
(
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name        VARCHAR(45)  NOT NULL,
    description TEXT         NULL,
    techOptions VARCHAR(100) NULL,
    techProcess INT          NULL,
    PRIMARY KEY (id)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table product_process_link
-- -----------------------------------------------------
DROP TABLE IF EXISTS productProcessLink;

CREATE TABLE IF NOT EXISTS productProcessLink
(
    productId INT UNSIGNED NOT NULL,
    processId INT UNSIGNED NOT NULL,
    CONSTRAINT productsKey
        FOREIGN KEY (productId)
            REFERENCES products (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT processKey
        FOREIGN KEY (processId)
            REFERENCES process (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

CREATE UNIQUE INDEX productProcess ON productProcessLink (productId ASC, processId ASC) VISIBLE;

CREATE INDEX processKey_idx ON productProcessLink (processId ASC) VISIBLE;


-- -----------------------------------------------------
-- Table products
-- -----------------------------------------------------
DROP TABLE IF EXISTS products;

CREATE TABLE IF NOT EXISTS products
(
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    model       VARCHAR(45)  NULL,
    ram         INT          NULL,
    description TEXT         NULL,
    price       FLOAT        NULL,
    PRIMARY KEY (id)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table staff
-- -----------------------------------------------------
DROP TABLE IF EXISTS staff;

CREATE TABLE IF NOT EXISTS staff
(
    id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(45)  NOT NULL,
    lastName  VARCHAR(45)  NOT NULL,
    age       VARCHAR(45)  NULL,
    post      VARCHAR(45)  NOT NULL,
    PRIMARY KEY (id)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table staffProcessLink
-- -----------------------------------------------------
DROP TABLE IF EXISTS staffProcessLink;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS staffProcessLink
(
    staffId   INT UNSIGNED NOT NULL,
    processId INT UNSIGNED NOT NULL,
    CONSTRAINT staffKey
        FOREIGN KEY (staffId)
            REFERENCES staff (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT processStaffKey
        FOREIGN KEY (processId)
            REFERENCES process (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

CREATE UNIQUE INDEX staffProcess ON staffProcessLink (staffId ASC, processId ASC) VISIBLE;

CREATE INDEX processKey_idx ON staffProcessLink (processId ASC) VISIBLE;

-- -----------------------------------------------------
-- Table storage
-- -----------------------------------------------------
DROP TABLE IF EXISTS storage;

CREATE TABLE IF NOT EXISTS storage
(
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    productID       INT UNSIGNED NOT NULL,
    remains         INT          NOT NULL,
    dateReceive     DATETIME     NULL,
    datePublication DATE         NULL,
    PRIMARY KEY (id),
    CONSTRAINT productStorageKey
        FOREIGN KEY (productID)
            REFERENCES products (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

CREATE INDEX productStorageKey_idx ON storage (productID ASC) VISIBLE;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

INSERT INTO process (name, description, techOptions, techProcess)
VALUES ('HCMOS8D CMOS 0.18 µm 200',
        'Высокопроизводительные универсальные микроконтроллеры и микропроцессоры;СБИС памяти, ГЛОНАСС навигация и СБИС цифрового телевидения;Высокопроизводительные АЦП / ЦАП и т.д.;Новая область применения',
        'HIPO, MIM, OTP', 265),
       ('HCMOSF8 CMOS + EEPROM 0.18 µm',
        'RFID чипы (транспортные билеты, и т.д.);ИС для смарт-карт (идентификационные документы);Микроконтроллеры и специализированные СБИС с низким энергопотреблением;',
        'EEPROM', 150),
       ('HCMOS10_LP CMOS 90 nm',
        'Высокопроизводительные универсальные микроконтроллеры и микропроцессоры;СБИС памяти, ГЛОНАСС навигация и СБИС цифрового телевидения;ИС с для промышленного применения и т.д.',
        'MIM', 90),
       ('HCMOS065_LP 65 nm', 'Микропроцессоры и микроконтроллеры', null, 65);

INSERT INTO products (name, model, ram, description, price)
VALUES ('Микроконтроллеры для банковских карт - Дуальный (контактный ISO 7816, бесконтактный ISO 1443A/B)',
        'MIK51BC16D', 256, null, 5000),
       ('Микроконтроллеры для банковских карт - Дуальный (контактный ISO 7816, бесконтактный ISO 1443A/B)',
        'MIK51SC72D', 384, null, 7375.5),
       ('Микроконтроллеры для идентификационных документов - Бесконтактный (ISO 14443В)', 'MIK51AB72D', 6, null, 9000),
       ('Микроконтроллеры для идентификационных документов - Дуальный (контактный ISO 7816, бесконтактный ISO 14443A/B)',
        'MIK51SC72D', 8, null, 11745.99),
       ('Микроконтроллеры для СКЗИ (карты и USB-токены) - Дуальный (контактный ISO 7816, бесконтактный ISO 1443A/B)',
        'MIK51SC72D', 8, null, 3045),
       ('RISC-V микроконтроллер MIK32 АМУР', 'MIK32', 16,
        'MIK32 АМУР - первый полностью отечественный микроконтроллер с ядром на открытой архитектуре RISC-V – предназначен для устройств промышленной автоматизации и интернета вещей, беспроводной периферии, интеллектуальных сетей, охранных систем, сигнализации, телеметрии, мониторинга, умного дома и управления климатом, освещением и других инфраструктурных систем.',
        17899);

INSERT INTO productProcessLink (productId, processId)
VALUES (1, 2),
       (2, 2),
       (3, 2),
       (4, 1),
       (5, 3),
       (6, 4);

INSERT INTO staff (firstName, lastName, age, post)
VALUES ('Иван', 'Попов', 32, 'Инженер по качеству'),
       ('Григорий', 'Исупов', 20, 'Инженер-технолог'),
       ('Алесксандр', 'Романов', 45, 'Оператор в цех по производству микросхем'),
       ('Даниил', 'Кузьмин', 33, 'Испытатель деталей и приборов'),
       ('Гаврилова', 'Татьяна', 33, 'Диспетчер'),
       ('Светлана', 'Морозова', 38, 'Диспетчер'),
       ('София', 'Гаврилова', 27, 'Инженер-схемотехник');

INSERT INTO staffProcessLink (staffId, processId)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (2, 4),
       (2, 3),
       (3, 4),
       (4, 1),
       (4, 2),
       (5, 1),
       (5, 2),
       (5, 3),
       (6, 3),
       (6, 4),
       (7, 2),
       (7, 4);

INSERT INTO storage (productID, remains, dateReceive, datePublication)
VALUES (6, 654, '2022-03-05 18:00:00', '2022-02-25'),
       (4, 323, '2021-12-03 17:00:00', '2021-11-26'),
       (1, 57, '2021-11-08 17:00:00', '2021-10-27'),
       (2, 91, '2021-10-29 17:00:00', '2021-10-15');

INSERT INTO customers (name, address, telephone)
VALUES ('Samsung Group', 'Korea', null),
       ('STMicroelectronics', 'Schweiz, Geneva', null),
       ('ООО «ДНС Ритейл»', 'Владивосток', '8 800 775-56-87'),
       ('ПАО «Сбербанк»', 'Москва', null);

INSERT INTO ordersAndDeliveries (details, status, customerId, productID, amount)
VALUES ('Аванс 25%', 'В процессе', 3, 4, 50),
       ('Предоплата 70%', 'Ожидается оплата', 4, 2, 1267),
       (null, 'Заврешенно', 1, 4, 5000);
