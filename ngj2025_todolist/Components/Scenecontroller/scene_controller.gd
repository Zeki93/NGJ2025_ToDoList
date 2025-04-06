extends Node3D

func _ready() -> void:
	SignalBus.win_game.connect(on_win_game)
	SignalBus.loose_game.connect(on_loose_game)

func on_loose_game():
	get_tree().change_scene_to_file("res://Scenes/Menu/GameOver_Loose.tscn")
	pass

func on_win_game():
	get_tree().change_scene_to_file("res://Scenes/Menu/GameOver_Win.tscn")
	pass
