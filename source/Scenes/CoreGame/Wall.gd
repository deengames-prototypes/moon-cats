extends StaticBody2D

onready var _collision_shape = $CollisionShape2D
onready var _rect = $NinePatchRect

var _width:int = Constants.WALL_SIZE
var _height:int = Constants.WALL_SIZE

func _ready():
	_collision_shape.shape = _collision_shape.shape.duplicate() # make unique

func resize(width:int, height:int) -> void:
	self._width = width
	self._height = height
	
	var shape = (_collision_shape.shape as RectangleShape2D)
	shape.extents = Vector2(_width / 2, _height / 2)
	_collision_shape.position = shape.extents
	_rect.margin_right = _width
	_rect.margin_bottom = _height
