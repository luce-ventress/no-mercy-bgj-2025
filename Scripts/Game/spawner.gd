extends Node

@export var meleeEnemyScene: PackedScene
@export var rangedEnemyScene: PackedScene

@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance") as Node3D
var spawnDistance: float = 10

func getSpawnLocation() -> Vector3:
	var spawnDistanceRand: float = randf_range(-2, 5)
	var playerPos = PlayerPawn.position.normalized()
	var spawnLocation: Vector3 = Vector3(spawnDistance + spawnDistanceRand, spawnDistance + spawnDistanceRand, 0) + playerPos
	
	return spawnLocation

func _on_timer_timeout() -> void:
	if PlayerStats.isDead:
		return
		
	var MeleeEnemy = meleeEnemyScene.instantiate()
	var RangedEnemy = rangedEnemyScene.instantiate()
	
	var enemyTypeChoice = randi_range(0, 1)
	if enemyTypeChoice == 0:
		owner.add_child(MeleeEnemy)
		MeleeEnemy.set_position(getSpawnLocation())
	elif enemyTypeChoice == 1:
		owner.add_child(RangedEnemy)
		RangedEnemy.set_position(getSpawnLocation())
