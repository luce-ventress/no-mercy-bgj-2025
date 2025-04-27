extends Node

@export var speed: float = 10
@export var fall_acceleration = 600

@onready var characterBody = owner as CharacterBody3D
@onready var playerMesh = owner.get_node("PlayerMesh")

func _physics_process(delta: float) -> void:
	var desiredVelocity: Vector3 = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("player_forward"):
		desiredVelocity.x += 1
	if Input.is_action_pressed("player_backward"):
		desiredVelocity.x -= 1
	if Input.is_action_pressed("player_right"):
		desiredVelocity.z += 1
	if Input.is_action_pressed("player_left"):
		desiredVelocity.z -= 1
																											  
	if not characterBody.is_on_floor():
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta * PlayerStats.PlayerGravityScale)
		
	desiredVelocity = desiredVelocity.normalized() * speed * PlayerStats.PlayerSpeed;
	characterBody.set_velocity(desiredVelocity)
	
	var oldPos = characterBody.get_position()
	characterBody.move_and_slide()
	var newPos = characterBody.get_position()
	var deltaPos = newPos - oldPos
	
	if not deltaPos.is_zero_approx():
		playerMesh.on_movement_occured(deltaPos)
