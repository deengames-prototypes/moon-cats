extends KinematicBody2D

const _SPEED = 80
var _target:Node2D

func _ready():
	print(str(self) + " is at " + str(self.position))
	var players = get_tree().get_nodes_in_group("Player")
	assert(len(players) <= 1)
	if len(players) == 1:
		var player = players[0]
		_target = player

func _physics_process(_delta):
	if _target != null and Globals.is_player_moving:
		var direction = (_target.position - self.position).normalized()
		var move = direction * _SPEED
		self.move_and_slide(move)
		print(str(self) + " moved to " + str(self.position))
