extends KinematicBody2D

const Bullet = preload("res://Scenes/CoreGame/Entities/Bullet.tscn")

const _SPEED:int = 100

var _facing:String = "right"

var _facing_vectors = {
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)
}

func _ready():
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
	Globals.is_player_moving = velocity != Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_accept"):
		if velocity == Vector2.ZERO:
			velocity = _facing_vectors[_facing]
		self._fire(velocity)
	
func _fire(velocity:Vector2):
	var instance = Bullet.instance()
	instance.velocity = velocity.normalized()
	instance.position = self.position + (velocity.normalized() * 32)
	get_parent().add_child(instance)
