extends Control

@onready var to_do_items_container: VBoxContainer = $"ToDoPanel/ToDoItems Container"

# task list -> object
var task_list:Dictionary[String, ToDoItem] = {}

const TO_DO_ITEM = preload("res://Components/UI/ToDoItem.tscn")

func _ready() -> void:
    SignalBus.connect("add_task", _add_task)
    SignalBus.connect("complete_task", _complete_task)
    SignalBus.connect("clear_completed_tasks", _clear_completed_tasks)

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
