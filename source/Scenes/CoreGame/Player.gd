extends KinematicBody2D

const _SPEED:int = 100

func _physics_process(delta):
	var velocity:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
	
	self.move_and_collide(velocity.normalized() * _SPEED * delta)
