extends Node3D

var task_arena = []

func _ready():
	#take all children
	#put them in the arena
	#remove them all from the tree

func add_task():
	# take a random from the arena
	add_child(task)
	task_arena.remove(task)

func complete_task(task_name):
	#take the child in the arena
	#remove child from tree
