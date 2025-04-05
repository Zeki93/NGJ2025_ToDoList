extends RayCast3D

const RAY_LENGTH = 1.0

func _ready():
	#self.set_collision_mask_value(1, false)
	#self.set_collision_mask_value(2, true)
	self.collision_mask = 1 | 2
	pass
	
func _physics_process(_delta: float):
	var space_state = get_world_3d().direct_space_state
	var camera3d = $".."
	var mousepos = get_viewport().get_mouse_position()
	var from = camera3d.project_ray_origin(mousepos)
	var to = from + camera3d.project_ray_normal(mousepos) * RAY_LENGTH
	
	self.target_position = Vector3(0,0,-100)
	
	pass


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $".."
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
