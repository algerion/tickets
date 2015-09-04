<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Registro extends TPage
{
	var $dbConexion;
	var $columnas = array("codigo", "descripcion", "cantidad", "precio", "total");

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			$this->txtVendedor->Text = $this->User->Name;
			$this->txtFecha->Text = date("d-m-Y");
			$this->txtHora->Text = date("H:i:s");
			$this->txtGenerales->Text = "Datos de la empresa";
			$this->dgProductos->DataSource = array();
			$this->dgProductos->dataBind();
		}
	}
	
	public function btnAgregar_Callback($sender, $param)
	{
		if(is_numeric($this->txtCantidad->Text) && !strstr($this->txtCantidad->Text, ".") && $this->txtCantidad->Text > 0)
		{
			$producto = Conexion::Retorna_Registro($this->dbConexion, "productos", array("codigo"=>$this->txtCodigo->Text));
			if(count($producto))
			{
	/*			if($producto[0]["existencias"] < $this->txtCantidad->Text)
					$this->Page->CallbackClient->callClientFunction("msg", 
							array("Existencias del producto insuficientes. Sólo contamos con " . $producto[0]["existencias"] . " unidades."));
				else*/
				{
					$cantidad = 0;
					$contenido = array();
					for($i = 0; $i < $this->dgProductos->ItemCount; $i++)
					{
						$row = array();
						for($j = 0; $j< $this->dgProductos->AutoColumns->Count; $j++)
						{
							if($j == 2 && !strcmp($row[$this->columnas[0]], $producto[0]["codigo"]))
							{
								$cantidad = (int) $this->dgProductos->Items->itemAt($i)->Cells->itemAt($j)->Text;
								$cantidad += $this->txtCantidad->Text;
								$row[$this->columnas[$j]] = $cantidad;
							}
							else
								$row[$this->columnas[$j]] = $this->dgProductos->Items->itemAt($i)->Cells->itemAt($j)->Text;
						}
						$contenido[] = $row;
					}

					if($cantidad == 0)
					{
						$row = array(
								$this->columnas[0]=>$producto[0]["codigo"], 
								$this->columnas[1]=>$producto[0]["descripcion"], 
								$this->columnas[2]=>$this->txtCantidad->Text, 
								$this->columnas[3]=>$producto[0]["precio"], 
								$this->columnas[4]=>$producto[0]["precio"] * $this->txtCantidad->Text
						);
						$contenido[] = $row;
					}
					
					$this->dgProductos->DataSource = $contenido;
					$this->dgProductos->dataBind();
					$this->pnlProductos->render($param->getNewWriter());
				}
			}
			else
			{
				$this->Page->CallbackClient->callClientFunction("msg", array("El código de producto solicitado no existe"));
			}
		}
		else
		{
			$this->Page->CallbackClient->callClientFunction("msg", array("Introduzca una cantidad correcta"));
		}
	}
}
?>