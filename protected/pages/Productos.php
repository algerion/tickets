<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Paquetes extends TPage
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
				$nota = Conexion::Retorna_Registro($this->dbConexion, "notas", array("id_nota"=>$this->Request["nota"]));
				if(count($nota) > 0)
				{
					if($nota[0]["id_status"] == 2)
					{
						$usuario = Conexion::Retorna_Campo($this->dbConexion, "usuarios", "nombre", array("id_usuario"=>$nota[0]["id_usuario"]));
						$this->txtVendedor->Text = $usuario;
						$this->txtFecha->Text = date("d-m-Y", strtotime($nota[0]["generada"]));
						$this->txtHora->Text = date("H:i:s", strtotime($nota[0]["generada"]));
						$this->txtGenerales->Text = "Datos de la empresa";

						$consulta = "SELECT p.Codigo, p.Descripcion, np.Cantidad, np.Precio, np.cantidad * np.precio AS Total " . 
								"FROM productos p JOIN notas_productos np ON p.id_producto = np.id_producto " .
								"WHERE np.id_nota = :id_nota";
						$comando = $this->dbConexion->createCommand($consulta);
						$comando->bindValue(":id_nota", $this->Request["nota"]);
						$resultado = $comando->query()->readAll();
						$this->dgProductos->DataSource = $resultado;
						$this->dgProductos->dataBind();
					}
					elseif($nota[0]["id_status"] == 1)
					{
						$this->getClientScript()->registerBeginScript("entregada",
								"alert('La nota solicitada no ha sido pagada.');\n" .
								"document.location.href = 'index.php?page=Entrega';\n");
					}
					else
					{
						$this->getClientScript()->registerBeginScript("entregada",
								"alert('La nota solicitada ya ha sido entregada.');\n" .
								"document.location.href = 'index.php?page=Entrega';\n");
					}
				}
				else
				{
					$this->getClientScript()->registerBeginScript("sin_nota",
							"alert('La nota solicitada no existe');\n" .
							"document.location.href = 'index.php?page=Entrega';\n");
				}
			}
		}
	}
	
	public function btnEntregado_Click($sender, $param)
	{
		Conexion::Actualiza_Registro($this->dbConexion, "notas",  array("id_status"=>3), array("id_nota"=>$this->Request["nota"]));
		$this->getClientScript()->registerBeginScript("guardado",
				"alert('Mercancía entregada.');\n" . 
				"document.location.href = 'index.php?page=Entrega';\n");
	}
}
?>