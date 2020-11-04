extends Node

const Room = preload("res://Scripts/Generation/Room.gd")
const TwoDimensionalArray = preload("res://Scripts/TwoDimensionalArray.gd")

func generate_map() -> TwoDimensionalArray:
	var to_return = TwoDimensionalArray.new(Constants.HORIZONTAL_SECTIONS, Constants.VERTICAL_SECTIONS)
	
	_fill_map(to_return)
			
	# random walk from start to finish. Shortest path is still quite long because corners are opposites.
	var possibilities = [
		[Vector2(0, 0), Vector2(Constants.HORIZONTAL_SECTIONS - 1, Constants.VERTICAL_SECTIONS - 1)],
		[Vector2(Constants.HORIZONTAL_SECTIONS - 1, 0), Vector2(0, Constants.VERTICAL_SECTIONS - 1)]
	]
	
	var start_and_end = possibilities[randi() % len(possibilities)]
	var start = start_and_end[0]
	var end = start_and_end[1]
	# TODO: room with doors on four sides
	
	# random walk
	var current = start
	while current != end:
		var walkables = _get_walkables(current, to_return)
		if len(walkables) == 0:
			current = start # stuck, start over
		else:
			var next = walkables[randi() % len(walkables)]
			var exit = _exit_from(current, next)
			var opposite = _exit_from(next, current)
			to_return.get_at(current.x, current.y).add_exit(exit)
			to_return.get_at(next.x, next.y).add_exit(opposite)
			current = next
			
	return to_return

func _fill_map(area_map:TwoDimensionalArray) -> void:
	for y in range(Constants.VERTICAL_SECTIONS):
		for x in range(Constants.HORIZONTAL_SECTIONS):
			area_map.set_at(x, y, Room.new())#x, y))
			
func _get_walkables(current:Vector2, map:TwoDimensionalArray) -> Array:
	var to_return = []
	if current.x > 0:
		to_return.append(Vector2(current.x - 1, current.y))
	if current.x < Constants.HORIZONTAL_SECTIONS - 1:
		to_return.append(Vector2(current.x + 1, current.y))
	if current.y > 0:
		to_return.append(Vector2(current.x, current.y - 1))
	if current.y < Constants.VERTICAL_SECTIONS - 1:
		to_return.append(Vector2(current.x, current.y + 1))
	return to_return

func _exit_from(start:Vector2, end:Vector2) -> String:
	if start.x < end.x:
		return "E"
	elif start.x > end.x:
		return "W"
	if start.y < end.y:
		return "S"
	elif start.y > end.y:
		return "N"
		
	push_error("Not sure how to exit from " + str(start) + " to " + str(end))
	return "?"
