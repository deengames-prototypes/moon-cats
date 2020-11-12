extends Node2D

onready var _arena:Node2D = $Arena
onready var _blackout:ColorRect = $Blackout
onready var _boosts:Control = $UI/Boosts
onready var _start_wave_button:Button = $UI/StartWaveButton
onready var _boost_buttons = [
	$UI/Boosts/HBoxContainer/Boost1,
	$UI/Boosts/HBoxContainer/Boost2,
	$UI/Boosts/HBoxContainer/Boost3,
]

func _on_Arena_wave_ready():
	_show_boosts()
	
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

func _show_boosts():
	var all_boosts = ["Damage", "FireRate", "MoveSpeed", "ShotSpeed", "Health"]
	all_boosts.shuffle() # randomly assign three to buttons

	for i in range(len(_boost_buttons)):
		var button:Button = _boost_buttons[i]
		var boost_name = all_boosts[i]
		button.icon = load("res://Assets/Images/UI/Boost-" + boost_name + ".png")
		button.text = boost_name

	_boosts.visible = true
	
