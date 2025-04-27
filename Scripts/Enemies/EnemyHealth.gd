extends Node

@export var HealthPoints: float = 100

@onready var movement = owner.get_node("EnemyMovement")

func _on_hit_area_area_entered(area: Area3D) -> void:
	if $MeleeEnemyHit.is_playing() == false:
		$MeleeEnemyHit.play()
			
	movement.report_got_hit(2)
	var damaged_amount = get_damage()
	reduce_health(damaged_amount)

func get_damage() -> float:
	
	return 10.0

func reduce_health(amount: float):
	pass
	
func die():
	pass
