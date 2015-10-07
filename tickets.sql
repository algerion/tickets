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
  `codigo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT '0.00',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `UK_COD` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`codigo`,`descripcion`,`precio`) values (1,'ST6','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 6-10','350.00'),(2,'ST12','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 12-16','395.00'),(3,'ST34','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 34-40','430.00'),(4,'PB6','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 6-8','284.00'),(5,'PB10','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 10-12','314.00'),(6,'PB14','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 14-16','345.00'),(7,'PB34','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 34-40','380.00'),(8,'PI6','JGO. DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 6-8','269.00'),(9,'PI10','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 10-12','299.00'),(10,'PI14','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 14-16','330.00'),(11,'PI34','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 34-40','365.00'),(12,'PF6','SOLO PANTS EN FELPA TALLAS 6-8','135.00'),(13,'PF10','SOLO PANTS EN FELPA TALLAS 10-12','150.00'),(14,'PF14','SOLO PANTS EN FELPA TALLAS 14-16','165.00'),(15,'PF34','SOLO PANTS EN FELPA TALLAS 34-40','183.00'),(16,'CHB6','SOLO CHAMARRA CON BORDADO TALLAS 6-8','170.00'),(17,'CHB10','SOLO CHAMARRA CON BORDADO TALLAS 10-12','184.00'),(18,'CHB14','SOLO CHAMARRA CON BORDADO TALLAS 14-16','200.00'),(19,'CHB34','SOLO CHAMARRA CON BORDADO TALLAS 34-40','218.00'),(20,'PLB4','PLAYERA POLO CON BORDADO TALLAS 4-10','89.00'),(21,'PLB12','PLAYERA POLO CON BORDADO TALLAS 12-18','95.00'),(22,'PLB34','PLAYERA POLO CON BORDADO TALLAS 34-40','115.00'),(23,'PLI4','PLAYERA POLO CON IMPRESIÓN TALLAS 4-10','75.00'),(24,'PLI12','PLAYERA POLO CON IMPRESIÓN TALLAS 12-18','85.00'),(25,'PLI34','PLAYERA POLO CON IMPRESIÓN TALLAS 34-40','105.00'),(26,'SHF6','SHORT / FELPA TALLAS 6 - 16','75.00'),(27,'SHF34','SHORT / FELPA TALLAS 34-40','85.00'),(28,'SHMF6','SHORT / MICROFIBRA TALLAS 6-16','85.00'),(29,'SHMF34','SHORT / MICROFIBRA TALLAS 34-40','95.00'),(30,'BMC6','BLUSA MANGA CORTA TALLAS 6-10','69.00'),(31,'BMC12','BLUSA MANGA CORTA TALLAS 12-16','75.00'),(32,'BMC34','BLUSA MANGA CORTA TALLAS 34-36','85.00'),(33,'CMC6','CAMISA M/CORTA TALLAS 6-8','79.00'),(34,'CMC12','CAMISA M/CORTA TALLAS 10-12','89.00'),(35,'CMC14','CAMISA M/CORTA TALLAS 14-16','95.00'),(36,'CMC28','CAMISA M/CORTA TALLAS 28-36','125.00'),(37,'BMLP6','BLUSA MANGA LARGA CON PIE DE CUELLO TALLAS 6-16','125.00'),(38,'BMLP34','BLUSA MANGA LARGA CON PIE DE CUELLO TALLAS 34-36','145.00'),(39,'BMLS6','BLUSA MANGA LARGA CUELLO SPORT TALLAS 6-16','95.00'),(40,'BMLS34','BLUSA MANGA LARGA CUELLO SPORT TALLAS 34-36','115.00'),(41,'SCV6','SUETER CUELLO \"V\" TALLAS 6-8','99.00'),(42,'SCV10','SUETER CUELLO \"V\" TALLAS 10-16','115.00'),(43,'SCV34','SUETER CUELLO \"V\" TALLAS 34-42','145.00'),(44,'SCB6','SUETER C/BOTONES TALLAS 6-8','105.00'),(45,'SCB10','SUETER C/BOTONES TALLAS 10-16','119.00'),(46,'SCB34','SUETER C/BOTONES TALLAS 34-42','149.00'),(47,'CHE6','CHALECO ESCOLAR TALLAS 6-8','85.00'),(48,'CHE10','CHALECO ESCOLAR TALLAS 10-16','95.00'),(49,'CHE34','CHALECO ESCOLAR TALLAS 34-42','125.00'),(50,'CML6','CAMISA M/LARGA TALLAS 6-8','99.00'),(51,'CML10','CAMISA M/LARGA TALLAS 10-12','115.00'),(52,'CML14','CAMISA M/LARGA TALLAS 14-16','135.00'),(53,'CML28','CAMISA M/LARGA TALLAS 28-36','155.00'),(54,'CML38','CAMISA M/LARGA TALLAS 38-42','175.00'),(55,'CBP','PLAYERA COBAO','149.00'),(56,'CBF','FALDA COBAO','169.00'),(57,'CBPA','PANTALÓN COBAO','169.00'),(58,'CBS','SUDADERA COBAO','240.00'),(59,'IEPL','PLAYERA IEBO','129.00'),(60,'IEFA','FALDA IEBO','169.00'),(61,'IEPA','PANTS IEBO','399.00'),(62,'IECH','CHAMARRA IEBO','399.00'),(63,'IEPD','PLAYERA D. IEBO','99.00'),(64,'IESD','SUDADERA IEBO','220.00'),(65,'FG6','FALDA DE GALES TALLAS 6-8','109.00'),(66,'FG10','FALDA DE GALES TALLAS 10-12','115.00'),(67,'FG14','FALDA DE GALES TALLAS 14-16','125.00'),(68,'FG28','FALDA DE GALES TALLAS 28-36','135.00'),(69,'FG38','FALDA DE GALES TALLAS 38-40','155.00'),(70,'FTE6','FALDA EN TERGAL O ESCOCÉS TALLAS 6-8','125.00'),(71,'FTE10','FALDA EN TERGAL O ESCOCÉS TALLAS 10-12','129.00'),(72,'FTE14','FALDA EN TERGAL O ESCOCÉS TALLAS 14-16','149.00'),(73,'FTE28','FALDA EN TERGAL O ESCOCÉS TALLAS 28-36','159.00'),(74,'FTE38','FALDA EN TERGAL O ESCOCÉS TALLAS 38-42','189.00'),(75,'FX6','FALDA XALOSTOC TALLAS 6-8','155.00'),(76,'FX10','FALDA XALOSTOC TALLAS 10-12','175.00'),(77,'FX14','FALDA XALOSTOC TALLAS 14-16','195.00'),(78,'FX28','FALDA XALOSTOC TALLAS 28-34','215.00'),(79,'PSC6','PANTALÓN EN SUPER CASMIR TALLAS 6-8','112.00'),(80,'PSC10','PANTALÓN EN SUPER CASMIR TALLAS 10-12','122.00'),(81,'PSC14','PANTALÓN EN SUPER CASMIR TALLAS 14-16','127.00'),(82,'PSC28','PANTALÓN EN SUPER CASMIR TALLAS 28-36','138.00'),(83,'PSC38','PANTALÓN EN SUPER CASMIR TALLAS 38-40','168.00'),(84,'PTG6','PANTALÓN EN TELA GALES TALLAS 6-8','112.00'),(85,'PTG10','PANTALÓN EN TELA GALES TALLAS 10-12','122.00'),(86,'PTG14','PANTALÓN EN TELA GALES TALLAS 14-16','127.00'),(87,'PTG28','PANTALÓN EN TELA GALES TALLAS 28-36','138.00'),(88,'PTG38','PANTALÓN EN TELA GALES TALLAS 38-42','168.00'),(89,'PTE6','PANTALÓN EN TERGAL TALLAS 6-8','125.00'),(90,'PTE10','PANTALÓN EN TERGAL TALLAS 10-12','129.00'),(91,'PTE14','PANTALÓN EN TERGAL TALLAS 14-16','149.00'),(92,'PTE28','PANTALÓN EN TERGAL TALLAS 28-36','159.00'),(93,'PTE38','PANTALÓN EN TERGAL TALLAS 38-42','195.00'),(94,'PFG14','PANTALÓN DE LA FED. MCA: GACELA TALLAS 14-16','215.00'),(95,'PFG28','PANTALÓN DE LA FED. MCA: GACELA TALLAS 28-36','225.00'),(96,'PFG38','PANTALÓN DE LA FED. MCA: GACELA TALLAS 38-40','275.00'),(97,'JX6','JUMPER DE XALOSTOC TALLAS 6-8','210.00'),(98,'JX10','JUMPER DE XALOSTOC TALLAS 10-12','225.00'),(99,'JX14','JUMPER DE XALOSTOC TALLAS 14-16','249.00'),(100,'JX28','JUMPER DE XALOSTOC TALLAS 28-36','279.00'),(101,'JE6','JUMPER EN ESCOCÉS TALLAS 6-8','185.00'),(102,'JE10','JUMPER EN ESCOCÉS TALLAS 10-12','195.00'),(103,'JE14','JUMPER EN ESCOCÉS TALLAS 14-16','225.00'),(104,'JE28','JUMPER EN ESCOCÉS TALLAS 28-36','245.00'),(105,'JF14','JUMPER DE LA FEDERAL TALLAS 14-16','149.00'),(106,'JF34','JUMPER DE LA FEDERAL TALLAS 34-36','159.00');

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
