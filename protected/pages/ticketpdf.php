<?php
include_once('../compartidos/clases/usadompdf.php');

class Ticketpdf extends TPage
{
	public function onLoad($param)
	{
		parent::onLoad($param);

		usadompdf::creapdf("http://" . $_SERVER["HTTP_HOST"] 
				. $_SERVER["PHP_SELF"] . "?page=ticket&ticket=" . 
				$this->Request["ticket"], "a5");
	}
}
?>