extends Node2D

var _enemies_left = 0
var _current_wave = 0

func _ready():
	for child in get_children():
		if "Wave" in child.name:
			child.visible = false
	
	_check_start_next_wave()

func add_enemy(enemy) -> void:
	add_child(enemy)
	_enemies_left += 1
	enemy.connect("died", self, "_on_enemy_died")
	
func _on_enemy_died():
	_enemies_left -= 1
	_check_start_next_wave()

func _check_start_next_wave() -> void:
	if _enemies_left == 0:
		_current_wave += 1
		var wave = get_node("Wave" + str(_current_wave))
		if wave != null:
			wave.visible  = true
			for spawn_point in wave.get_children():
				spawn_point.start()
			_current_wave += 1
			print("Starting wave " + str(_current_wave))
		else:
			print("YOU WIN YAYAYAYYY!Y!!!!1one")
