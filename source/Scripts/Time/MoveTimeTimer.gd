extends Node

signal on_tick

export var interval_seconds:float = 1.0
export var slow_motion_multiplier:float = 0.25

var elapsed_time:float = 0
var _is_running:bool = false

func _init(interval_seconds:float, slow_motion_multiplier:float):
	self.interval_seconds = interval_seconds
	self.slow_motion_multiplier = slow_motion_multiplier

func start():
	_is_running = true
	elapsed_time = 0
	
func stop():
	_is_running = false

func _process(delta):
	if _is_running:
		var elapsed = delta
		
		if not Globals.is_player_moving:
			elapsed *= slow_motion_multiplier

		elapsed_time += elapsed
		
		if elapsed_time >= interval_seconds:
			elapsed_time -= interval_seconds
			emit_signal("on_tick")
