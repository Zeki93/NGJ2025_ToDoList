extends Node

signal new_energy_level(new_energy:int)
signal energy_level_update(energy_delta:int)

signal add_task(task_name:String)
signal complete_task(task_name: String)
signal clear_completed_tasks()
