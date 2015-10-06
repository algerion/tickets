<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Ticket extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			if(isset($this->Request["ticket"]))
			{
				$subtotal = Conexion::Retorna_Campo($this->dbConexion, "notas_productos", 
						"SUM(precio * cantidad)", array("id_nota"=>$this->Request["ticket"]));
				$datos_nota = Conexion::Retorna_Registro($this->dbConexion, "notas", 
						array("id_nota"=>$this->Request["ticket"]));
				if($datos_nota[0]["vales"] > 0)
				{
					$vale = Conexion::Retorna_Campo($this->dbConexion, "parametros", 
						"valor", array("llave"=>"vale"));
					$descuento = $vale * $datos_nota[0]["vales"];
				}
				else
					$descuento = $subtotal * $datos_nota[0]["descuento"] / 100;

				$this->lblNota->Text = $this->Request["ticket"];
				$this->lblTotal->Text = $subtotal;
				$this->Master->Page->Title = "Nota " . $this->Request["ticket"];
			}
		}
	}
}
?>