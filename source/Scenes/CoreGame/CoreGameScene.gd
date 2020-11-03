extends Node2D

const Wall = preload("res://Scenes/CoreGame/Wall.tscn")

func _ready():
	# These go last, on top of everything, so you can't walk off-map
	_create_border_walls()

func _create_border_walls():
	# Inner wall, takes up 32px inside on each side of the map
	var w1 = Wall.instance()
	add_child(w1)
	w1.resize(Constants.MAP_WIDTH, Constants.WALL_SIZE)
	
	var w2 = Wall.instance()
	add_child(w2)
	w2.resize(Constants.MAP_WIDTH, Constants.WALL_SIZE)
	w2.position = Vector2(0, Constants.MAP_HEIGHT - Constants.WALL_SIZE)
	
	var w3 = Wall.instance()
	add_child(w3)
	w3.resize(Constants.WALL_SIZE, Constants.MAP_HEIGHT - (2 * Constants.WALL_SIZE))
	w3.position = Vector2(0, Constants.WALL_SIZE)
	
	var w4 = Wall.instance()
	add_child(w4)
	w4.resize(Constants.WALL_SIZE, Constants.MAP_HEIGHT - (2 * Constants.WALL_SIZE))
	w4.position = Vector2(1280 - Constants.WALL_SIZE, Constants.WALL_SIZE)
