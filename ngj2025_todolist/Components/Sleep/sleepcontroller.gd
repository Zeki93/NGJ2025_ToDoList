extends Node3D

@export var tiredNess = 0.5
@export var energyRecoveryOnFloor = 50
var sleeping = false

func _ready() -> void:
	SignalBus.new_energy_level.connect(_on_new_energy_level)
	SignalBus.go_to_sleep.connect(_on_go_to_sleep)
	SignalBus.on_sleeptransition_finished
	pass

func _process(delta: float) -> void:
	
	pass

func _on_go_to_sleep(energy):
	sleeping = true
	Sleeptransition.transition()
	await SignalBus.on_sleeptransition_finished
	SignalBus.taskcontroller_go_to_sleep.emit()
	SignalBus.new_energy_level.emit(energy)
	SignalBus.wake_up.emit()
	sleeping = false
	pass

func _on_new_energy_level(energy):
	GlobalConfig.playerEnergy = energy
	if(!sleeping):
		if(energy < 0):
			SignalBus.go_to_sleep.emit(energyRecoveryOnFloor)

func _on_timer_timeout() -> void:
	if(!sleeping):
		GlobalConfig.playerEnergy -= tiredNess
		SignalBus.new_energy_level.emit(GlobalConfig.playerEnergy)
