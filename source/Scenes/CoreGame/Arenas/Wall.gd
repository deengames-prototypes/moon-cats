tool
extends StaticBody2D

export var width:int = 0 setget set_width, get_width
export var height:int = 0 setget set_height, get_height
export var health:int = 0 setget set_health, get_health
export var rotation_speed:int = 0

var _width:int
var _height:int 
var _health:int
var _is_ready = false

func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new() # not shared by instances
	_is_ready = true
	_resize_me()

func set_width(w:int) -> void:
	_width = w
	_resize_me()

func set_height(h:int) -> void:
	_height = h
	_resize_me()

func get_width() -> int:
	return _width

func get_height() -> int:
	return _height

func set_health(h:int) -> void:
	_health = h

func get_health() -> int:
	return _health
	
func on_shot():
	if _health != 0: # destrucible
		set_health(_health - 1)
		if _health <= 0:
			queue_free()

func _process(delta):
	if not Engine.editor_hint and rotation_speed > 0:
		var amount = delta * rotation_speed
		if Globals.is_player_moving:
			amount *= 10
		self.rotation_degrees += amount

func _resize_me() -> void:
	if _is_ready:
		if $ColorRect != null:
			$ColorRect.margin_left  = -_width / 2
			$ColorRect.margin_right = _width / 2
			$ColorRect.margin_top = -_height / 2
			$ColorRect.margin_bottom = _height / 2
		if $CollisionShape2D != null:
			$CollisionShape2D.shape.extents = Vector2(_width / 2, _height / 2)
