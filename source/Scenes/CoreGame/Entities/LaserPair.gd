extends Node2D

onready var _beam:Area2D = $Beam
onready var _label:Label = $Label
onready var _label2:Label = $Label2

const _SLOW_MOTION_MULTIPLIER:int = 10
const _CYCLE_TIME_SECONDS:int = 1

var _accumulator:float = 0

func _ready():
	# turn off
	_toggle_beam()
	_label.set_rotation(-self.rotation)

func _toggle_beam():
	_beam.visible = not _beam.visible
	_beam.monitoring = not _beam.monitoring

func _on_Beam_body_entered(body):
	# shouldn't happen unless we have a bug: redundant check
	if _beam.visible and _should_destroy(body):
		body.queue_free() # DIE!

func _process(delta):
	var elapsed_time = delta
	
	if not Globals.is_player_moving:
		elapsed_time /= _SLOW_MOTION_MULTIPLIER

	_accumulator += elapsed_time
	if _accumulator >= _CYCLE_TIME_SECONDS:
		_accumulator -= _CYCLE_TIME_SECONDS
		_toggle_beam()
		
	_label.text = str(int(stepify(_CYCLE_TIME_SECONDS - _accumulator, 0.1) * 10))
	_label2.text = _label.text

func _should_destroy(body) -> bool:
	return body is KinematicBody2D
