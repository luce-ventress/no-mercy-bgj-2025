extends Node

@onready var root = owner.get_parent().get_node(".")
@onready var player_hat = owner.get_node("PlayerMesh/%NoMercy_Player_Hat")
@onready var health_points = player_hat.hat_sizes.size()

var playerHitSound1 = preload("res://Assets/Sound/Player/Player_hit_1.wav")
var playerHitSound2 = preload("res://Assets/Sound/Player/Player_hit_2.wav")
var playerHitSound3 = preload ("res://Assets/Sound/Player/Player_hit_3.wav")

func _on_hit_area_area_entered(area: Area3D) -> void:
	$PlayerHit.play()
	player_hat.shrink_hat()
	health_points -= 1
	if	(health_points <= 0):
		print("die")
		root.remove_child(owner)
		queue_free()
