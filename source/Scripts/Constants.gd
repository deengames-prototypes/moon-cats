extends Node

const SECTION_WIDTH:int = 576
const SECTION_HEIGHT:int = 576

const HORIZONTAL_SECTIONS:int = 5
const VERTICAL_SECTIONS:int = 5

const MAP_WIDTH:int = SECTION_WIDTH * HORIZONTAL_SECTIONS
const MAP_HEIGHT:int = SECTION_HEIGHT * VERTICAL_SECTIONS

func _ready():
	randomize()
