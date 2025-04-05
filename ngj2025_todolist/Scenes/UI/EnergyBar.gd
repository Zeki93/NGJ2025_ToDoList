extends Node

@onready var greenPart = $GreenPart

func _ready() -> void:
    SignalBus.new_energy_level.connect(_on_new_energy_level)

func _on_new_energy_level(energy):
    if not greenPart:
        var timer = get_tree().create_timer(.1)
        timer.connect("timeout", _on_new_energy_level(energy))
        return
    greenPart.set_size(Vector2(40, energy * 3))
    return
