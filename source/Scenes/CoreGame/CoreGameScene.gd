extends Node2D

const MapGenerator = preload("res://Scripts/Generation/MapGenerator.gd")
const TwoDimensionalArray = preload("res://Scripts/TwoDimensionalArray.gd")
const Wall = preload("res://Scenes/CoreGame/Wall.tscn")

const BlockedSection = preload("res://Scenes/CoreGame/BlockedSection.tscn")
const OpenSection = preload("res://Scenes/CoreGame/OpenSection.tscn")

onready var _geometry:Node2D = $Geometry

func _ready():
	var map = MapGenerator.new().generate_map()
	_generate_rooms(map)
	# These go last, on top of everything, so you can't walk off-map
	_create_border_walls()

func _generate_rooms(map:TwoDimensionalArray):
	for y in range(Constants.VERTICAL_SECTIONS):
		for x in range(Constants.HORIZONTAL_SECTIONS):
			var posiiton = Vector2(x, y) * Vector2(Constants.SECTION_WIDTH, Constants.SECTION_HEIGHT)
			var room = map.get_at(x, y)
			
			var instance:Node2D
			if room.has_exits():
				instance = OpenSection.instance()
			else:
				instance = BlockedSection.instance()
			instance.position = posiiton
			_geometry.add_child(instance)
			
func _create_border_walls():
	# Inner wall, takes up 32px inside on each side of the map
	var w1 = Wall.instance()
	_geometry.add_child(w1)
	w1.resize(Constants.MAP_WIDTH, Constants.WALL_SIZE)
	
	var w2 = Wall.instance()
	_geometry.add_child(w2)
	w2.resize(Constants.MAP_WIDTH, Constants.WALL_SIZE)
	w2.position = Vector2(0, Constants.MAP_HEIGHT - Constants.WALL_SIZE)
	
	var w3 = Wall.instance()
	_geometry.add_child(w3)
	w3.resize(Constants.WALL_SIZE, Constants.MAP_HEIGHT - (2 * Constants.WALL_SIZE))
	w3.position = Vector2(0, Constants.WALL_SIZE)
	
	var w4 = Wall.instance()
	_geometry.add_child(w4)
	w4.resize(Constants.WALL_SIZE, Constants.MAP_HEIGHT - (2 * Constants.WALL_SIZE))
	w4.position = Vector2(Constants.MAP_WIDTH - Constants.WALL_SIZE, Constants.WALL_SIZE)
