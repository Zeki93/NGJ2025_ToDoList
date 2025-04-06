extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var acceleration = Vector3(0.0, -gravity, 0.0)
@onready var playerController = $PlayerController

@export var ground_drag = 10
@export var air_drag = 2
var sleeping = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SignalBus.go_to_sleep.connect(_on_go_to_sleep)
	SignalBus.wake_up.connect(_on_wake_up)
	SignalBus.loose_game.connect(on_end_game)
	SignalBus.win_game.connect(on_end_game)

func _physics_process(delta):
	if(sleeping):
		velocity = Vector3.ZERO
	if(!sleeping):
		check_player_movement(delta)

func check_player_movement(delta):
	velocity += acceleration * delta
	var drag_factor
	if is_on_floor():
		drag_factor = ground_drag * delta
	else:
		drag_factor = air_drag * delta
	drag_factor = clampf(1.0 - drag_factor, 0.0, 1.0)
	velocity *= drag_factor
	move_and_slide()

func on_end_game():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_go_to_sleep(energy):
	sleeping = true
	
func _on_wake_up():
	sleeping = false
	
func _on_failed_event():
	playerController.exitPuzzle();
	pass # Replace with function body.

func _on_succesful_event():
	playerController.exitPuzzle();
	pass # Replace with function body.
