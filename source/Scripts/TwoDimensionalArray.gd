extends Node

var width = 0
var height = 0
var _data = [] # Simplest is best. One-dimensional array of length w * h

func _init(width, height):
	self._data = []
	self.width = width
	self.height = height

	# Initialize array with nulls
	for i in range(self.width * self.height):
		self._data.append(null)

func to_dict():
	return {
		"filename": "res://Scripts/TwoDimensionalArray.gd",
		"width": self.width,
		"height": self.height,
		"data": self._data
	}

func has(x, y):
	var index = self._get_index(x, y)
	return index < self._data.size() and self._data[index] != null

func get_at(x, y):
	var index = self._get_index(x, y)
	if index < len(self._data):
		return self._data[index]
	else:
		return null

func set_at(x, y, item):
	var index = self._get_index(x, y)
	self._data[index] = item

func find(item):
	var index = self._data.find(item)
	if index > -1:
		var x = index % self.width
		var y = int(index / self.width)
		return Vector2(x, y)
	else:
		return null # not found

func _get_index(x, y):
	return (y * self.width) + x
