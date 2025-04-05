extends StaticBody3D

class_name Task

@export var cost = 0
@export var task_name = ""

func do_task():
	if(cost <= GlobalConfig.playerEnergy):
		GlobalConfig.playerEnergy -= cost
		SignalBus.new_energy_level.emit(GlobalConfig.playerEnergy)
		SignalBus.complete_task.emit(self.task_name)
		print_debug("Task done!")
	else:
		print_debug("Not enough energy: I'm too tired")
