extends Node

@export var meleeEnemyScene: PackedScene
@export var rangedEnemyScene: PackedScene

@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance") as Node3D



func getSpawnLocation() -> Vector3:
	var spawnLocation: Vector3 = Vector3(0,0,0)
	return spawnLocation

func _on_wave_timer_timeout() -> void:
	if $PlayerPawn.isDead:
		return
		
	var MeleeEnemy = meleeEnemyScene.instantiate()
	owner.add_child(MeleeEnemy)
	MeleeEnemy.set_position(getSpawnLocation())
	print("spawn")
