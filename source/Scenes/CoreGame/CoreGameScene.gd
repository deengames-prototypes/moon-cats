extends Node2D

const MapGenerator = preload("res://Scripts/Generation/MapGenerator.gd")
const TwoDimensionalArray = preload("res://Scripts/TwoDimensionalArray.gd")

const BlockedSection = preload("res://Scenes/CoreGame/Sections/BlockedSection.tscn")
const LaserSection = preload("res://Scenes/CoreGame/Sections/LaserSection.tscn")
const OpenSection = preload("res://Scenes/CoreGame/Sections/OpenSection.tscn")

onready var _geometry:Node2D = $Geometry
onready var _player:Node2D = $Player

func _ready():
	# TODO: this makes difficulty spikes (super long path vs. short path).
	# This is partly mitigated by non-longest paths to victory, but that's not deterministic.

	# We need to have more fine-grained control over the number of open rooms...
	# OR: make some rooms easy, bonus/beneficial, etc. instead.
	# OR: use a different room as the end-room to control the length.
	var map_data = MapGenerator.new().generate_map()
	assert(len(map_data) == 3)
	
	var map:TwoDimensionalArray = map_data[0]
	var start:Vector2 = map_data[1]
	var end:Vector2 = map_data[2]
	
	var start_pixels = start * Vector2(Constants.SECTION_WIDTH, Constants.SECTION_HEIGHT)
	_player.position = start_pixels + Vector2(Constants.SECTION_WIDTH / 2, Constants.SECTION_HEIGHT / 2)
	
	_generate_rooms(map, start)

func _generate_rooms(map:TwoDimensionalArray, start:Vector2):
	for y in range(Constants.VERTICAL_SECTIONS):
		for x in range(Constants.HORIZONTAL_SECTIONS):
			var posiiton = Vector2(x, y) * Vector2(Constants.SECTION_WIDTH, Constants.SECTION_HEIGHT)
			var room = map.get_at(x, y)
			
			var instance:Node2D
			if room.has_exits():
				# TEMP DEBUG TODO HERP DERP LOLWUT
				if Vector2(x, y) == start:
					instance = LaserSection.instance()
				else:
					instance = OpenSection.instance()
				room.open_exits(instance)
			else:
				instance = BlockedSection.instance()
			instance.position = posiiton
			_geometry.add_child(instance)
			
