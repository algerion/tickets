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
						$clientes = Conexion::Retorna_Registro($this->dbConexion, "clientes", array(), "1 = 1");
						$clientes = array_merge(array(array("id_cliente"=>"0", "nombre"=>"Cliente genérico")), $clientes);
						$this->ddlClientes->DataSource = $clientes;
						$this->ddlClientes->dataBind();
						$this->txtFecha->Text = date("d-m-Y", strtotime($nota[0]["generada"]));
						$this->txtHora->Text = date("H:i:s", strtotime($nota[0]["generada"]));
						$this->txtPorcDesc->Text = $nota[0]["descuento"];
						$this->txtNumVales->Text = $nota[0]["vales"];
						$this->txtImporteVale->Text = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"vale"));
						$this->txtPorcentajeIva->Text = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"iva"));

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
	
	public function guarda_pagare()
	{
		$lugar = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", 
				array("llave"=>"lugar"));
		$cobrador = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", 
				array("llave"=>"cobrador"));
		$interes = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", 
				array("llave"=>"interes"));
		$cliente = $this->ddlClientes->SelectedItem->Text;

		$pagare = array(
				"id_nota"=>$this->Request["nota"],
				"lugarfirma"=>$lugar,
				"fecha"=>date("Y-m-d"), 
				"cobrador"=>$cobrador,
				"lugarcobro"=>$lugar,
				"interes"=>$interes,
				"deudor"=>$cliente
		);
		Conexion::Inserta_Registro($this->dbConexion, "pagares", $pagare);
		$this->getClientScript()->registerBeginScript("pagare",
				"open('index.php?page=Pagarepdf&nota=" . $this->Request["nota"] . "', 'pagare');\n");
		
	}
	
	public function btnPagar_Click($sender, $param)
	{
		$credito = $this->txtCredito->Text;
		$id_cliente = $this->ddlClientes->SelectedValue;
		
		$credito_total = Conexion::Retorna_Campo($this->dbConexion, "cobros", "SUM(credito)", 
				array("id_cliente"=>$id_cliente));
		$saldo_total = Conexion::Retorna_Campo($this->dbConexion, "depositos", "SUM(cantidad)", 
				array("id_cliente"=>$id_cliente));
		$adeudomax = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", 
				array("llave"=>"adeudomax"));
				
		$adeudo_total = $saldo_total - $credito_total - $credito;
		
		if($adeudo_total >= $adeudomax)
		{
			$total = Conexion::Retorna_Campo($this->dbConexion, "notas_productos", "SUM(cantidad * precio)", 
					array("id_nota"=>$this->Request["nota"]));
			$porcdesc = $this->txtPorcDesc->Text;

			$coniva = $this->chkConIva->Checked;
			$porcentajeiva = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"iva"));

			$numvales = $this->txtNumVales->Text;
			$importevale = Conexion::Retorna_Campo($this->dbConexion, "parametros", "valor", array("llave"=>"vale"));

			$efectivo = $this->txtEfectivo->Text;
			$cheque = $this->txtCheque->Text;

			$totaldesc = $total * (1 - $porcdesc / 100);
			$iva = 0;
			$totaliva = $totaldesc;
			$vales = abs(round($numvales) * $importevale);

			$pagototal = $efectivo + $cheque + $vales + $credito;

			if($coniva)
			{
				$iva = $totaldesc * $porcentajeiva / 100;
				$totaliva += $iva;
			}

			$cambio = $pagototal - $totaliva;

			if($porcdesc > 0 && $numvales > 0)
			{
				$this->getClientScript()->registerBeginScript("valesydescuento",
						"alert('No puede introducir un porcentaje de descuento si el cliente trae vales.');\n");
			}
			else
			{
				if($cambio >= 0)
				{
					Conexion::Actualiza_Registro($this->dbConexion, "notas",  array("id_status"=>2), 
							array("id_nota"=>$this->Request["nota"]));
					$cobro = array(
							"id_nota"=>$this->Request["nota"],
							"id_cliente"=>$id_cliente,
							"cobrada"=>date("Y-m-d H:i:s"), 
							"porcentaje_descuento"=>$porcdesc,
							"incluye_iva"=>($coniva ? 1 : 0),
							"porcentaje_iva"=>$porcentajeiva,
							"numero_vales"=>$numvales,
							"importe_vale"=>$importevale,
							"efectivo"=>$efectivo,
							"cheque"=>$cheque,
							"credito"=>$credito
					);
					Conexion::Inserta_Registro($this->dbConexion, "cobros", $cobro);
					if($credito != "")
						$this->guarda_pagare();
					$this->getClientScript()->registerBeginScript("guardado",
							"open('index.php?page=notapdf&nota=" . $this->Request["nota"] . "', 'nota');\n" . 
							"alert('Se ha registrado el pago de la nota.');\n" . 
							"document.location.href = 'index.php?page=Cobranza';\n");
				}
				else
				{
					$this->txtCredito->Text = "";
					$this->getClientScript()->registerBeginScript("importedepago",
							"alert('Favor de especificar el importe de pago.');\n");
				}
			}
		}
		else
		{
			$this->txtCredito->Text = "";
			$this->getClientScript()->registerBeginScript("adeudomax",
					"alert('El cliente tiene un adeudo actual de " . $credito_total . 
					", y un saldo a favor de  " . $saldo_total . 
					", por lo que no puede concedérsele un crédito por " . $credito . 
					". Consulte al administrador.');\n");
		}
	}
}
?>