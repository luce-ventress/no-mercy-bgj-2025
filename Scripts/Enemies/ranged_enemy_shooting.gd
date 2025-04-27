extends Node

@export var ProjectileScene: PackedScene
@export var spawn_height: float = 0.5
@export var spawn_dist: float = 1.5

@onready var root = owner.get_parent()
@onready var characterBody = owner as CharacterBody3D
@onready var ProjectileSpawn = owner.get_node("ProjectileSpawnPos") as Node3D

var time_since_last_shot = 0
var shot_cooldown = 0.1

var current_spawn_pos: Vector3
var current_spawn_dir: Vector3

func _physics_process(delta: float) -> void:
	
	var myForward: Vector3 = (-characterBody.get_global_transform().basis.x).normalized()
	
	current_spawn_pos = ProjectileSpawn.global_position
	current_spawn_dir = myForward
	
	#current_spawn_pos = owner.position + current_spawn_dir * spawn_dist + Vector3(0, spawn_height, 0)

func _process(delta: float) -> void:
	var current_time: float = (Time.get_ticks_msec() as float) / 1000.0
	if current_time > (time_since_last_shot + shot_cooldown):
		spawn_projectile(current_spawn_pos, current_spawn_dir)
		time_since_last_shot = current_time
			
func spawn_projectile(position: Vector3, dir: Vector3):
	if $Ranged_enemy_attack.is_playing() == false:
		$Ranged_enemy_attack.play()
	var projectile = ProjectileScene.instantiate()
	root.add_child(projectile)
	projectile.set_position(position)
	projectile.set_projectile_direction(dir)
	
#func get_mouse_direction() -> Vector3:
	#var mouse_position = get_window().get_mouse_position()
	#var pick_normal = camera.project_ray_normal(mouse_position)
	#var pick_origin = camera.project_ray_origin(mouse_position)
	#
	#var params = PhysicsRayQueryParameters3D.create(pick_origin, pick_origin + pick_normal * 1000)
	#params.set_collision_mask(8388608)
	#var state = owner.get_world_3d().direct_space_state
	#var result = state.intersect_ray(params)
	#
	#if	not result:
		#return Vector3(1, 0, 1)
	#
	#var dir = (result.position - owner.position).normalized()
	#
	#return dir
