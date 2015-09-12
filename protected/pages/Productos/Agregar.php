<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Agregar extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
		}
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		$nuevo_producto = array(
				"codigo"=>$this->txtCodigo->Text,
				"descripcion"=>$this->txtDescripcion->Text,
				"precio"=>$this->txtPrecio->Text
		);	
		if(Conexion::Retorna_Campo($this->dbConexion, "productos", "id_producto", array("codigo"=>$this->txtCodigo->Text)) == "")
		{
			Conexion::Inserta_Registro($this->dbConexion, "productos", $nuevo_producto);
			$this->getClientScript()->registerBeginScript("guardado",
					"alert('Los datos del producto fueron guardados exitosamente.');\n" . 
					"document.location.replace(document.location.href);\n");
		}
		else
		{
			$this->getClientScript()->registerBeginScript("duplicado",
					"alert('El código proporcionado ya existe.');\n");
		}
	}
}
?>