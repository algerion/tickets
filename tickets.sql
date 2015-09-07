/*
SQLyog Community v10.1 
MySQL - 5.5.34 : Database - ticket
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ticket` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ticket`;

/*Table structure for table `lista_permisos` */

DROP TABLE IF EXISTS `lista_permisos`;

CREATE TABLE `lista_permisos` (
  `id_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `permiso` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `lista_permisos` */

insert  into `lista_permisos`(`id_permiso`,`permiso`) values (1,'admin'),(2,'cobranza'),(3,'registro'),(4,'entrega');

/*Table structure for table `notas` */

DROP TABLE IF EXISTS `notas`;

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `generada` datetime DEFAULT NULL,
  PRIMARY KEY (`id_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notas` */

/*Table structure for table `notas_productos` */

DROP TABLE IF EXISTS `notas_productos`;

CREATE TABLE `notas_productos` (
  `id_nota` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_nota`,`id_producto`),
  KEY `FK_PRODUCTO` (`id_producto`),
  CONSTRAINT `FK_NOTA` FOREIGN KEY (`id_nota`) REFERENCES `notas` (`id_nota`) ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCTO` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notas_productos` */

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `id_usuario` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `permisos` */

insert  into `permisos`(`id_usuario`,`id_permiso`) values (1,3),(2,1),(2,2);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT '0.00',
  `existencias` int(11) DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `UK_COD` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`codigo`,`descripcion`,`precio`,`existencias`) values (1,'A0100','Pantalón de vestir Yale','250.00',20),(2,'FK010','Camisa de manga larga ','300.00',10),(3,'MX200','Falda uniforme escolar','150.00',8),(4,'AB122','Camisa blanca uniforme','100.00',5),(5,'XD302','Calcetas escolares','50.00',12);

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) DEFAULT NULL,
  `acceso` varchar(32) DEFAULT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id_usuario`,`usuario`,`acceso`,`nombre`) values (1,'angel','53ddd17d8993e1021cab33107ac88a5e','Angel Bravo'),(2,'quique','b16f5b53ec6076ff35169e5547e86682','Enrique Castellanos');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
