extends Node

@onready var root = owner.get_parent().get_node(".")
@onready var player_hat = owner.get_node("PlayerMesh/%NoMercy_Player_Hat")
@onready var health_points = player_hat.hat_sizes.size()

func _on_hit_area_area_entered(area: Area3D) -> void:
	player_hat.shrink_hat()
	health_points -= 1
	if	(health_points <= 0):
		print("die")
		root.remove_child(owner)
		queue_free()
