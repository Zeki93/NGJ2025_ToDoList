extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var anamiation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	anamiation_player.animation_finished.connect(on_animiation_finished)
	pass

func transition():
	color_rect.visible = true
	anamiation_player.play("fade_to_black")

func _process(delta: float):
	pass

func on_animiation_finished(animation_name):
	if(animation_name == "fade_to_black"):
		anamiation_player.play("fade_to_normal")
	elif(animation_name == "fade_to_normal"):
		SignalBus.on_sleeptransition_finished.emit()
		color_rect.visible = false
	pass
