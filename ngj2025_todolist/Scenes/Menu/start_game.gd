extends Button

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
	GlobalConfig.playerEnergy = GlobalConfig.playerStartEnergy
	SignalBus.new_energy_level.emit(GlobalConfig.playerStartEnergy)
