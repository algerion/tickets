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
			$this->dgProductos->DataSource = $resultado;
			$this->dgProductos->dataBind();
		}
	}
}
?>