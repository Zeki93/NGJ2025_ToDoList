extends Task

class_name Bed

@export var sleepRecovery = 70

func _ready() -> void:
	task_name = "Go to sleep"

func do_task():
	SignalBus.go_to_sleep.emit(sleepRecovery)
	SignalBus.ui_complete_task.emit(task_name)
