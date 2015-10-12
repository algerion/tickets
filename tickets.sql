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

insert  into `cobros`(`id_nota`,`id_cliente`,`cobrada`,`porcentaje_descuento`,`incluye_iva`,`porcentaje_iva`,`numero_vales`,`importe_vale`,`efectivo`,`cheque`,`credito`) values (1,2,'2015-10-05 17:43:06','0.00',1,'16.00',2,'194.98','500.00','100.00','378.84'),(2,3,'2015-10-06 14:12:13','0.00',0,'16.00',0,'194.98','5000.00','0.00','23170.00'),(3,3,'2015-10-06 14:43:01','0.00',0,'16.00',0,'194.98','0.00','0.00','17150.00');

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

/*Table structure for table `grupos` */

DROP TABLE IF EXISTS `grupos`;

CREATE TABLE `grupos` (
  `id_grupo` int(11) NOT NULL AUTO_INCREMENT,
  `grupo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `grupos` */

insert  into `grupos`(`id_grupo`,`grupo`) values (1,'JGO. DE PANTS EN SPORTOCK Y MICROFIBRA'),(2,'JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS)'),(3,'JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS)'),(4,'SOLO PANTS EN FELPA'),(5,'SOLO CHAMARRA CON BORDADO'),(6,'PLAYERA POLO CON BORDADO'),(7,'PLAYERA POLO CON IMPRESIÓN'),(8,'SHORT / FELPA'),(9,'SHORT / MICROFIBRA'),(10,'BLUSA MANGA CORTA'),(11,'CAMISA M/CORTA'),(12,'BLUSA MANGA LARGA CON PIE DE CUELLO'),(13,'BLUSA MANGA LARGA CUELLO SPORT'),(14,'SUETER CUELLO \"V\"'),(15,'SUETER C/BOTONES'),(16,'CHALECO ESCOLAR'),(17,'CAMISA M/LARGA'),(18,'PLAYERA COBAO'),(19,'FALDA COBAO'),(20,'PANTALÓN COBAO'),(21,'SUDADERA COBAO'),(22,'PLAYERA IEBO'),(23,'FALDA IEBO'),(24,'PANTS IEBO'),(25,'CHAMARRA IEBO'),(26,'PLAYERA D. IEBO'),(27,'SUDADERA IEBO'),(28,'FALDA DE GALES'),(29,'FALDA EN TERGAL O ESCOCÉS'),(30,'FALDA XALOSTOC'),(31,'PANTALÓN EN SUPER CASMIR'),(32,'PANTALÓN EN TELA GALES'),(33,'PANTALÓN EN TERGAL'),(34,'PANTALÓN DE LA FED. MCA: GACELA'),(35,'JUMPER DE XALOSTOC'),(36,'JUMPER EN ESCOCÉS'),(37,'JUMPER DE LA FEDERAL');

/*Table structure for table `movimientos` */

DROP TABLE IF EXISTS `movimientos`;

CREATE TABLE `movimientos` (
  `id_movimiento` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `importe` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `movimientos` */

insert  into `movimientos`(`id_movimiento`,`fecha`,`importe`) values (1,'2015-10-05 17:41:25','15000.00'),(2,'2015-10-05 17:41:43','-200.00'),(3,'2015-10-06 14:11:12','18900.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `notas` */

insert  into `notas`(`id_nota`,`vales`,`descuento`,`generada`,`id_vendedor`,`id_status`) values (1,2,0,'2015-09-17 12:35:11',3,2),(2,0,0,'2015-10-06 14:07:55',3,2),(3,0,0,'2015-10-06 14:09:04',1,2);

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

insert  into `notas_productos`(`id_nota`,`id_producto`,`cantidad`,`precio`) values (1,2,2,'395.00'),(1,18,1,'200.00'),(1,21,2,'95.00'),(2,5,30,'314.00'),(2,11,30,'365.00'),(2,14,30,'165.00'),(2,21,30,'95.00'),(3,11,20,'365.00'),(3,15,30,'183.00'),(3,19,20,'218.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pagares` */

insert  into `pagares`(`id_pagare`,`id_nota`,`lugarfirma`,`fecha`,`cobrador`,`lugarcobro`,`interes`,`deudor`) values (1,2,'Oaxaca de Juárez, Oax.','2015-10-06','Rocío García Ramírez','Oaxaca de Juárez, Oax.','7.00','Tercer Comprador Añadido'),(4,3,'Oaxaca de Juárez, Oax.','2015-10-06','Rocío García Ramírez','Oaxaca de Juárez, Oax.','7.00','Tercer Comprador Añadido');

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
  `id_grupo` int(11) DEFAULT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT '0.00',
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `UK_COD` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`id_grupo`,`codigo`,`descripcion`,`precio`,`activo`) values (1,1,'ST6','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 6-10','350.00',1),(2,1,'ST12','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 12-16','395.00',1),(3,1,'ST34','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 34-40','430.00',1),(4,2,'PB6','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 6-8','284.00',1),(5,2,'PB10','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 10-12','314.00',1),(6,2,'PB14','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 14-16','345.00',1),(7,2,'PB34','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 34-40','380.00',1),(8,3,'PI6','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 6-8','269.00',1),(9,3,'PI10','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 10-12','299.00',1),(10,3,'PI14','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 14-16','330.00',1),(11,3,'PI34','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 34-40','365.00',1),(12,4,'PF6','SOLO PANTS EN FELPA TALLAS 6-8','135.00',1),(13,4,'PF10','SOLO PANTS EN FELPA TALLAS 10-12','150.00',1),(14,4,'PF14','SOLO PANTS EN FELPA TALLAS 14-16','165.00',1),(15,4,'PF34','SOLO PANTS EN FELPA TALLAS 34-40','183.00',1),(16,5,'CHB6','SOLO CHAMARRA CON BORDADO TALLAS 6-8','170.00',1),(17,5,'CHB10','SOLO CHAMARRA CON BORDADO TALLAS 10-12','184.00',1),(18,5,'CHB14','SOLO CHAMARRA CON BORDADO TALLAS 14-16','200.00',1),(19,5,'CHB34','SOLO CHAMARRA CON BORDADO TALLAS 34-40','218.00',1),(20,6,'PLB4y','PLAYERA POLO CON BORDADO TALLAS 4-10','89.00',1),(21,6,'PLB12','PLAYERA POLO CON BORDADO TALLAS 12-18','95.00',1),(22,6,'PLB34','PLAYERA POLO CON BORDADO TALLAS 34-40','115.00',1),(23,7,'PLI4','PLAYERA POLO CON IMPRESIÓN TALLAS 4-10','75.00',1),(24,7,'PLI12','PLAYERA POLO CON IMPRESIÓN TALLAS 12-18','85.00',1),(25,7,'PLI34','PLAYERA POLO CON IMPRESIÓN TALLAS 34-40','105.00',1),(26,8,'SHF6','SHORT / FELPA TALLAS 6 - 16','75.00',1),(27,8,'SHF34','SHORT / FELPA TALLAS 34-40','85.00',1),(28,9,'SHMF6','SHORT / MICROFIBRA TALLAS 6-16','85.00',1),(29,9,'SHMF34','SHORT / MICROFIBRA TALLAS 34-40','95.00',1),(30,10,'BMC6','BLUSA MANGA CORTA TALLAS 6-10','69.00',1),(31,10,'BMC12','BLUSA MANGA CORTA TALLAS 12-16','75.00',1),(32,10,'BMC34','BLUSA MANGA CORTA TALLAS 34-36','85.00',1),(33,11,'CMC6','CAMISA M/CORTA TALLAS 6-8','79.00',1),(34,11,'CMC12','CAMISA M/CORTA TALLAS 10-12','89.00',1),(35,11,'CMC14','CAMISA M/CORTA TALLAS 14-16','95.00',1),(36,11,'CMC28','CAMISA M/CORTA TALLAS 28-36','125.00',1),(37,12,'BMLP6','BLUSA MANGA LARGA CON PIE DE CUELLO TALLAS 6-16','125.00',1),(38,12,'BMLP34','BLUSA MANGA LARGA CON PIE DE CUELLO TALLAS 34-36','145.00',1),(39,13,'BMLS6','BLUSA MANGA LARGA CUELLO SPORT TALLAS 6-16','95.00',1),(40,13,'BMLS34','BLUSA MANGA LARGA CUELLO SPORT TALLAS 34-36','115.00',1),(41,14,'SCV6','SUETER CUELLO \"V\" TALLAS 6-8','99.00',1),(42,14,'SCV10','SUETER CUELLO \"V\" TALLAS 10-16','115.00',1),(43,14,'SCV34','SUETER CUELLO \"V\" TALLAS 34-42','145.00',1),(44,15,'SCB6','SUETER C/BOTONES TALLAS 6-8','105.00',1),(45,15,'SCB10','SUETER C/BOTONES TALLAS 10-16','119.00',1),(46,15,'SCB34','SUETER C/BOTONES TALLAS 34-42','149.00',1),(47,16,'CHE6','CHALECO ESCOLAR TALLAS 6-8','85.00',1),(48,16,'CHE10','CHALECO ESCOLAR TALLAS 10-16','95.00',1),(49,16,'CHE34','CHALECO ESCOLAR TALLAS 34-42','125.00',1),(50,17,'CML6','CAMISA M/LARGA TALLAS 6-8','99.00',1),(51,17,'CML10','CAMISA M/LARGA TALLAS 10-12','115.00',1),(52,17,'CML14','CAMISA M/LARGA TALLAS 14-16','135.00',1),(53,17,'CML28','CAMISA M/LARGA TALLAS 28-36','155.00',1),(54,17,'CML38','CAMISA M/LARGA TALLAS 38-42','175.00',1),(55,18,'CBP','PLAYERA COBAO','149.00',1),(56,19,'CBF','FALDA COBAO','169.00',1),(57,20,'CBPA','PANTALÓN COBAO','169.00',1),(58,21,'CBS','SUDADERA COBAO','240.00',1),(59,22,'IEPL','PLAYERA IEBO','129.00',1),(60,23,'IEFA','FALDA IEBO','169.00',1),(61,24,'IEPA','PANTS IEBO','399.00',1),(62,25,'IECH','CHAMARRA IEBO','399.00',1),(63,26,'IEPD','PLAYERA D. IEBO','99.00',1),(64,27,'IESD','SUDADERA IEBO','220.00',1),(65,28,'FG6','FALDA DE GALES TALLAS 6-8','109.00',1),(66,28,'FG10','FALDA DE GALES TALLAS 10-12','115.00',1),(67,28,'FG14','FALDA DE GALES TALLAS 14-16','125.00',1),(68,28,'FG28','FALDA DE GALES TALLAS 28-36','135.00',1),(69,28,'FG38','FALDA DE GALES TALLAS 38-40','155.00',1),(70,29,'FTE6','FALDA EN TERGAL O ESCOCÉS TALLAS 6-8','125.00',1),(71,29,'FTE10','FALDA EN TERGAL O ESCOCÉS TALLAS 10-12','129.00',1),(72,29,'FTE14','FALDA EN TERGAL O ESCOCÉS TALLAS 14-16','149.00',1),(73,29,'FTE28','FALDA EN TERGAL O ESCOCÉS TALLAS 28-36','159.00',1),(74,29,'FTE38','FALDA EN TERGAL O ESCOCÉS TALLAS 38-42','189.00',1),(75,30,'FX6','FALDA XALOSTOC TALLAS 6-8','155.00',1),(76,30,'FX10','FALDA XALOSTOC TALLAS 10-12','175.00',1),(77,30,'FX14','FALDA XALOSTOC TALLAS 14-16','195.00',1),(78,30,'FX28','FALDA XALOSTOC TALLAS 28-34','215.00',1),(79,31,'PSC6','PANTALÓN EN SUPER CASMIR TALLAS 6-8','112.00',1),(80,31,'PSC10','PANTALÓN EN SUPER CASMIR TALLAS 10-12','122.00',1),(81,31,'PSC14','PANTALÓN EN SUPER CASMIR TALLAS 14-16','127.00',1),(82,31,'PSC28','PANTALÓN EN SUPER CASMIR TALLAS 28-36','138.00',1),(83,31,'PSC38','PANTALÓN EN SUPER CASMIR TALLAS 38-40','168.00',1),(84,32,'PTG6','PANTALÓN EN TELA GALES TALLAS 6-8','112.00',1),(85,32,'PTG10','PANTALÓN EN TELA GALES TALLAS 10-12','122.00',1),(86,32,'PTG14','PANTALÓN EN TELA GALES TALLAS 14-16','127.00',1),(87,32,'PTG28','PANTALÓN EN TELA GALES TALLAS 28-36','138.00',1),(88,32,'PTG38','PANTALÓN EN TELA GALES TALLAS 38-42','168.00',1),(89,33,'PTE6','PANTALÓN EN TERGAL TALLAS 6-8','125.00',1),(90,33,'PTE10','PANTALÓN EN TERGAL TALLAS 10-12','129.00',1),(91,33,'PTE14','PANTALÓN EN TERGAL TALLAS 14-16','149.00',1),(92,33,'PTE28','PANTALÓN EN TERGAL TALLAS 28-36','159.00',1),(93,33,'PTE38','PANTALÓN EN TERGAL TALLAS 38-42','195.00',1),(94,34,'PFG14','PANTALÓN DE LA FED. MCA: GACELA TALLAS 14-16','215.00',1),(95,34,'PFG28','PANTALÓN DE LA FED. MCA: GACELA TALLAS 28-36','225.00',1),(96,34,'PFG38','PANTALÓN DE LA FED. MCA: GACELA TALLAS 38-40','275.00',1),(97,35,'JX6','JUMPER DE XALOSTOC TALLAS 6-8','210.00',1),(98,35,'JX10','JUMPER DE XALOSTOC TALLAS 10-12','225.00',1),(99,35,'JX14','JUMPER DE XALOSTOC TALLAS 14-16','249.00',1),(100,35,'JX28','JUMPER DE XALOSTOC TALLAS 28-36','279.00',1),(101,36,'JE6','JUMPER EN ESCOCÉS TALLAS 6-8','185.00',1),(102,36,'JE10','JUMPER EN ESCOCÉS TALLAS 10-12','195.00',1),(103,36,'JE14','JUMPER EN ESCOCÉS TALLAS 14-16','225.00',1),(104,36,'JE28','JUMPER EN ESCOCÉS TALLAS 28-36','245.00',1),(105,37,'JF14','JUMPER DE LA FEDERAL TALLAS 14-16','149.00',1),(106,37,'JF34','JUMPER DE LA FEDERAL TALLAS 34-36','159.00',1);

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
