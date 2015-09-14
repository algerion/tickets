<?php
include_once('../compartidos/clases/usadompdf.php');

class Notapdf extends TPage
{
	public function onLoad($param)
	{
		parent::onLoad($param);

		usadompdf::creapdf("http://" . $_SERVER["HTTP_HOST"] . $_SERVER["PHP_SELF"] . "?page=nota&nota=" . $this->Request["nota"], "a5");
/*		foreach($_SERVER as $k=>$s)
			echo $k . "=>" . $s . "<br />";*/
	}
}
?>