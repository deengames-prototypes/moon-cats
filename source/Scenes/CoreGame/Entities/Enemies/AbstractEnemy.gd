extends KinematicBody2D

var target:Node2D
var health:int = 1

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	assert(len(players) <= 1)
	if len(players) == 1:
		var player = players[0]
		target = player
		
func on_shot():
	self.health -= 1
	if self.health <= 0:
		self.queue_free()
