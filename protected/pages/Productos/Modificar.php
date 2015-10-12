<?php
include_once('../compartidos/clases/conexion.php');

class Modificar extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		//if(!$this->IsPostBack)
		{
			$resultado = Conexion::Retorna_Registro($this->dbConexion, "productos", array(), 
					" WHERE descripcion LIKE '%" . $this->txtBusqueda->Text . "%'");
			$this->dgProductos->DataSource = $resultado;
			$this->dgProductos->dataBind();
		}
	}
}
?>