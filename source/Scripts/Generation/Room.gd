extends Node

var exits = [] # N/S/E/W

#var tile_x:int = 0
#var tile_y:int = 0

#func _init(tile_x:int, tile_y:int):
#	self.tile_x = tile_x
#	self.tile_y = tile_y

func has_exits():
	return len(exits) > 0

func add_exit(exit:String) -> void:
	if exit != "N" and exit != "S" and exit != "W" and exit != "E":
		push_error("Can't add invalid exit: " + exit)
	else:
		exits.append(exit)
