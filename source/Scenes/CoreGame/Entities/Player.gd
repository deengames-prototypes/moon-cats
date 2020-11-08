extends KinematicBody2D

const Bullet = preload("res://Scenes/CoreGame/Entities/Bullet.tscn")

const _SPEED:int = 100
const _SECONDS_BETWEEN_SHOTS:float = 0.3

var _facing:String = "right"
var _last_shot_time = 0

var _facing_vectors = {
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)
}

func _ready():
	$ReloadBar.max_value = _SECONDS_BETWEEN_SHOTS
	add_to_group("Player")

func _physics_process(delta):
	
	var velocity:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		_facing = "up"
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
		_facing = "down"
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		_facing = "left"
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		_facing = "right"
	
	self.move_and_slide(velocity.normalized() * _SPEED)
	if velocity != Vector2.ZERO:
		Globals.is_player_moving = true
		Globals.total_movement_time += delta
	else:
		Globals.is_player_moving = false
	
	var now = Globals.total_movement_time
	var time_since_last_shot = now - _last_shot_time
	$ReloadBar.value = time_since_last_shot
	
	if Input.is_action_pressed("ui_accept") and time_since_last_shot >= _SECONDS_BETWEEN_SHOTS:
		if velocity == Vector2.ZERO:
			velocity = _facing_vectors[_facing]
		self._fire(velocity)
		self._last_shot_time = now
	
func _fire(velocity:Vector2):
	var instance = Bullet.instance()
	instance.velocity = velocity.normalized()
	instance.position = self.position + (velocity.normalized() * 32)
	get_parent().add_child(instance)
