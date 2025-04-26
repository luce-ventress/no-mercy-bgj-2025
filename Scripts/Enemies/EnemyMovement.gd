extends Node

@export var speed = 50
@export var rotationSpeed = 3
@export var fall_acceleration = 96

@onready var characterBody = owner as CharacterBody3D
@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance") as Node3D

func _physics_process(delta: float) -> void:
	
	var toPlayerDir = characterBody.position.direction_to(PlayerPawn.position).normalized()
	toPlayerDir.y = 0
	
	var desiredVelocity: Vector3 = toPlayerDir * speed * delta
	var myForward: Vector3 = (-characterBody.get_global_transform().basis.x).normalized()
	myForward.y = 0
	var toPlayerAngle: float = myForward.angle_to(toPlayerDir)
	
	var myLeft: Vector3 = (characterBody.get_global_transform().basis.z).normalized()
	var toPlayerDot: float = sign(myLeft.dot(toPlayerDir))
	
	var currentRotationStep: float = rotationSpeed * delta
	var trueAngle: float = minf(currentRotationStep, toPlayerAngle)
	#print(rad_to_deg(toPlayerAngle * (toPlayerDot))) 
	
	print(rad_to_deg(currentRotationStep), " ", rad_to_deg(toPlayerAngle))
	
	if not characterBody.is_on_floor():
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta)
		
	#characterBody.set_velocity(desiredVelocity)
	#characterBody.rotate_y(toPlayerDir.angle_to(characterBody.transform.basis) * delta * 10)
	characterBody.rotate_y(trueAngle * toPlayerDot)
	characterBody.move_and_slide()
