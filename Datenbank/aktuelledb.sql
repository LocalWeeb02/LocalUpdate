-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportiere Datenbank Struktur für localgaming
CREATE DATABASE IF NOT EXISTS `localgaming` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `localgaming`;

-- Exportiere Struktur von Tabelle localgaming.endgerät
CREATE TABLE IF NOT EXISTS `endgerät` (
  `Konsole_ID` bigint(20) NOT NULL,
  `K_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Konsole_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle localgaming.endgerät: ~8 rows (ungefähr)
DELETE FROM `endgerät`;
/*!40000 ALTER TABLE `endgerät` DISABLE KEYS */;
INSERT INTO `endgerät` (`Konsole_ID`, `K_Name`) VALUES
	(1, 'Playstation5'),
	(2, 'Playstation4'),
	(3, 'Playstation3'),
	(4, 'Playstation2'),
	(5, 'Playstation1'),
	(6, 'PSP'),
	(7, 'GameBoy'),
	(8, 'GameBoyColor');
/*!40000 ALTER TABLE `endgerät` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle localgaming.produkt
CREATE TABLE IF NOT EXISTS `produkt` (
  `Produkt_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `P_Name` varchar(50) NOT NULL,
  `P_Zustand` varchar(50) NOT NULL,
  `P_Preis` double NOT NULL CHECK (`P_Preis` >= '0.00'),
  `Beschreibung` varchar(1000) DEFAULT NULL,
  `Konsole_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Produkt_ID`),
  KEY `Konsole_ID` (`Konsole_ID`),
  CONSTRAINT `produkt_ibfk_1` FOREIGN KEY (`Konsole_ID`) REFERENCES `endgerät` (`Konsole_ID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle localgaming.produkt: ~7 rows (ungefähr)
DELETE FROM `produkt`;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` (`Produkt_ID`, `P_Name`, `P_Zustand`, `P_Preis`, `Beschreibung`, `Konsole_ID`) VALUES
	(1, 'TestProdukt', 'Gut', 24.99, 'Hier könnte ihre Beschreibung stehen', 1),
	(2, 'Pokemon Rot', 'Gut', 24.99, 'N', 7),
	(3, 'Demon Souls', 'Sehr Gut', 44.99, 'Gute', 1),
	(4, 'Life Is Strange 1', 'Sehr Gut', 0.01, 'was auch immer', 2),
	(5, 'Pokemon Silber', 'Sehr Gut', 49.99, 'Is ja mal meeeeega', 8),
	(6, 'Pokemon Silber', 'Sehr Gut', 49.99, 'Is ja mal meeeeega', 8),
	(7, 'Pokemon Silber', 'Sehr Gut', 49.99, 'Is ja mal meeeeega', 8),
	(8, 'Pokemon Silber', 'Sehr Gut', 49.99, 'Is ja mal meeeeega', 8);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle localgaming.warenkorb
CREATE TABLE IF NOT EXISTS `warenkorb` (
  `Cart_ID` bigint(20) NOT NULL,
  `Nutzer_ID` bigint(20) DEFAULT NULL,
  `Anzahl` bigint(20) DEFAULT NULL,
  `erstellt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Produkt_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Cart_ID`),
  KEY `FK1p` (`Produkt_ID`),
  CONSTRAINT `FK1p` FOREIGN KEY (`Produkt_ID`) REFERENCES `produkt` (`Produkt_ID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle localgaming.warenkorb: ~3 rows (ungefähr)
DELETE FROM `warenkorb`;
/*!40000 ALTER TABLE `warenkorb` DISABLE KEYS */;
INSERT INTO `warenkorb` (`Cart_ID`, `Nutzer_ID`, `Anzahl`, `erstellt`, `Produkt_ID`) VALUES
	(1, 1195209979, NULL, '2023-02-07 19:03:56', 1),
	(2, 1195209979, NULL, '2023-02-07 19:03:57', 2),
	(3, 1195209979, NULL, '2023-02-07 19:03:58', 3),
	(4, 1195209979, NULL, '2023-02-07 19:03:19', 4);
/*!40000 ALTER TABLE `warenkorb` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
