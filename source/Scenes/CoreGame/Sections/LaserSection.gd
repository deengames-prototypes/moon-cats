extends Node2D

func configure_vertically():
	$Laser1.rotate(PI / 2);
	$Laser2.rotate(PI / 2);
	
	$Laser1.position = Vector2($Laser1.position.y, $Laser1.position.x)
	$Laser2.position = Vector2($Laser2.position.y, $Laser2.position.x)
