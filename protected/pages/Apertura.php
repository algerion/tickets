<?php

include_once('../compartidos/clases/conexion.php');

class Apertura extends TPage
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
		{
			if(!$this->IsPostBack)
			{
				$fondo = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"revolvente"));
				$this->txtFondo->Text = $fondo;
			}
		}
		else
				$this->getClientScript()->registerBeginScript("repeticion",
						"alert('Ya se efectuó la apertura de caja para hoy');\n" . 
						"document.location.href = 'index.php?page=Cobranza';\n");
			
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		Conexion::Inserta_Registro($this->dbConexion, "movimientos",  
				array("fecha"=>date("Y-m-d H:i:s"), 
				"importe"=>$this->txtFondo->Text));
				$this->getClientScript()->registerBeginScript("guardado",
						"alert('Se ha guardado el fondo revolvente de hoy');\n" . 
						"document.location.href = 'index.php?page=Cobranza';\n");
	}
}
?>