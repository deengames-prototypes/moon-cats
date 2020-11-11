extends Node2D

onready var _arena:Node2D = $Arena
onready var _blackout:ColorRect = $Blackout
onready var _boosts:Control = $UI/Boosts
onready var _start_wave_button:Button = $UI/StartWaveButton

func _on_Arena_wave_ready():
	_boosts.visible = true

func _on_Arena_waves_complete():
	print("YOU WIN!!")
	$Blackout.color.a = 1

func _on_StartWaveButton_pressed():
	_arena.start_wave()
	_start_wave_button.visible = false

func _on_Boost1_pressed():
	_on_picked_boost(0)

func _on_Boost2_pressed():
	_on_picked_boost(1)

func _on_Boost3_pressed():
	_on_picked_boost(2)

func _on_picked_boost(which:int) -> void:
	print("Picked boost " + str(which))
	_boosts.visible = false
	_start_wave_button.visible = true
