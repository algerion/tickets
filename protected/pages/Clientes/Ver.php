<?php
Prado::using('System.Data.ActiveRecord.Scaffold.*'); 
include_once('../compartidos/clases/conexion.php');
include_once('Clientes.php');

class Ver extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

//		if(!$this->IsPostBack)
		{
			$resultado = Conexion::Retorna_Registro($this->dbConexion, "clientes", array(), 
					" nombre LIKE '%" . $this->txtBusqueda->Text . "%'");
			if(isset($this->Request["tipo"]))
				if($this->Request["tipo"] == "link")
					for($i = 0; $i < count($resultado); $i++)
						$resultado[$i]["nombre"] = "<a href='#' onclick=\"opener.document.getElementById('ctl0_Main_ddlClientes').value = '" . 
								$resultado[$i]["id_cliente"] . "'; window.close();\" >" . $resultado[$i]["nombre"] . "</a>";
			$this->dgClientes->DataSource = $resultado;
			$this->dgClientes->dataBind();
		}
	}
}
?>