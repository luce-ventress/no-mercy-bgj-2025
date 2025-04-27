extends Node

@onready var movement = owner.get_node("EnemyMovement")

func _on_hit_area_area_entered(area: Area3D) -> void:
	if $MeleeEnemyHit.is_playing() == false:
			$MeleeEnemyHit.play()
	movement.report_got_hit(2)	
