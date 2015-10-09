<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Grupos extends TActiveRecord 
{
    const TABLE = 'grupos';
 
	public $id_grupo;
    public $grupo;
	
	public $productos = array();
	
     public static $RELATION=array
     (
        'productos' => array(self::HAS_MANY, 'Productos', 'id_grupo'),
     );
	 
	public static function finder($className=__CLASS__)
	{
			return parent::finder($className);
	}	 
}
?>