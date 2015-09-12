<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Productos extends TActiveRecord 
{
    const TABLE = 'productos';
 
    public $id_producto; 
    public $codigo;
	public $descripcion;
	public $precio;
}
?>