<?php

class Entrega extends TPage
{
	var $dbConexion;

	public function btnMostrar_Click($sender, $param)
	{
		$this->Response->redirect("index.php?page=Paquetes&nota=" . $this->txtNota->Text);
	}
}
?>