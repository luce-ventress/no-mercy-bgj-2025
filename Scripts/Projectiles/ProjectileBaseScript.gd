extends Node

@onready var pMovement = get_node("ProjectileMovement") as Node

func set_projectile_direction(dir: Vector3):
	pMovement.set_projectile_direction(dir)

func set_projectile_speed(speed: float):
	pMovement.set_projectile_speed(speed)


func _on_area_3d_body_entered(body: Node3D) -> void:
	var parent = get_parent()
	if parent:
		parent.remove_child.call_deferred(self)
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	var parent = get_parent()
	if parent:
		parent.remove_child.call_deferred(self)
		queue_free()
