extends Node

signal new_energy_level(new_energy:int)
signal energy_level_update(energy_delta:int)

signal go_to_sleep(new_energy:int)
signal on_sleeptransition_finished()
signal wake_up()

signal taskcontroller_go_to_sleep()
signal taskcontroller_do_task(task: Task)
signal taskcontroller_add_random_task()
signal taskcontroller_complete_task(task_name: String)

signal ui_task_added(task_name:String)
signal ui_complete_task(task_name: String)
signal ui_clear_completed_tasks()

signal win_game()
signal loose_game()

#Audio
signal sfx_walk_play
signal sfx_walk_stop
signal sfx_success
signal sfx_error
