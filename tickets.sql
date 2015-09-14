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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notas` */

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

/*Table structure for table `parametros` */

DROP TABLE IF EXISTS `parametros`;

CREATE TABLE `parametros` (
  `llave` varchar(20) NOT NULL,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`llave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `parametros` */

insert  into `parametros`(`llave`,`valor`) values ('vale','194.98');

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `permiso` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `permisos` */

insert  into `permisos`(`id_permiso`,`permiso`) values (1,'admin'),(2,'registro'),(3,'cobranza'),(4,'entrega'),(5,'productos');

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(18,2) DEFAULT '0.00',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `UK_COD` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`codigo`,`descripcion`,`precio`) values (1,'SPORTOCK6','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 6-10','350.00'),(2,'SPORTOCK12','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 12-16','395.00'),(3,'SPORTOCK34','JGO. DE PANTS EN SPORTOCK Y MICROFIBRA TALLA 34-40','430.00'),(4,'PANTSBORDADOS6','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 6-8','284.00'),(5,'PANTSBORDADOS10','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 10-12','314.00'),(6,'PANTSBORDADOS14','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 14-16','345.00'),(7,'PANTSBORDADOS34','JGO. DE PANTS CON ESCUDO BORDADO (CHAMARRA Y PANTS) TALLAS 34-40','380.00'),(8,'PANTSIMPRESOS6','JGO. DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 6-8','269.00'),(9,'PANTSIMPRESOS10','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 10-12','299.00'),(10,'PANTSIMPRESOS14','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 14-16','330.00'),(11,'PANTSIMPRESOS34','JUEGO DE PANTS CON IMPRESIÓN (CHAMARRA Y PANTS) TALLAS 34-40','365.00'),(12,'PANTSFELPA6','SOLO PANTS EN FELPA','135.00'),(13,'PANTSFELPA10','SOLO PANTS EN FELPA TALLAS 10-12','150.00'),(14,'PANTSFELPA14','SOLO PANTS EN FELPA TALLAS 14-16','165.00'),(15,'PANTSFELPA34','SOLO PANTS EN FELPA TALLAS 34-40','183.00'),(16,'CHAMBORDADO6','SOLO CHAMARRA CON BORDADO TALLAS 6-8','170.00'),(17,'CHAMBORDADO10','SOLO CHAMARRA CON BORDADO TALLAS 10-12','184.00'),(18,'CHAMBORDADO14','SOLO CHAMARRA CON BORDADO TALLAS 14-16','200.00'),(19,'CHAMBORDADO34','SOLO CHAMARRA CON BORDADO TALLAS 34-40','218.00'),(20,'POLOBORDADA4','PLAYERA POLO CON BORDADO TALLAS 4-10','89.00'),(21,'POLOBORDADA12','PLAYERA POLO CON BORDADO TALLAS 12-18','95.00'),(22,'POLOBORDADA34','PLAYERA POLO CON BORDADO TALLAS 34-40','115.00'),(23,'POLOIMPRESA4','PLAYERA POLO CON IMPRESIÓN TALLAS 4-10','75.00'),(24,'POLOIMPRESA12','PLAYERA POLO CON IMPRESIÓN TALLAS 12-18','85.00'),(25,'POLOIMPRESA34','PLAYERA POLO CON IMPRESIÓN TALLAS 34-40','105.00'),(26,'SHORTFELPA6','SHORT / FELPA TALLAS 6 - 16','75.00'),(27,'SHORTFELPA34','SHORT / FELPA TALLAS 34-40','85.00'),(28,'SHORTMFIBRA6','SHORT / MICROFIBRA TALLAS 6-16','85.00'),(29,'SHORTMFIBRA34','SHORT / MICROFIBRA TALLAS 34-40','95.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id_usuario`,`usuario`,`acceso`) values (1,'admin','73acd9a5972130b75066c82595a1fae3'),(2,'ventas','260ebbae64c0831bbe4c52c123393863'),(3,'caja','335f07edf0462e587f5ea48957ba5f9a'),(4,'entrega','6ef994ecaf30d09a99f685b76fbdf768');

/*Table structure for table `usuarios_permisos` */

DROP TABLE IF EXISTS `usuarios_permisos`;

CREATE TABLE `usuarios_permisos` (
  `id_usuario` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usuarios_permisos` */

insert  into `usuarios_permisos`(`id_usuario`,`id_permiso`) values (1,3),(2,2),(2,5),(3,4);

/*Table structure for table `vendedores` */

DROP TABLE IF EXISTS `vendedores`;

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) DEFAULT NULL,
  `activo` varchar(1) DEFAULT '1',
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `vendedores` */

insert  into `vendedores`(`id_vendedor`,`nombre`,`activo`) values (1,'Angel Augusto Bravo Sumano','1'),(2,'Enrique Castellanos Rodriguez','1'),(3,'Alfonso Sandoval Carballido','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
