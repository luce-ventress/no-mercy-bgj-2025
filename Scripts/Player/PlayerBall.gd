extends Node3D

@onready var playerBallMesh = get_node("CSGSphere3D") as Node3D

func on_movement_occured(movement: Vector3):

	var dir = Vector3(movement.z, movement.y, -movement.x)
	playerBallMesh.rotate(dir.normalized(), movement.length())
