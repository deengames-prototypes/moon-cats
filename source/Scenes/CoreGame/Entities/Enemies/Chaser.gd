extends 'res://Scenes/CoreGame/Entities/Enemies/AbstractEnemy.gd'

const _SPEED = 80

func _physics_process(_delta):
	if self.target != null and Globals.is_player_moving:
		var direction = (self.target.global_position - self.global_position).normalized()
		var move = direction * _SPEED
		self.move_and_slide(move)
