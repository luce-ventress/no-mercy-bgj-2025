extends Node

@onready var root = owner.get_parent().get_node(".")
@onready var player_hat = owner.get_node("PlayerMesh/%NoMercy_Player_Hat")
@onready var health_points = player_hat.hat_sizes.size()
@onready var mesh = owner.get_node("PlayerMesh")

var playerHitSound1 = preload("res://Assets/Sound/Player/Player_hit_1.wav")
var playerHitSound2 = preload("res://Assets/Sound/Player/Player_hit_2.wav")
var playerHitSound3 = preload ("res://Assets/Sound/Player/Player_hit_3.wav")

var tween

func _on_hit_area_area_entered(_area: Area3D) -> void:
	if	(health_points <= 0):
		return
	$PlayerHit.play()
	player_hat.shrink_hat()
	health_points -= 1
	if	(health_points <= 0):
		PlayerStats.isDead = true
		print("player die")
		death_anim()

	
func death_anim():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = get_tree().create_tween()
	tween.tween_property(mesh, "rotation", Vector3(-PI/2, 0, -PI/2), 0.3)
	tween.tween_property(mesh, "scale", Vector3(0.0, 0.0, 0.0), 1).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(print.bind("player death finish"))
