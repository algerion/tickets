<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');
include_once('../compartidos/clases/numaletra.php');

class Pagare extends TPage
{
	var $dbConexion;
	var $nl;

	public function onLoad($param)
	{
		parent::onLoad($param);
		
		$nl = new NumALetra();

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			if(isset($this->Request["nota"]))
			{
				$importe = Conexion::Retorna_Campo($this->dbConexion, "cobros", 
						"credito", array("id_nota"=>$this->Request["nota"]));
				$pagare = Conexion::Retorna_Registro($this->dbConexion, "pagares", 
						array("id_nota"=>$this->Request["nota"]));
				
				$this->lblNumero->Text = $pagare[0]["id_pagare"];
				$this->lblImporte->Text = $importe;
				$this->lblLugarFirma->Text = $pagare[0]["lugarfirma"];
				$this->lblDia->Text = date("d", strtotime($pagare[0]["fecha"]));
				$this->lblMes->Text = date("m", strtotime($pagare[0]["fecha"]));
				$this->lblAnio->Text = date("Y", strtotime($pagare[0]["fecha"]));
				$this->lblCobrador->Text = $pagare[0]["cobrador"];
				$this->lblLugarCobro->Text = $pagare[0]["lugarcobro"];
				$this->lblCantidad->Text = $nl->ValorEnLetras($importe);
				$this->lblInteres->Text = $pagare[0]["interes"];
				$this->lblDeudor->Text = $pagare[0]["deudor"];
			}
		}
	}
}
?>