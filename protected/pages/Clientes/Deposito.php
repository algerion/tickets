<?php
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Deposito extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			$clientes = Conexion::Retorna_Registro($this->dbConexion, "clientes", array(), "1 = 1");
			$this->ddlClientes->DataSource = $clientes;
			$this->ddlClientes->dataBind();
		}
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		Conexion::Inserta_Registro($this->dbConexion, "depositos",  
				array("id_cliente"=>$this->ddlClientes->SelectedValue, "fecha"=>date("Ymd"), 
				"cantidad"=>$this->txtDeposito->Text));
				$this->getClientScript()->registerBeginScript("guardado",
						"alert('Se ha guardado el depósito a cuenta');\n" . 
						"document.location.href = 'index.php?page=Clientes.Deposito';\n");
	}
}
?>