<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Caja extends TPage
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
					if($nota[0]["id_status"] == 1)
					{
						$usuario = Conexion::Retorna_Campo($this->dbConexion, "vendedores", "nombre", array("id_vendedor"=>$nota[0]["id_vendedor"]));
						$this->txtVendedor->Text = $usuario;
						$this->txtFecha->Text = date("d-m-Y", strtotime($nota[0]["generada"]));
						$this->txtHora->Text = date("H:i:s", strtotime($nota[0]["generada"]));
						$this->txtPorcDesc->Text = $nota[0]["descuento"];
						$this->txtNumVales->Text = $nota[0]["vales"];

						$consulta = "SELECT /*p.Codigo,*/ p.Descripcion, np.Cantidad, np.Precio, np.cantidad * np.precio AS Total " . 
								"FROM productos p JOIN notas_productos np ON p.id_producto = np.id_producto " .
								"WHERE np.id_nota = :id_nota";
						$comando = $this->dbConexion->createCommand($consulta);
						$comando->bindValue(":id_nota", $this->Request["nota"]);
						$resultado = $comando->query()->readAll();
						$this->dgProductos->DataSource = $resultado;
						$this->dgProductos->dataBind();

						$total = 0;
						foreach($resultado as $res)
							$total += $res["Total"];
						
						$this->txtTotal->Text = $total;
					}
					else
					{
						$this->getClientScript()->registerBeginScript("pagada",
								"alert('La nota solicitada ya ha sido pagada');\n" .
								"document.location.href = 'index.php?page=Cobranza';\n");
					}
				}
				else
				{
					$this->getClientScript()->registerBeginScript("sin_nota",
							"alert('La nota solicitada no existe');\n" .
							"document.location.href = 'index.php?page=Cobranza';\n");
				}
			}
		}
	}
	
	public function btnPagar_Click($sender, $param)
	{
		if($this->txtRecibido->Text - $this->txtTotal->Text > 0)
		{
			Conexion::Actualiza_Registro($this->dbConexion, "notas",  array("id_status"=>2), array("id_nota"=>$this->Request["nota"]));
			$this->getClientScript()->registerBeginScript("guardado",
					"alert('Se ha registrado el pago de la nota.');\n" . 
					"document.location.href = 'index.php?page=Cobranza';\n");
		}
		else
		{
			$this->getClientScript()->registerBeginScript("guardado",
					"alert('Favor de especificar el importe de pago.');\n");
		}
	}
}
?>