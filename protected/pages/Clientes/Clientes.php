<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Clientes extends TActiveRecord 
{
    const TABLE = 'clientes';
 
    public $id_cliente; 
    public $nombre;
}
?>