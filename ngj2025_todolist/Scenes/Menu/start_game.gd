extends Button

func _on_pressed():
	print_debug("Pressed Start")
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
