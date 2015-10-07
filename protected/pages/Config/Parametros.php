<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Parametros extends TActiveRecord 
{
    const TABLE = 'parametros';
 
    public $llave;
    public $valor;
}
?>