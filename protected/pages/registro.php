<?php
Prado::using('System.Util.*'); //TVarDumper
Prado::using('System.Web.UI.ActiveControls.*');
include_once('../compartidos/clases/conexion.php');

class Registro extends TPage
{
	var $dbConexion;
	var $columnas = array("Código", "Descripción", "Cantidad", "Precio", "Total", "Borrar");

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			$this->txtDescVales->Text = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"vale"));
			$vendedores = Conexion::Retorna_Registro($this->dbConexion, "vendedores", array("activo"=>1));
			$this->ddlVendedor->DataSource = $vendedores;
			$this->ddlVendedor->dataBind();
			$this->dgProductos->DataSource = array();
			$this->dgProductos->dataBind();
		}
	}
	
	public function btnAgregar_Callback($sender, $param)
	{
		$this->genera_tabla($sender, $param);
	}
	
	public function genera_tabla($sender, $param)
	{
		if($this->is_positive_integer($this->txtCantidad->Text) /* || !strcmp($this->txtCodigo->Text, "VALE")*/)
		{
			$producto = Conexion::Retorna_Registro($this->dbConexion, "productos", array("codigo"=>$this->txtCodigo->Text));
			$contenido = $this->contenido_auto_columnas($this->dgProductos);
			//$total = array_pop($contenido);
			//$this->Page->CallbackClient->callClientFunction("msg", array($total[$this->columnas[4]] + $producto[0]["precio"] * $this->txtCantidad->Text));
			/*if($total[$this->columnas[4]] + $producto[0]["precio"] * $this->txtCantidad->Text < 0)
			{
				$this->Page->CallbackClient->callClientFunction("msg", array("El vale genera un importe negativo, por lo que no puede agregarse."));
			}
			else*/
			if(count($producto))
			{
	/*			if($producto[0]["existencias"] < $this->txtCantidad->Text)
					$this->Page->CallbackClient->callClientFunction("msg", 
							array("Existencias del producto insuficientes. Sólo contamos con " . $producto[0]["existencias"] . " unidades."));
				else*/
				{
					$cantidad = 0;
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
					}

					if($cantidad == 0)
					{
						$row = array(
								$this->columnas[0]=>$producto[0]["codigo"], 
								$this->columnas[1]=>$producto[0]["descripcion"], 
								$this->columnas[2]=>$this->txtCantidad->Text, 
								$this->columnas[3]=>number_format($producto[0]["precio"], 2),
								$this->columnas[4]=>number_format(($producto[0]["precio"] * $this->txtCantidad->Text), 2),
						);
						$contenido[] = $row;
					}
					
/*					$row = array(
							$this->columnas[0]=>"", 
							$this->columnas[1]=>"TOTAL", 
							$this->columnas[2]=>$total_productos, 
							$this->columnas[3]=>"", 
							$this->columnas[4]=>number_format($total_a_pagar, 2)
					);
					$contenido[] = $row;*/
					
					$this->escribe_subtotal($contenido);
					$this->Page->CallbackClient->callClientFunction("calcula_total", array());


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
	
	public function total_productos($contenido)
	{
		$productos = 0;
		for($i = 0; $i < count($contenido); $i++)
			$productos += $contenido[$i][$this->columnas[2]];
		
		return $productos;
	}

	public function total_a_pagar($contenido)
	{
		$pago = 0;
		for($i = 0; $i < count($contenido); $i++)
			$pago += $contenido[$i][$this->columnas[4]];
		
		return $pago;
	}
	
	public function escribe_subtotal($contenido)
	{
		$subtotal = $this->total_a_pagar($contenido);
		$this->txtSubtotal->Text = number_format($subtotal, 2);
	}

	public function contenido_auto_columnas($datagrid)
	{
		$cols = $datagrid->Columns->Count;
		$contenido = array();
		for($i = 0; $i < $datagrid->ItemCount; $i++)
		{
			$row = array();
			for($j = 0; $j< $datagrid->AutoColumns->Count; $j++)
				$row[$this->dgProductos->AutoColumns->ItemAt($j)->HeaderText] = 
						$datagrid->Items->itemAt($i)->Cells->itemAt($j + $cols)->Text;
			$contenido[] = $row;
		}
		//$this->Page->CallbackClient->callClientFunction("msg", array(TVarDumper::dump($contenido)));
		return $contenido;
	}
	
	public function is_positive_integer($numero)
	{
		return ($this->is_positive($numero) && (!strstr($numero, ".")));
	}
	
	public function is_positive_integer_or_empty($numero)
	{
		return ($this->is_positive_integer($numero) || (!strcmp($numero, "")));
	}
	
	public function is_positive_or_empty($numero)
	{
		return ($this->is_positive($numero) || (!strcmp($numero, "")));
	}
	
	public function is_positive($numero)
	{
		return (is_numeric($numero) && $numero > 0);
	}
	
	public function crear_fila($sender, $param)
    {
        $item=$param->Item;
		
        if($item->ItemType==='Item' || $item->ItemType==='AlternatingItem')
        {
            $item->ibcDelete->Button->Attributes->onclick = "if(!confirm('¿Desea borrar la fila?')) return false;";
        }
    }
	
	public function borrar_fila($sender, $param)
	{
		$contenido = $this->contenido_auto_columnas($this->dgProductos);
		unset($contenido[$param->Item->ItemIndex]);
		$this->dgProductos->DataSource = $contenido;
		$this->dgProductos->dataBind();
		$contenido = $this->contenido_auto_columnas($this->dgProductos);
		$this->escribe_subtotal($contenido);
		$this->getClientScript()->registerEndScript("escribe_total",
				"calcula_total();\n");
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		$productos = $this->contenido_auto_columnas($this->dgProductos);
		if(count($productos) > 0)
		{
			if($this->is_positive_integer_or_empty($this->txtVales->Text) && 
					$this->is_positive_or_empty($this->txtDescuento->Text))
			{
				$nueva_nota = array(
						"vales"=>$this->txtVales->Text, 
						"descuento"=>$this->txtDescuento->Text, 
						"generada"=>date("Y-m-d H:i:s"), 
						"id_vendedor"=>$this->ddlVendedor->SelectedValue, 
						"id_status"=>1);
				Conexion::Inserta_Registro($this->dbConexion, "notas", $nueva_nota);
				$id_nota = Conexion::Ultimo_Id_Generado($this->dbConexion);
				$total = 0;
				
				foreach($productos as $prod)
				{
					if(strcmp($prod[$this->columnas[0]], ""))
					{
						$id_producto = Conexion::Retorna_Campo($this->dbConexion, "productos", "id_producto", 
								array("codigo"=>$prod[$this->columnas[0]]));
						Conexion::Inserta_Registro($this->dbConexion, "notas_productos",  
								array("id_nota"=>$id_nota, "id_producto"=>$id_producto, 
								"cantidad"=>$prod[$this->columnas[2]], "precio"=>$prod[$this->columnas[3]]));
						$total += $prod[$this->columnas[4]];
					}
				}
				$this->getClientScript()->registerBeginScript("guardado",
						"alert('Se ha generado nota " . $id_nota . " por un total de $" . $total . "');\n" . 
//						"open('index.php?page=nota&nota=" . $id_nota . "', 'notas');\n" . 
//						"document.location.href = 'index.php?page=registro';\n");
						"document.location.href = 'index.php?page=nota&nota=" . $id_nota . "';\n");
			}
			else
			{
				$this->getClientScript()->registerBeginScript("vale_desc_error",
						"alert('Verifique el número de vales y el descuento sugerido');\n");
			}
		}
		else
		{
			$this->getClientScript()->registerBeginScript("no_productos",
					"alert('Debe insertar al menos un producto para generar la nota');\n");
		}
	}
}
?>