extends Node3D

var allTaskArray = []
var currentTaskArray = []
var completedSpecialTasks = 0

var days = 1
var peneltyCost = 10

func _ready():
	SignalBus.taskcontroller_add_random_task.connect(add_random_task)
	SignalBus.taskcontroller_complete_task.connect(complete_task)
	SignalBus.taskcontroller_do_task.connect(do_task)
	SignalBus.taskcontroller_go_to_sleep.connect(on_go_to_sleep)
	
	for child: Task in self.get_children():
		if(child.canBeAddedTodo):
			allTaskArray.push_front(child)
	
	for i in range (3):
		add_random_task()

func on_go_to_sleep():
	days += 1
	if(currentTaskArray.size() >= GlobalConfig.uncompletedTasksToLoose):
		SignalBus.loose_game.emit()
	else:
		for i in range (days):
			add_random_task()
			SignalBus.ui_clear_completed_tasks.emit()

func add_random_task():
	if(!allTaskArray.is_empty()):
		allTaskArray.shuffle()
		var task = allTaskArray.pop_front()
		currentTaskArray.push_front(task)
		SignalBus.ui_task_added.emit(task.task_name)

func do_task(task):
	for taskInTodo: Task in currentTaskArray:
		if taskInTodo.task_name == task.task_name:
			GlobalConfig.playerEnergy -= task.cost
			SignalBus.new_energy_level.emit(GlobalConfig.playerEnergy)
			complete_task(taskInTodo)
			return
	GlobalConfig.playerEnergy -= peneltyCost
	SignalBus.new_energy_level.emit(GlobalConfig.playerEnergy)

func complete_task(task):
	currentTaskArray.erase(task)
	SignalBus.ui_complete_task.emit(task.task_name)
	if(task.special): 
		completedSpecialTasks+= 1
	if(GlobalConfig.completedTasksToWin >= 3 && currentTaskArray.size() == 0):
		SignalBus.win_game.emit()
