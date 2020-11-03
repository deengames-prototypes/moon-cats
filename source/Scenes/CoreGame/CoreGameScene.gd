extends Node2D

const Wall = preload("res://Scenes/CoreGame/Wall.tscn")

func _ready():
	_create_border_walls()

func _create_border_walls():
	var w1 = Wall.instance()
	add_child(w1)
	w1.resize(1280, 32)
	
	var w2 = Wall.instance()
	add_child(w2)
	w2.resize(1280, 32)
	w2.position = Vector2(0, 720 - 32)
	
	var w3 = Wall.instance()
	add_child(w3)
	w3.resize(32, 720 - 64)
	w3.position = Vector2(0, 32)
	
	var w4 = Wall.instance()
	add_child(w4)
	w4.resize(32, 720 - 64)
	w4.position = Vector2(1280 - 32, 32)
