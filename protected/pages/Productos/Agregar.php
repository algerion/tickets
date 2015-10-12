<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');
include_once('../compartidos/clases/listas.php');

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
			Listas::EnlazaLista($this->dbConexion, "SELECT * FROM grupos", $this->ddlGrupo);
			if(isset($this->Request["id_producto"]))
			{
				$producto = Conexion::Retorna_Registro($this->dbConexion, "productos", array("id_producto"=>$this->Request["id_producto"]));
				$this->txtCodigo->Text = $producto[0]["codigo"];
				$this->txtDescripcion->Text = $producto[0]["descripcion"];
				$this->txtPrecio->Text = $producto[0]["precio"];
				$this->ddlGrupo->SelectedValue = $producto[0]["id_grupo"];
			}
		}
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		$producto = array(
				"codigo"=>$this->txtCodigo->Text,
				"descripcion"=>$this->txtDescripcion->Text,
				"precio"=>$this->txtPrecio->Text
		);	
		if(isset($this->Request["id_producto"]))
		{
			if(Conexion::Retorna_Campo($this->dbConexion, "productos", "id_producto", 
					array("codigo"=>$this->txtCodigo->Text), " AND id_producto <> " . 
					$this->Request["id_producto"]) == "")
			{
				Conexion::Actualiza_Registro($this->dbConexion, "productos", $producto, 
						array("id_producto"=>$this->Request["id_producto"]));
				$this->getClientScript()->registerBeginScript("actualizado",
						"alert('Los datos del producto fueron actualizados exitosamente.');\n" . 
						"document.location.replace('index.php?page=Productos.Modificar');\n");
			}
			else
				$this->getClientScript()->registerBeginScript("duplicado",
						"alert('El código proporcionado ya existe.');\n");
		}
		else
		{
			if(Conexion::Retorna_Campo($this->dbConexion, "productos", "id_producto", 
					array("codigo"=>$this->txtCodigo->Text)) == "")
			{
				Conexion::Inserta_Registro($this->dbConexion, "productos", $producto);
				$this->getClientScript()->registerBeginScript("guardado",
						"alert('Los datos del producto fueron guardados exitosamente.');\n" . 
						"document.location.replace(document.location.href);\n");
			}
			else
				$this->getClientScript()->registerBeginScript("duplicado",
						"alert('El código proporcionado ya existe.');\n");
		}
	}
}
?>