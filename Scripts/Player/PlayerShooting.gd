extends Node

@export var ProjectileScene: PackedScene
@export var spawn_height: float = 0.5

@onready var root = owner.get_parent()
@onready var camera = owner.get_node("CameraRoot/Camera3D") as Camera3D
@onready var projectile_spawn_pos = owner.get_node("ProjectileSpawnPos")

var time_since_last_shot = 0
var shot_cooldown = 0.01

var current_spawn_pos: Vector3

func _physics_process(delta: float) -> void:
	var mouse_position = get_window().get_mouse_position()
	var pick_normal = camera.project_ray_normal(mouse_position)
	var pick_origin = camera.project_ray_origin(mouse_position)
	
	var params = PhysicsRayQueryParameters3D.create(pick_origin, pick_origin + pick_normal * 1000)
	params.set_collision_mask(8388608)
	var state = owner.get_world_3d().direct_space_state
	var result = state.intersect_ray(params)
	current_spawn_pos = result.position + Vector3(0, spawn_height, 0)

func _process(delta: float) -> void:
	
	
	
	
	if Input.is_action_pressed("shoot"):
		var current_time: float = (Time.get_ticks_msec() as float) / 1000.0
		if current_time > (time_since_last_shot + shot_cooldown):
			spawn_projectile(current_spawn_pos)
			#projectile_spawn_pos.get_global_position()
			time_since_last_shot = current_time
			
func spawn_projectile(position: Vector3):
	var projectile = ProjectileScene.instantiate()
	root.add_child(projectile)
	projectile.set_position(position)
