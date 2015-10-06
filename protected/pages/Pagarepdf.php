<?php
include_once('../compartidos/clases/usadompdf.php');

class Pagarepdf extends TPage
{
	public function onLoad($param)
	{
		parent::onLoad($param);

		usadompdf::creapdf("http://" . $_SERVER["HTTP_HOST"] 
				. $_SERVER["PHP_SELF"] . "?page=pagare&nota=" . 
				$this->Request["nota"], "a5", "landscape");
	}
}
?>