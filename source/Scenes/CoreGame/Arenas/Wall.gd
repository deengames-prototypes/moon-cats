tool
extends StaticBody2D

export var width:int = 0 setget set_width, get_width
export var height:int = 0 setget set_height, get_height
var _width:int
var _height:int 

func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new() # not shared by instances
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
	
func _resize_me() -> void:
	if $ColorRect != null:
		$ColorRect.margin_right = _width
		$ColorRect.margin_bottom = _height
	if $CollisionShape2D != null:
		$CollisionShape2D.shape.extents = Vector2(_width / 2, _height / 2)
		$CollisionShape2D.position = Vector2(_width / 2, _height / 2) 
