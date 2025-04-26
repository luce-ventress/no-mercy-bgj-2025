extends Area3D

@export var pushBack: float
@export var pushUp: float

@onready var PlayerPawn = owner.get_node("%PlayerPawnInstance")
@onready var MeleeEnemy = owner as CharacterBody3D

func _ready() -> void:
	pass
	set_monitoring(true)
	#set_contact_monitor(true)
	#set_max_contacts_reported(1)


func _on_body_entered(body: Node) -> void:
	if body == PlayerPawn:
		on_hit()

func on_hit():
	var backwards = MeleeEnemy.transform.basis.x.normalized()
	var pushbackImpulse = (backwards * pushBack) + Vector3(0, pushUp, 0);
	MeleeEnemy.set_velocity(pushbackImpulse)
	MeleeEnemy.move_and_slide()
