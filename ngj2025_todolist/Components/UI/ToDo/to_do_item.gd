extends RichTextLabel

class_name ToDoItem

@export var completed:bool = false

func set_completed():
	self.text = "[i][s]" + self.text + '[/s][/i]'
	self.completed = true
	pass
