extends Node3D

var task_arena = []

func _ready():
	SignalBus.taskcontroller_add_random_task.connect(add_random_task)
	SignalBus.complete_task.connect(complete_task)
	
	for child in self.get_children():
		task_arena.push_front(child)
		remove_child(child)
	add_random_task()

func add_random_task():
	if(!task_arena.is_empty()):
		task_arena.shuffle()
		var task = task_arena.pop_front()
		add_child(task)
		SignalBus.task_added.emit(task.task_name)
	

func complete_task(task_name):
	for child: Task in self.get_children():
		if child.task_name == task_name:
			remove_child(child)
