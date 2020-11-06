extends Node2D

const MoveTimeTimer = preload("res://Scripts/Time/MoveTimeTimer.gd")

onready var _beam:Area2D = $Beam
onready var _label:Label = $Label
onready var _label2:Label = $Label2

const _TIME_FROZEN_MULTIPLIER:float = 0.1
const _ACTIVE_TIME_SECONDS:int = 1
const _INACTIVE_TIME_SECONDS:int = 2

var _timer = MoveTimeTimer.new(1, _TIME_FROZEN_MULTIPLIER)
# Used for proper display/counting: active = 1s, inactive = 2s, timer = 1s
var _current_state_seconds:int = 0

func _ready():
	# Turn off
	_toggle_beam()
	
	# Display upright if rotated
	_label.set_rotation(-self.rotation)
	# repositioning magic, derived by experimenation
	if self.rotation != 0: _label.margin_top += $Receptacle1/ColorRect.margin_right
	
	add_child(_timer)
	_timer.connect("on_tick", self, "_on_timer_tick")

func _toggle_beam():
	_beam.visible = not _beam.visible
	_beam.monitoring = not _beam.monitoring

func _on_Beam_body_entered(body):
	# shouldn't happen unless we have a bug: redundant check
	if _beam.visible and _should_destroy(body):
		body.queue_free() # DIE!

func _process(delta):
	var remaining = _time_until_toggle_beam()
	var display_time = int(stepify(remaining, 0.1) * 10)
	_label.text = str(display_time)
	_label2.text = _label.text

func _on_timer_tick():
	_current_state_seconds += 1
	if _time_until_toggle_beam() <= 0:
		_toggle_beam()
		_current_state_seconds = 0
		
func _should_destroy(body) -> bool:
	return body is KinematicBody2D

# Returns fractional seconds left until switch
func _time_until_toggle_beam() -> float:
	var which_time:float
	if _beam.visible:
		which_time = _ACTIVE_TIME_SECONDS
	else:
		which_time = _INACTIVE_TIME_SECONDS

	return which_time - (_timer.elapsed_time + _current_state_seconds)
	
