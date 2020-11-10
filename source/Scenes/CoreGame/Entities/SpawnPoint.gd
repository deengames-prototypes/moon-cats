extends Node2D

const Chaser = preload("res://Scenes/CoreGame/Entities/Enemies/Chaser.tscn")
const Gunner = preload("res://Scenes/CoreGame/Entities/Enemies/Gunner.tscn")
const MoveTimeTimer = preload("res://Scripts/Time/MoveTimeTimer.gd")

export var to_spawn = 10

const _SPAWN_EVERY_SECONDS:float = 1.0

var _timer = MoveTimeTimer.new(_SPAWN_EVERY_SECONDS, 0)

func _ready():
	_timer.connect("on_tick", self, "_on_timer_tick")
	add_child(_timer)
	$Label.text = str(to_spawn)

func start():
	_timer.start()	
	
func _on_timer_tick():
	if to_spawn > 0:
		to_spawn -= 1
		# TODO: intelligent selection baed on wave number
		
		var enemy:KinematicBody2D
		if randf() <= 0.7:
			enemy  = Chaser.instance()
		else:
			enemy = Gunner.instance()
			
		# TODO: broadcast event, parent re-broadcasts event
		self.get_parent().get_parent().add_enemy(enemy)
		enemy.position = self.position
		$Label.text = str(to_spawn)
	else:
		_timer.stop()
		$Label.text = ""
		$Particles2D.emitting = false
