<?php
Prado::using('System.Util.*'); //TVarDump
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
		if($this->is_positive_integer($this->txtCantidad->Text) /* || !strcmp($this->txtCodigo->Text, "VALE")*/)
		{
			$producto = Conexion::Retorna_Registro($this->dbConexion, "productos", array("codigo"=>$this->txtCodigo->Text));
			$contenido = $this->contenidoTabla($this->dgProductos);
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
					$total_productos = 0;
					$total_a_pagar = 0;
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
						$total_productos += $contenido[$i][$this->columnas[2]];
						$total_a_pagar += $contenido[$i][$this->columnas[4]];
					}

					if($cantidad == 0)
					{
						$row = array(
								$this->columnas[0]=>$producto[0]["codigo"], 
								$this->columnas[1]=>$producto[0]["descripcion"], 
								$this->columnas[2]=>$this->txtCantidad->Text, 
								$this->columnas[3]=>number_format($producto[0]["precio"], 2),
								$this->columnas[4]=>number_format(($producto[0]["precio"] * $this->txtCantidad->Text), 2),
								$this->columnas[5]=>"<img src='images/borrar.gif' alt='Borrar' />"
						);
						$contenido[] = $row;
						$total_productos += $contenido[$i][$this->columnas[2]];
						$total_a_pagar += $contenido[$i][$this->columnas[4]];
					}
					
/*					$row = array(
							$this->columnas[0]=>"", 
							$this->columnas[1]=>"TOTAL", 
							$this->columnas[2]=>$total_productos, 
							$this->columnas[3]=>"", 
							$this->columnas[4]=>number_format($total_a_pagar, 2)
					);
					$contenido[] = $row;*/
					$this->txtSubtotal->Text = number_format($total_a_pagar, 2);
					$this->Page->CallbackClient->callClientFunction("calcula_total", array());

					$this->dgProductos->DataSource = $contenido;
					$this->dgProductos->dataBind();
					//$this->dgProductos->CommandName="delete";
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
	/*
	public function itemCreated($sender,$param)
    {
        $item=$param->Item;
        if($item->ItemType==='Item' || $item->ItemType==='AlternatingItem')
        {
			echo "X";
			$this->Page->CallbackClient->callClientFunction("msg", array($item));
            //$item->DeleteColumn->Button->Attributes->onclick='if(!confirm(\'Are you sure?\')) return false;';
        }
    }
*/
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
	
	public function is_positive_integer($numero)
	{
		return ($this->is_positive($numero) && (!strstr($numero, ".")));
	}
	
	public function is_positive($numero)
	{
		return (is_numeric($numero) && $numero > 0);
	}
	
	public function btnGuardar_Click($sender, $param)
	{
		$productos = $this->contenidoTabla($this->dgProductos);
		if(count($productos) > 0)
		{
			if($this->is_positive_integer($this->txtVales->Text) && $this->is_positive($this->txtDescuento->Text))
			{
				$nueva_nota = array(
						"vales"=>$this->txtVales->Text, 
						"descuento"=>$this->txtDescuento->Text, 
						"generada"=>date("Y-m-d H:i:s"), 
						"id_usuario"=>$this->User->Id, 
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
						"open('index.php?page=nota&popup=2&nota=" . $id_nota . "', 'nota', 'width=200px, height=200px');\n" . 
						"document.location.href = 'index.php?page=registro';\n");
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