<?php
Prado::using('System.Util.*'); //TVarDump
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Registro extends TPage
{
	var $dbConexion;
	var $columnas = array("Código", "Descripción", "Cantidad", "Precio", "Total");

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
					$total_productos = 0;
					$total_a_pagar = 0;
					$cantidad = 0;
					$contenido = $this->contenidoTabla($this->dgProductos);
					array_pop($contenido);
					for($i = 0; $i < count($contenido); $i++)
					{
						if(!strcmp($contenido[$i][$this->columnas[0]], $producto[0]["codigo"]))
						{
							$cantidad = (int) $contenido[$i][$this->columnas[2]];
							$cantidad += $this->txtCantidad->Text;
							$contenido[$i][$this->columnas[2]] = $cantidad;
							$contenido[$i][$this->columnas[4]] = 
									number_format($contenido[$i][$this->columnas[3]] * $cantidad, 2);
						}
						$total_productos += $contenido[$i][$this->columnas[2]];
						$total_a_pagar += $contenido[$i][$this->columnas[4]];
					}
					/*
					for($i = 0; $i < $this->dgProductos->ItemCount - 1; $i++)
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
*/
					if($cantidad == 0)
					{
						$row = array(
								$this->columnas[0]=>$producto[0]["codigo"], 
								$this->columnas[1]=>$producto[0]["descripcion"], 
								$this->columnas[2]=>$this->txtCantidad->Text, 
								$this->columnas[3]=>number_format($producto[0]["precio"], 2),
								$this->columnas[4]=>number_format(($producto[0]["precio"] * $this->txtCantidad->Text), 2)
						);
						$contenido[] = $row;
						$total_productos += $contenido[$i][$this->columnas[2]];
						$total_a_pagar += $contenido[$i][$this->columnas[4]];
					}
					
					$row = array(
							$this->columnas[0]=>"", 
							$this->columnas[1]=>"TOTAL", 
							$this->columnas[2]=>$total_productos, 
							$this->columnas[3]=>"", 
							$this->columnas[4]=>number_format($total_a_pagar, 2)
					);
					$contenido[] = $row;

					$this->dgProductos->DataSource = $contenido;
					$this->dgProductos->dataBind();
					$this->txtCodigo->Text = "";
					$this->txtCantidad->Text = "";
					if($param != null)
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

	public function contenidoTabla($datagrid)
	{
		$contenido = array();
		for($i = 0; $i < $datagrid->ItemCount; $i++)
		{
			$row = array();
			for($j = 0; $j< $datagrid->AutoColumns->Count; $j++)
				$row[$this->dgProductos->AutoColumns->ItemAt($j)->HeaderText] = 
						$datagrid->Items->itemAt($i)->Cells->itemAt($j)->Text;
			$contenido[] = $row;
		}
		
		return $contenido;
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		var_dump($this->contenidoTabla($this->dgProductos));
		//$id_nota = Conexion::Inserta_Registro($this->dbConexion, "notas",  array("generada"=>time()));
		
		//for
	}
}
?>