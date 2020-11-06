extends Node2D

const Chaser = preload("res://Scenes/CoreGame/Entities/Enemies/Chaser.tscn")

func generate_enemies():
	# TODO: this depends on difficulty/enemies passed in
	
	for spawn_point in $SpawnPoints.get_children():
		if randf() < 0.6:
			var enemy = Chaser.instance()

			if "margin_left" in spawn_point:
				enemy.position = Vector2(spawn_point.margin_left, spawn_point.margin_top)
			else:
				enemy.position = spawn_point.position

			add_child(enemy)
			
		spawn_point.queue_free()
