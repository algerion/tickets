/*
SQLyog Community v12.12 (32 bit)
MySQL - 5.6.24 : Database - ticket
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

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `poblacion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `clientes` */

insert  into `clientes`(`id_cliente`,`nombre`,`direccion`,`telefono`,`poblacion`) values (1,'Cliente Número Uno',NULL,NULL,NULL),(2,'Otro Nuevo Consumidor',NULL,NULL,NULL),(3,'Tercer Comprador Añadido',NULL,NULL,NULL);

/*Table structure for table `cobros` */

DROP TABLE IF EXISTS `cobros`;

CREATE TABLE `cobros` (
  `id_nota` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `cobrada` datetime DEFAULT NULL,
  `porcentaje_descuento` decimal(5,2) DEFAULT NULL,
  `incluye_iva` tinyint(1) DEFAULT NULL,
  `porcentaje_iva` decimal(10,2) DEFAULT NULL,
  `numero_vales` int(11) DEFAULT NULL,
  `importe_vale` decimal(10,2) DEFAULT NULL,
  `efectivo` decimal(18,2) DEFAULT NULL,
  `cheque` decimal(18,2) DEFAULT NULL,
  `credito` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cobros` */

insert  into `cobros`(`id_nota`,`id_cliente`,`cobrada`,`porcentaje_descuento`,`incluye_iva`,`porcentaje_iva`,`numero_vales`,`importe_vale`,`efectivo`,`cheque`,`credito`) values (1,2,'2015-10-05 17:43:06','0.00',1,'16.00',2,'194.98','500.00','100.00','378.84');

/*Table structure for table `depositos` */

DROP TABLE IF EXISTS `depositos`;

CREATE TABLE `depositos` (
  `id_deposito` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `cantidad` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_deposito`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `depositos` */

insert  into `depositos`(`id_deposito`,`id_cliente`,`fecha`,`cantidad`) values (1,3,'2015-10-05 00:00:00','200000.00');

/*Table structure for table `movimientos` */

DROP TABLE IF EXISTS `movimientos`;

CREATE TABLE `movimientos` (
  `id_movimiento` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `importe` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `movimientos` */

insert  into `movimientos`(`id_movimiento`,`fecha`,`importe`) values (1,'2015-10-05 17:41:25','15000.00'),(2,'2015-10-05 17:41:43','-200.00');

/*Table structure for table `notas` */

DROP TABLE IF EXISTS `notas`;

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `vales` int(11) DEFAULT NULL,
  `descuento` int(11) DEFAULT NULL,
  `generada` datetime DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_status` int(11) DEFAULT '1',
  PRIMARY KEY (`id_nota`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `notas` */

insert  into `notas`(`id_nota`,`vales`,`descuento`,`generada`,`id_vendedor`,`id_status`) values (1,2,0,'2015-09-17 12:35:11',3,2);

/*Table structure for table `notas_productos` */

DROP TABLE IF EXISTS `notas_productos`;

CREATE TABLE `notas_productos` (
  `id_nota` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_nota`,`id_producto`),
  KEY `FK_PRODUCTO` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notas_productos` */

insert  into `notas_productos`(`id_nota`,`id_producto`,`cantidad`,`precio`) values (1,2,2,'395.00'),(1,18,1,'200.00'),(1,21,2,'95.00');

/*Table structure for table `pagares` */

DROP TABLE IF EXISTS `pagares`;

CREATE TABLE `pagares` (
  `id_pagare` int(11) NOT NULL AUTO_INCREMENT,
  `id_nota` int(11) DEFAULT NULL,
  `lugarfirma` varchar(200) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `cobrador` varchar(200) DEFAULT NULL,
  `lugarcobro` varchar(200) DEFAULT NULL,
  `interes` decimal(8,2) DEFAULT NULL,
  `deudor` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_pagare`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pagares` */

/*Table structure for table `parametros` */

DROP TABLE IF EXISTS `parametros`;

CREATE TABLE `parametros` (
  `llave` varchar(20) NOT NULL,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`llave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `parametros` */

insert  into `parametros`(`llave`,`valor`) values ('adeudomax','-50000'),('cobrador','Rocío García Ramírez'),('correofact','angel.bravo@outlook.com'),('correorept','algerion1@hotmail.com'),('interes','7'),('iva','16'),('lugar','Oaxaca de Juárez, Oax.'),('revolvente','18900'),('vale','194.98');

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `permiso` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `permisos` */

insert  into `permisos`(`id_permiso`,`permiso`) values (1,'admin'),(2,'registro'),(3,'cobranza'),(4,'entrega'),(5,'productos'),(6,'creditos');

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT '0.00',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `UK_COD` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`codigo`,`descripcion`,`precio`) values (1,'SPORTOCK6','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 6-10','350.00'),(2,'SPORTOCK12','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 12-16','395.00'),(3,'SPORTOCK34','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 34-40','430.00'),(4,'PANTSBORDADOS6','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 6-8','284.00'),(5,'PANTSBORDADOS10','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 10-12','314.00'),(6,'PANTSBORDADOS14','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 14-16','345.00'),(7,'PANTSBORDADOS34','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 34-40','380.00'),(8,'PANTSIMPRESOS6','JGO. DE PANTS CON IMPRESIÃ“N (CHAMARRA Y PANTS) TALLAS 6-8','269.00'),(9,'PANTSIMPRESOS10','JUEGO DE PANTS CON IMPRESIÃ“N (CHAMARRA Y PANTS) TALLAS 10-12','299.00'),(10,'PANTSIMPRESOS14','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 14-16','330.00'),(11,'PANTSIMPRESOS34','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 34-40','365.00'),(12,'PANTSFELPA6','SOLO PANTS EN FELPA','135.00'),(13,'PANTSFELPA10','SOLO PANTS EN FELPA TALLAS 10-12','150.00'),(14,'PANTSFELPA14','SOLO PANTS EN FELPA TALLAS 14-16','165.00'),(15,'PANTSFELPA34','SOLO PANTS EN FELPA TALLAS 34-40','183.00'),(16,'CHAMBORDADO6','SOLO CHAMARRA CON BORDADO TALLAS 6-8','170.00'),(17,'CHAMBORDADO10','SOLO CHAMARRA CON BORDADO TALLAS 10-12','184.00'),(18,'CHAMBORDADO14','SOLO CHAMARRA CON BORDADO TALLAS 14-16','200.00'),(19,'CHAMBORDADO34','SOLO CHAMARRA CON BORDADO TALLAS 34-40','218.00'),(20,'POLOBORDADA4','PLAYERA POLO CON BORDADO TALLAS 4-10','89.00'),(21,'POLOBORDADA12','PLAYERA POLO CON BORDADO TALLAS 12-18','95.00'),(22,'POLOBORDADA34','PLAYERA POLO CON BORDADO TALLAS 34-40','115.00'),(23,'POLOIMPRESA4','PLAYERA POLO CON IMPRESIÓN TALLAS 4-10','75.00'),(24,'POLOIMPRESA12','PLAYERA POLO CON IMPRESIÓN TALLAS 12-18','85.00'),(25,'POLOIMPRESA34','PLAYERA POLO CON IMPRESIÓN TALLAS 34-40','105.00'),(26,'SHORTFELPA6','SHORT / FELPA TALLAS 6 - 16','75.00'),(27,'SHORTFELPA34','SHORT / FELPA TALLAS 34-40','85.00'),(28,'SHORTMFIBRA6','SHORT / MICROFIBRA TALLAS 6-16','85.00'),(29,'SHORTMFIBRA34','SHORT / MICROFIBRA TALLAS 34-40','95.00'),(31,'BLUSAMCORTA6','BLUSA MANGA CORTA TALLAS 6-10','69.00'),(32,'BLUSAMCORTA12','BLUSA MANGA CORTA TALLAS 12-16','75.00'),(33,'BLUSAMCORTA34','BLUSA MANGA CORTA TALLAS 34-36','85.00');

/*Table structure for table `status_nota` */

DROP TABLE IF EXISTS `status_nota`;

CREATE TABLE `status_nota` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `status_nota` */

insert  into `status_nota`(`id_status`,`status`) values (1,'Adeudo'),(2,'Pagado'),(3,'Entregado'),(4,'Cancelado');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) DEFAULT NULL,
  `acceso` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id_usuario`,`usuario`,`acceso`) values (1,'admin','73acd9a5972130b75066c82595a1fae3'),(2,'ventas','260ebbae64c0831bbe4c52c123393863'),(3,'caja','335f07edf0462e587f5ea48957ba5f9a'),(4,'entrega','6ef994ecaf30d09a99f685b76fbdf768'),(5,'productos','da84da189a0e6155089ecdf45b58f83e'),(6,'creditos','ba776dacd10ac784b9b0d7377baf4353');

/*Table structure for table `usuarios_permisos` */

DROP TABLE IF EXISTS `usuarios_permisos`;

CREATE TABLE `usuarios_permisos` (
  `id_usuario` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usuarios_permisos` */

insert  into `usuarios_permisos`(`id_usuario`,`id_permiso`) values (1,3),(1,5),(1,6),(2,2),(3,3),(6,6);

/*Table structure for table `vendedores` */

DROP TABLE IF EXISTS `vendedores`;

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) DEFAULT NULL,
  `activo` varchar(1) DEFAULT '1',
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `vendedores` */

insert  into `vendedores`(`id_vendedor`,`nombre`,`activo`) values (1,'Enrique Castellanos Rodriguez','1'),(2,'Berenice Cruz Robles','1'),(3,'Angel Augusto Bravo Sumano','1'),(4,'Alfonso Sandoval Carballido','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
