extends StaticBody3D

class_name Task

@export var cost = 0
@export var task_name = ""
@export var special = false
var canBeAddedTodo = true

func do_task():
	SignalBus.taskcontroller_do_task.emit(self)
