extends Node2D

export var velocity:Vector2

const _SPEED:int = 500
const _SLOW_MOTION_MULTIPLIER:float = 0.02

var _player:KinematicBody2D

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	assert(len(players) <= 1)
	_player = players[0]

func _process(delta):
	var move_by:float = delta * _SPEED
	
	if not Globals.is_player_moving:
		move_by *= _SLOW_MOTION_MULTIPLIER
		
	self.position += velocity * move_by

func _on_Bullet_body_entered(body):
	if body != _player: 
		if body.has_method("on_shot"):
			body.on_shot()
		self.queue_free()
