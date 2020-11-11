extends Node2D

onready var _arena = $Arena
onready var _start_wave_button:Button = $UI/StartWaveButton
onready var _blackout:ColorRect = $Blackout

func _on_Arena_wave_ready():
	_start_wave_button.visible = true

func _on_Arena_waves_complete():
	print("YOU WIN!!")
	$Blackout.color.a = 1

func _on_StartWaveButton_pressed():
	_arena.start_wave()
	_start_wave_button.visible = false
