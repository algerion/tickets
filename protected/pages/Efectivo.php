<?php

include_once('../compartidos/clases/conexion.php');

class Efectivo extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		$apertura = Conexion::Retorna_Campo($this->dbConexion, "movimientos", "importe", array(), 
				" fecha BETWEEN '" . date("Y-m-d") . "' AND '" . date("Y-m-d",  
				strtotime('+2 day', strtotime(date("Y-m-d")))) . "' AND importe > 0");
		if($apertura == "")
			$this->getClientScript()->registerBeginScript("repeticion",
					"alert('Debe realizar la apertura de caja para hoy');\n" . 
					"document.location.href = 'index.php?page=Apertura';\n");
			
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();
		
		$salida = $this->txtEfectivo->Text;
		$salida = -$salida;
		Conexion::Inserta_Registro($this->dbConexion, "movimientos",  
				array("fecha"=>date("Y-m-d H:i:s"), 
				"importe"=>$salida));
				$this->getClientScript()->registerBeginScript("guardado",
						"alert('Se ha guardado la salida de efectivo');\n" . 
						"document.location.href = 'index.php?page=Efectivo';\n");
	}
}
?>