extends Node

#@export var speed: float = 10

@onready var characterBody = owner as CharacterBody3D
@onready var projectileRoot = owner as Node3D

var projectileDirection: Vector3 = Vector3(1, 0, 0)
var projectileSpeed: float = 10

func _physics_process(delta: float) -> void:
	var desiredVelocity: Vector3 = projectileDirection * projectileSpeed
	projectileRoot.position += desiredVelocity * delta
	
func set_projectile_direction(dir: Vector3):
	projectileDirection = dir

func set_projectile_speed(speed: float):
	projectileSpeed = speed
	
