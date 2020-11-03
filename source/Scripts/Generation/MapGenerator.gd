extends Node

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
	to_return.set_at(start.x, start.y, 'room')
	to_return.set_at(end.x, end.y, 'room')
	print("start at " + str(start))
	
	# random walk
	var current = start
	while current != end:
		var walkables = _get_walkables(current, to_return)
		if len(walkables) == 0:
			current = start # stuck, start over
			print('stuck')
		else:
			var next = walkables[randi() % len(walkables)]
			current = next
			to_return.set_at(current.x, current.y, 'room')
			print("move to " + str(current))
	return to_return

func _fill_map(map:TwoDimensionalArray) -> void:
	for y in range(Constants.VERTICAL_SECTIONS):
		for x in range(Constants.HORIZONTAL_SECTIONS):
			map.set_at(x, y, 'solid')
			
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
