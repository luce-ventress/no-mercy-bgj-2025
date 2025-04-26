extends Node

@export var speed: float = 1

@onready var characterBody = owner as CharacterBody3D
@onready var projectileRoot = owner as Node3D

func _physics_process(delta: float) -> void:
	var desiredVelocity: Vector3 = Vector3(1, 0, 1)

	projectileRoot.position += desiredVelocity * delta
