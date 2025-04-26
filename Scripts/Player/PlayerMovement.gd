extends Node

@export var speed: float = 1
@export var fall_acceleration = 96

@onready var characterBody = owner as CharacterBody3D
@onready var playerMesh = owner.get_node("PlayerMesh")

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
																											  
	if not characterBody.is_on_floor():
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta)
		
	desiredVelocity = desiredVelocity.normalized() * speed;
	characterBody.set_velocity(desiredVelocity)
	
	var oldPos = characterBody.get_position()
	characterBody.move_and_slide()
	var newPos = characterBody.get_position()
	var deltaPos = newPos - oldPos
	
	if not deltaPos.is_zero_approx():
		playerMesh.on_movement_occured(deltaPos)
