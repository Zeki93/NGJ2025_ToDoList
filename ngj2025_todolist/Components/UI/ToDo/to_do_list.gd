extends Control

@onready var to_do_items_container: VBoxContainer = $"ToDoPanel/MarginContainer/ToDoItems Container"

# task list -> object
var task_list:Dictionary[String, ToDoItem] = {}

const TO_DO_ITEM = preload("res://Components/UI/ToDo/ToDoItem.tscn")

func _ready() -> void:
	SignalBus.connect("ui_task_added", _add_task)
	SignalBus.connect("ui_complete_task", _complete_task)
	SignalBus.connect("ui_clear_completed_tasks", _clear_completed_tasks)
	_add_task("Go to sleep")
	
func _add_task(task_name:String):
	if task_list.has(task_name):
		return
	var new_task:ToDoItem = TO_DO_ITEM.instantiate()
	new_task.text = task_name
	
	task_list[task_name] = new_task
	to_do_items_container.add_child(new_task)
	return

func _complete_task(task_name:String):
	if !task_list.has(task_name): return
	task_list[task_name].set_completed()
	return

func _clear_completed_tasks():
	for task in task_list.keys():
		if task_list[task].completed:
			task_list[task].queue_free()
			task_list.erase(task)
	return
