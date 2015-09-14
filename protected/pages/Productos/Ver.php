<?php
Prado::using('System.Data.ActiveRecord.Scaffold.*'); 
//Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');
include_once('Productos.php');

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
			$resultado = Conexion::Retorna_Registro($this->dbConexion, "productos", array(), 
					" descripcion LIKE '%" . $this->txtBusqueda->Text . "%'");
			if(isset($this->Request["tipo"]))
				if($this->Request["tipo"] == "link")
					for($i = 0; $i < count($resultado); $i++)
						$resultado[$i]["codigo"] = "<a href='#' onclick=\"opener.document.getElementById('ctl0_Main_txtCodigo').value = '" . 
								$resultado[$i]["codigo"] . "'; window.close();\" >" . $resultado[$i]["codigo"] . "</a>";
			$this->dgProductos->DataSource = $resultado;
			$this->dgProductos->dataBind();
		}
	}
}
?>