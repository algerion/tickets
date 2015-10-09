<?php
Prado::using('System.Data.ActiveRecord.*'); 

class Productos extends TActiveRecord 
{
    const TABLE = 'productos';
 
    public $id_producto;
	protected $id_grupo;
    public $codigo;
	public $descripcion;
	public $precio;
	
	public $grupo;
	
     public static $RELATION=array
     (
         'grupo' => array(self::BELONGS_TO, 'Grupos', 'id_grupo'),
     );
	 
	public static function finder($className=__CLASS__)
	{
			return parent::finder($className);
	}
}
?>