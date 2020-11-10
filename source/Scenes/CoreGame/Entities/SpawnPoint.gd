extends Node2D

const Chaser = preload("res://Scenes/CoreGame/Entities/Enemies/Chaser.tscn")
const MoveTimeTimer = preload("res://Scripts/Time/MoveTimeTimer.gd")

const _SPAWN_EVERY_SECONDS:float = 1.0

var _timer = MoveTimeTimer.new(_SPAWN_EVERY_SECONDS, 0)
var to_spawn = 10

func _ready():
	_timer.connect("on_tick", self, "_on_timer_tick")
	add_child(_timer)
	$Label.text = str(to_spawn)
	_timer.start()
	
func _on_timer_tick():
	if to_spawn > 0:
		to_spawn -= 1
		var chaser = Chaser.instance()
		self.get_parent().add_child(chaser)
		chaser.position = self.position
		$Label.text = str(to_spawn)
	else:
		_timer.stop()
		$Label.text = ""
		$Particles2D.emitting = false
