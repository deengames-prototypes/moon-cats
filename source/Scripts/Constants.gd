extends Node

const WALL_SIZE:int = 32
const MAP_WIDTH:int = 1280
const MAP_HEIGHT:int = 256 * 3
const HORIZONTAL_SECTIONS:int = 5
const VERTICAL_SECTIONS:int = 3

func _ready():
	randomize()
