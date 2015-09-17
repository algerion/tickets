<?php
include_once('../compartidos/clases/conexion.php');

class Corte extends TPage
{
	var $dbConexion;

	public function onLoad($param)
	{
		parent::onLoad($param);

		$this->dbConexion = Conexion::getConexion($this->Application, "db");
		Conexion::createConfiguracion();

		if(!$this->IsPostBack)
		{
			$this->lblDia->Text = date("d-m-Y");
			$consulta = "SELECT SUM(cantidad * precio) AS subtotal, " .
					"SUM(porcentaje_descuento * cantidad * precio / 100) AS descuentos " .
					"FROM cobros c JOIN notas_productos np ON c.id_nota = np.id_nota " .
					"WHERE DATE(cobrada) = DATE(NOW())";
			$comando = $this->dbConexion->createCommand($consulta);
			$resultado_st = $comando->query()->readAll();

			$consulta = "SELECT SUM(numero_vales) AS numero_vales, " .
					"SUM(numero_vales * importe_vale) AS monto_vales, " .
					"SUM(efectivo) AS efectivo, SUM(cheque) AS cheque " .
					"FROM cobros WHERE DATE(cobrada) = DATE(NOW())";
			$comando = $this->dbConexion->createCommand($consulta);
			$resultado_pg = $comando->query()->readAll();
			
			$resultado = array(array_merge($resultado_st[0], $resultado_pg[0]));
			$this->dgCorte->DataSource = $resultado;
			$this->dgCorte->dataBind();
		}
	}
}
?>