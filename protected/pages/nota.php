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
				$subtotal = Conexion::Retorna_Campo($this->dbConexion, "notas_productos", 
						"SUM(precio * cantidad)", array("id_nota"=>$this->Request["nota"]));
				$datos_nota = Conexion::Retorna_Registro($this->dbConexion, "notas", 
						array("id_nota"=>$this->Request["nota"]));
				if($datos_nota[0]["vales"] > 0)
				{
					$vale = Conexion::Retorna_Campo($this->dbConexion, "parametros", 
						"valor", array("llave"=>"vale"));
					$descuento = $vale * $datos_nota[0]["vales"];
				}
				else
					$descuento = $subtotal * $datos_nota[0]["descuento"] / 100;

				$this->lblNota->Text = $this->Request["nota"];
				$this->lblSubtotal->Text = $subtotal;
				$this->lblDescuento->Text = $descuento;
				$this->lblTotal->Text = $subtotal - $descuento;
				$this->Master->Page->Title = "Nota " . $this->Request["nota"];
				$consulta = "SELECT p.Codigo, p.Descripcion, np.Cantidad, np.Precio, np.cantidad * np.precio AS Total " . 
						"FROM productos p JOIN notas_productos np ON p.id_producto = np.id_producto " .
						"WHERE np.id_nota = :id_nota";
				$comando = $this->dbConexion->createCommand($consulta);
				$comando->bindValue(":id_nota", $this->Request["nota"]);
				$resultado = $comando->query()->readAll();
				$this->dgProductos->DataSource = $resultado;
				$this->dgProductos->dataBind();
			}
		}
	}
}
?>