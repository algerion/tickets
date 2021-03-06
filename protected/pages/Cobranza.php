<?php

include_once('../compartidos/clases/conexion.php');

class Cobranza extends TPage
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
	
	public function btnMostrar_Click($sender, $param)
	{
		$this->Response->redirect("index.php?page=Caja&nota=" . $this->txtNota->Text);
	}
}
?>