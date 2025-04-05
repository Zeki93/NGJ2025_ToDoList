class_name PlayerController
extends Node

@onready var player: CharacterBody3D = $".."
@onready var head: Node3D = $"../Head"
@onready var eyes: Node3D = $"../Head/Eyes"
#@onready var hand_target: Node3D = $"../Head/Eyes/HandTarget"
#@onready var collision_shape_3d: CollisionShape3D = $"../CollisionShape3D"
#@onready var collider: Shape3D = collision_shape_3d.shape
#@onready var interactor_cast: RayCast3D = $"../Head/Eyes/InteractorCast"
#@onready var crosshair: TextureRect = $"../CanvasLayer/CenterContainer/Crosshair"

@export var wobble_amount_scale = 0.01
@export var wobble_time_scale = 0.15
@export var camera_height_standing = 1.75
@export var camera_height_crouched = 1.50
@export var ground_acceleration = 80
@export var air_acceleration = 10
@export var mouse_sensitivity = 0.002
@export var jump_speed = 4.5
@export var max_interact_distance = 2

var wobble_time = 0.0
var viewed_object = null
var active_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = player.transform.basis * Vector3(input.x, 0, input.y)

	var acceleration
	if player.is_on_floor():
		acceleration = movement_dir *ground_acceleration
	else:
		acceleration = movement_dir * air_acceleration
	player.acceleration.x = acceleration.x
	player.acceleration.z = acceleration.z

	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_speed

	wobble_time += movement_dir.length() * delta * wobble_time_scale
	
	if Input.is_action_pressed("crouch"):
		head.transform.origin.y -= delta * 6 * (0.1 + (head.transform.origin.y - camera_height_crouched))
	else:
		head.transform.origin.y += delta * 6 * (0.1 + (camera_height_standing - head.transform.origin.y))
	head.transform.origin.y = clampf(head.transform.origin.y, camera_height_crouched, camera_height_standing)
	
	eyes.basis = Basis.looking_at(Vector3.FORWARD, Vector3.UP).rotated(Vector3.FORWARD, sin(wobble_time) * wobble_amount_scale)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		player.rotate_y( - event.relative.x * mouse_sensitivity)
		head.rotate_x( - event.relative.y * mouse_sensitivity)
		head.rotation.x = clampf(head.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
	#if event is InputEventMouseButton and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and Input.get_mouse_button_mask() & MOUSE_BUTTON_MASK_LEFT != 0:
		#var viewed_object_p = null
		#
		#if viewed_object and viewed_object.global_position.distance_to(player.global_position) <= max_interact_distance:
			#viewed_object_p = viewed_object.get_node("..")
		#
		#if viewed_object_p and viewed_object_p.has_method("activate_scene"):
			#active_scene = viewed_object_p
		#elif viewed_object_p and viewed_object_p.has_method("interact"):
			#viewed_object_p.interact(self)
