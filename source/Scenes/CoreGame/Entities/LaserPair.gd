extends Node2D

onready var _beam:Area2D = $Beam
onready var _label:Label = $Label
onready var _label2:Label = $Label2

const _SLOW_MOTION_MULTIPLIER:int = 10
const _ACTIVE_TIME_SECONDS:int = 1
const _INACTIVE_TIME_SECONDS:int = 2

var _accumulator:float = 0

func _ready():
	# turn off
	_toggle_beam()

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
	
	var which_time:float
	if _beam.visible:
		which_time = _ACTIVE_TIME_SECONDS
	else:
		which_time = _INACTIVE_TIME_SECONDS
		
	if _accumulator >= which_time:
		_accumulator -= which_time
		_toggle_beam()
		
	_label.text = str(int(stepify(which_time - _accumulator, 0.1) * 10))
	_label2.text = _label.text

func _should_destroy(body) -> bool:
	return body is KinematicBody2D
