<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Nota extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			if(isset($this->Request["nota"]))
			{
				$this->lblNota->Text = $this->Request["nota"];
				$this->lblTotal->Text = Conexion::Retorna_Campo($this->dbConexion, "notas_productos", "SUM(precio * cantidad)", array("id_nota"=>$this->Request["nota"]));
				$this->Master->Page->Title = "Nota " . $this->Request["nota"];
			}
		}
	}
}
?>