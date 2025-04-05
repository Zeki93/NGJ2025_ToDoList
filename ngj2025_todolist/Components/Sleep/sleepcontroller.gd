extends Node3D

var playerEnergy = 0
@export var tiredNess = 0.1
@export var energyRecoveryOnFloor = 50

func _ready() -> void:
	SignalBus.new_energy_level.connect(_on_new_energy_level)
	SignalBus.energy_level_update.connect(_on_energy_level_update)
	SignalBus.new_energy_level.emit(100)
	pass

func _process(delta: float) -> void:
	pass

func _on_energy_level_update(energyDelta):
	playerEnergy += energyDelta
	if(playerEnergy < 0):
		SignalBus.go_to_sleep.emit(energyRecoveryOnFloor)
		pass

func _on_new_energy_level(energy):
	playerEnergy = energy

func _on_timer_timeout() -> void:
	SignalBus.energy_level_update.emit(-tiredNess)
	pass # Replace with function body.
