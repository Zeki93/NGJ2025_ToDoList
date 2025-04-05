extends StaticBody3D

class_name Task

@export var cost = 0
@export var task_name = ""

func do_task():
	print_debug("Task done!")
