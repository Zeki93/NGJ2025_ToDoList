extends RayCast3D

const RAY_LENGTH = 1000.0

func _ready():
	#self.set_collision_mask_value(1, false)
	#self.set_collision_mask_value(2, true)
	self.collision_mask = 1 | 2
	print(self.get_collision_mask_value(1))
	print(self.get_collision_mask_value(2))
	pass
	
func _physics_process(delta: float):
	var space_state = get_world_3d().direct_space_state
	var camera3d = $".."
	var mousepos = get_viewport().get_mouse_position()
	var from = camera3d.project_ray_origin(mousepos)
	var to = from + camera3d.project_ray_normal(mousepos) * RAY_LENGTH
	
	self.target_position = to
	
	print(self.is_colliding())
	if(self.is_colliding()):
		print(self.get_collider().collision_mask)
		if(self.get_collider().collision_mask == 2 or self.get_collider().collision_mask == 3):
			print("hit")
	pass


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $".."
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		print(to)
