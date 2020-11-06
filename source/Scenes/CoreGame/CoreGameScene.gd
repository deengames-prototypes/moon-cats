extends Node2D

const MapGenerator = preload("res://Scripts/Generation/MapGenerator.gd")
const TwoDimensionalArray = preload("res://Scripts/TwoDimensionalArray.gd")

const BlockedSection = preload("res://Scenes/CoreGame/Sections/BlockedSection.tscn")
const LaserSection = preload("res://Scenes/CoreGame/Sections/LaserSection.tscn")
const OpenSection = preload("res://Scenes/CoreGame/Sections/OpenSection.tscn")

const Chaser = preload("res://Scenes/CoreGame/Entities/Enemies/Chaser.tscn")

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
	
	_generate_rooms(map)

func _generate_rooms(map:TwoDimensionalArray):
	for y in range(Constants.VERTICAL_SECTIONS):
		for x in range(Constants.HORIZONTAL_SECTIONS):
			var section_position = Vector2(x, y) * Vector2(Constants.SECTION_WIDTH, Constants.SECTION_HEIGHT)
			var room = map.get_at(x, y)
			
			var section:Node2D
			if room.has_exits():
				# TEMP DEBUG TODO HERP DERP LOLWUT
				if randf() < 0.5:
					section = LaserSection.instance()
					if randf() < 0.5:
						section.rotation_degrees = 90
				else:
					section = OpenSection.instance()
				
				if room.has_exits():
					room.open_exits(section)
					var enemy = Chaser.instance()
					self._position_in_section(enemy, section_position)
					add_child(enemy)
			else:
				section = BlockedSection.instance()
				
			section.position = section_position
			_geometry.add_child(section)
			
func _position_in_section(enemy:KinematicBody2D, section_position:Vector2) -> void:
	var enemy_size = 32 # TODO: get from sprite
	var edge_buffer = 8 # Don't spawn right on the edges
	var available_width = Constants.SECTION_WIDTH - enemy_size - edge_buffer
	var available_height = Constants.SECTION_HEIGHT - enemy_size - edge_buffer
	
	var rand_x = randi() % available_width
	var rand_y = randi() % available_height
	
	# Position inside only
	enemy.position = section_position + Vector2(edge_buffer + rand_x, edge_buffer + rand_y)
