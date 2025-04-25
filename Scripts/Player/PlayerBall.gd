extends Node

@onready var playerBallMesh = get_node("CSGSphere3D") as Node3D

func on_movement_occured(movement: Vector3):
	print(movement)
	playerBallMesh.rotate(movement.normalized(), 0.1)
