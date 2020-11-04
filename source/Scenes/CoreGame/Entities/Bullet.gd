extends Node2D

const _SPEED:int = 500
export var velocity:Vector2

func _process(delta):
	var move_by:float = delta * _SPEED
	
	if not Globals.is_player_moving:
		move_by /= 50
		
	self.position += velocity * move_by
