extends Node

@export var ProjectileScene: PackedScene

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			spawn_projectile()
			
func spawn_projectile():
	var projectile = ProjectileScene.instantiate()
	add_child(projectile)
