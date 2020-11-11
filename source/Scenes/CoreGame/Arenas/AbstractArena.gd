extends Node2D

signal wave_ready
signal waves_complete

var _enemies_left = 0
var _current_wave = 1

func _ready():
	for child in get_children():
		if "Wave" in child.name:
			if child.name == "Wave1":
				child.visible = true
			else:
				child.visible = false
	
func add_enemy(enemy) -> void:
	add_child(enemy)
	_enemies_left += 1
	enemy.connect("died", self, "_on_enemy_died")

func start_wave():
	var wave = get_node("Wave" + str(_current_wave))
	for spawn_point in wave.get_children():
		spawn_point.start()
	
func _on_enemy_died():
	_enemies_left -= 1
	_check_start_next_wave()

func _check_start_next_wave() -> void:
	if _enemies_left == 0:
		_current_wave += 1
		var wave = get_node("Wave" + str(_current_wave))
		if wave != null:
			wave.visible  = true
			print("Now on wave " + str(_current_wave))
			emit_signal("wave_ready")
		else:
			emit_signal("waves_complete")
