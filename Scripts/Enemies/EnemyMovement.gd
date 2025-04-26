extends Node

@export var fall_acceleration = 96

@onready var characterBody = owner as CharacterBody3D
@onready var PlayerPawn = %PlayerPawnInstance

func _physics_process(delta: float) -> void:
	var desiredVelocity: Vector3 = Vector3(delta, 0, delta)*100
	if not characterBody.is_on_floor():
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta)
		
	characterBody.set_velocity(desiredVelocity)
	characterBody.move_and_slide()
