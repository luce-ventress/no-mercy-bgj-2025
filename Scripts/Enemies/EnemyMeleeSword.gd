extends Area3D

@export var pushBack: float
@export var pushUp: float

@onready var movement = owner.get_node("EnemyMovement")
@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance")
@onready var MeleeEnemy = owner as CharacterBody3D

func _ready() -> void:
	pass
	set_monitoring(true)

func on_hit():
	movement.report_hit_other(pushBack, pushUp)


func _on_area_entered(area: Area3D) -> void:
	if area.owner == PlayerPawn:
		on_hit()
