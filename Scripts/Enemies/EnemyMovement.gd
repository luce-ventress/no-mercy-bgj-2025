extends Node

@export var speed = 5
@export var rotationSpeed = 1.5
@export var fall_acceleration = 600

@onready var characterBody = owner as CharacterBody3D
@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance") as Node3D

var externalImpulse: Vector3

func _physics_process(delta: float) -> void:
	var toPlayerDir = characterBody.position.direction_to(PlayerPawn.position).normalized()
	toPlayerDir.y = 0
	
	rotate_towards_player(toPlayerDir, delta)
	
	var desiredVelocity: Vector3 = toPlayerDir * speed
	
	if not characterBody.is_on_floor():
		desiredVelocity.x = 0
		desiredVelocity.z = 0
		desiredVelocity.y = desiredVelocity.y - (fall_acceleration * delta)

	var current_velocity = characterBody.velocity
	var final_velocity = current_velocity.lerp(desiredVelocity, 0.05)
		
	characterBody.set_velocity(final_velocity + externalImpulse)
	characterBody.move_and_slide()
	externalImpulse = Vector3(0, 0, 0)

func report_got_hit(pushBack: float):
	var backwards = characterBody.transform.basis.x.normalized()
	var pushbackImpulse = (backwards * pushBack)
	externalImpulse = pushbackImpulse
	
func report_hit_other(pushBack: float, pushUp: float):
	var backwards = characterBody.transform.basis.x.normalized()
	var pushbackImpulse = (backwards * pushBack) + Vector3(0, pushUp, 0);
	externalImpulse = pushbackImpulse

func rotate_towards_player(toPlayerDir: Vector3, delta: float):
	var myForward: Vector3 = (-characterBody.get_global_transform().basis.x).normalized()
	myForward.y = 0
	var toPlayerAngle: float = myForward.angle_to(toPlayerDir)
	
	var myLeft: Vector3 = (characterBody.get_global_transform().basis.z).normalized()
	var toPlayerDot: float = sign(myLeft.dot(toPlayerDir))
	
	var currentRotationStep: float = rotationSpeed * delta
	var trueAngle: float = minf(currentRotationStep, toPlayerAngle)

	characterBody.rotate_y(trueAngle * toPlayerDot)
