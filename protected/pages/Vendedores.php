<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Vendedores extends TActiveRecord 
{
    const TABLE = 'vendedores';
 
    public $id_vendedor; 
    public $nombre;
	public $activo;
}
?>