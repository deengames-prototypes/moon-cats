extends Node2D

const Chaser = preload("res://Scenes/CoreGame/Entities/Enemies/Chaser.tscn")
const MoveTimeTimer = preload("res://Scripts/Time/MoveTimeTimer.gd")

const _SPAWN_EVERY_SECONDS:float = 1.0

var _timer = MoveTimeTimer.new(_SPAWN_EVERY_SECONDS, 0)
var _spawn_left = 10

func _ready():
	_timer.connect("on_tick", self, "_on_timer_tick")
	add_child(_timer)
	$Label.text = str(_spawn_left)
	
func _on_timer_tick():
	if _spawn_left > 0:
		_spawn_left -= 1
		var chaser = Chaser.instance()
		self.get_parent().add_child(chaser)
		chaser.position = self.position
		$Label.text = str(_spawn_left)
	else:
		_timer.queue_free()
		$Label.queue_free()
		$Particles2D.emitting = false
