extends Node

var _exits = [] # N/S/E/W

#var tile_x:int = 0
#var tile_y:int = 0

#func _init(tile_x:int, tile_y:int):
#	self.tile_x = tile_x
#	self.tile_y = tile_y

func has_exits():
	return len(_exits) > 0

func open_exits(open_section):
	if not has_exits():
		push_error("Can't open exits if there are none!")
	else:
		for exit in _exits:
			open_section.get_node("Walls/" + exit).queue_free()

func add_exit(exit:String) -> void:
	if exit != "N" and exit != "S" and exit != "W" and exit != "E":
		push_error("Can't add invalid exit: " + exit)
	else:
		_exits.append(exit)
