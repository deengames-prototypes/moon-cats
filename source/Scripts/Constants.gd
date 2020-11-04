extends Node

const WALL_SIZE:int = 32

const SECTION_WIDTH:int = 512
const SECTION_HEIGHT:int = 512

const HORIZONTAL_SECTIONS:int = 5
const VERTICAL_SECTIONS:int = 5

const MAP_WIDTH:int = SECTION_WIDTH * HORIZONTAL_SECTIONS
const MAP_HEIGHT:int = SECTION_HEIGHT * VERTICAL_SECTIONS

func _ready():
	randomize()
