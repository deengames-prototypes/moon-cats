extends 'res://Scenes/CoreGame/Entities/Enemies/AbstractEnemy.gd'

const Bullet = preload("res://Scenes/CoreGame/Entities/Bullet.tscn")

const _SPEED = 60
const _SHOT_SPEED = 45
const _MAX_DISTANCE = 300 # pixels
const _MIN_DISTANCE = 200 # pixels
const _SECONDS_BETWEEN_SHOTS = 1

var _last_shot_time = -_SECONDS_BETWEEN_SHOTS # start shootable

func _physics_process(_delta):
	if self.target != null and Globals.is_player_moving:
		var direction = (self.target.global_position - self.global_position)
		# Too far, get closer
		if direction.length() > _MAX_DISTANCE:
			var move = direction.normalized() * _SPEED
			self.move_and_slide(move)
		# Too close, RUN AWAY~!
		elif direction.length() < _MIN_DISTANCE:
			var move = -direction.normalized() * _SPEED
			self.move_and_slide(move)
		else:
			var now = Globals.total_movement_time
			var time_since_last_shot = now - _last_shot_time
			if time_since_last_shot >= _SECONDS_BETWEEN_SHOTS:
				_last_shot_time = now
				_fire(direction)


func _fire(velocity:Vector2):
	var instance = Bullet.instance()
	instance.shooter = self
	instance.velocity = velocity.normalized()
	instance.position = self.position + (velocity.normalized() * _SHOT_SPEED)
	get_parent().add_child(instance)
