extends Node

@onready var greenPart = $GreenPart

func _ready() -> void:
	SignalBus.new_energy_level.connect(_on_new_energy_level)
	
func _on_new_energy_level(energy):
	show_energy(energy)
	
func show_energy(energy):
	greenPart.set_size(Vector2(40, energy * 3))
	return
