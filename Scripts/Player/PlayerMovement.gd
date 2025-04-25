extends Node

@export var speed: float = 1
@export var fall_acceleration = 96

@onready var characterBody = owner as CharacterBody3D



func _physics_process(delta: float) -> void:
	var desiredVelocity: Vector3 = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("player_forward"):
		desiredVelocity.x += speed
	if Input.is_action_pressed("player_backward"):
		desiredVelocity.x -= speed	
	if Input.is_action_pressed("player_right"):
		desiredVelocity.z += speed
	if Input.is_action_pressed("player_left"):
		desiredVelocity.z -= speed
		
	print(desiredVelocity)
		
	if not characterBody.is_on_floor():
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta)
		
	characterBody.set_velocity(desiredVelocity)
		
	characterBody.move_and_slide()
