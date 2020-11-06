extends Node

signal on_tick

export var interval_seconds:float = 1.0
export var slow_motion_multiplier:float = 0.25

var elapsed_time:float = 0

func _init(interval_seconds:float, slow_motion_multiplier:float):
	self.interval_seconds = interval_seconds
	self.slow_motion_multiplier = slow_motion_multiplier

func _process(delta):
	var elapsed = delta
	
	if not Globals.is_player_moving:
		elapsed *= slow_motion_multiplier

	elapsed_time += elapsed
	
	if elapsed_time >= interval_seconds:
		elapsed_time -= interval_seconds
		emit_signal("on_tick")
