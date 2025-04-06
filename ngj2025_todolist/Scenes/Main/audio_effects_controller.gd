extends Node

@onready var success: AudioStreamPlayer = $Success
@onready var error: AudioStreamPlayer = $Error
@onready var walk_cycle: AudioStreamPlayer = $"Walk cycle"

func _ready() -> void:
	SignalBus.sfx_walk_play.connect(_walk_start)
	SignalBus.sfx_walk_stop.connect(_walk_stop)
	SignalBus.sfx_success.connect(_play_success)
	SignalBus.sfx_error.connect(_play_error)

func _walk_start():
	walk_cycle.play()

func _walk_stop():
	walk_cycle.stop()

func _play_success():
	success.play()

func _play_error():
	error.play()
