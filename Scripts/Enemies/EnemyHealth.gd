extends Node

@export var HealthPoints: float = 100
@export var mesh_name: String = "NoMercy_Enemy_Melee"

@onready var root = owner.get_parent().get_node(".")
@onready var movement = owner.get_node("EnemyMovement")
@onready var mesh = owner.get_node(mesh_name)

var tween

func _on_hit_area_area_entered(area: Area3D) -> void:
	if HealthPoints <= 0:
		return
	if $GotHit.is_playing() == false:
		$GotHit.play()
			
	movement.report_got_hit(2)
	var damaged_amount = get_damage()
	reduce_health(damaged_amount)

func get_damage() -> float:
	return PlayerStats.PlayerDamage

func reduce_health(amount: float):
	HealthPoints -= amount;
	hit_anim()
	if HealthPoints <= 0:
		die()
	
func die():
	print("monster die")
	movement.IsDead = true
	death_anim()

func hit_anim():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = get_tree().create_tween()
	tween.tween_property(mesh, "scale", Vector3(1.33, 1.33, 1.33), 0.05)
	tween.tween_property(mesh, "scale", Vector3(1, 1, 1), 0.05)
	
func death_anim():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = get_tree().create_tween()
	tween.tween_property(mesh, "rotation", Vector3(-PI/2, 0, -PI/2), 0.3)
	tween.tween_property(mesh, "scale", Vector3(0.1, 0.1, 0.1), 1).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(owner.queue_free)
