<?php

class Cobranza extends TPage
{
	var $dbConexion;

	public function btnMostrar_Click($sender, $param)
	{
		$this->Response->redirect("index.php?page=Caja&nota=" . $this->txtNota->Text);
	}
}
?>