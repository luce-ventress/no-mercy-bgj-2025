extends Node

@export var meleeEnemyScene: PackedScene
@export var rangedEnemyScene: PackedScene

@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance") as Node3D

@onready var rng = RandomNumberGenerator.new()

func getSpawnLocation() -> Vector3:
	var new_dir = Vector2()
	new_dir.x = rng.randf_range(-1, 1)
	new_dir.y = rng.randf_range(-1, 1)
	new_dir.normalized()
	
	var spawnDistanceRand: float = randf_range(0, 80)
	var spawnLocation: Vector3 = Vector3(new_dir.x * spawnDistanceRand, 10, new_dir.y * spawnDistanceRand)
	
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
