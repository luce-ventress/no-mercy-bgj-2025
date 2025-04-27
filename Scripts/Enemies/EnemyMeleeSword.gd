extends Area3D

@export var pushBack: float
@export var pushUp: float

@onready var movement = owner.get_node("EnemyMovement")
@onready var PlayerPawn = owner.get_parent().get_node("%PlayerPawnInstance")
@onready var MeleeEnemy = owner as CharacterBody3D

var hitSound = preload("res://Assets/Sound/Enemy/Melee_enemy_attack.wav")
var playerDamageSound1 = preload("res://Assets/Sound/Enemy/Enemy_hit_1.wav")
var playerDamageSound2 = preload("res://Assets/Sound/Enemy/Enemy_hit_2.wav")
#var audio_node = null

func _ready() -> void:
	pass
	set_monitoring(true)

	#$MeleeEnemyPlayerDamage.add_stream(0, playerDamageSound1, 1.0)
	#$MeleeEnemyPlayerDamage.add_stream(1, playerDamageSound2, 1.0)
	#audio_node = $MeleeEnemySoundNode
	#audio_node.connect("finished", self, "destroy_self")
	#audio_node.stop()
	#set_contact_monitor(true)
	#set_max_contacts_reported(1)

func _on_area_entered(area: Area3D) -> void:
	if area.owner == PlayerPawn:
		on_hit()

func on_hit():
	movement.report_hit_other(pushBack, pushUp)
	#audio_node.stream = hitSound
	#audio_node.play()
	$MeleeEnemyPlayerDamage.play()
	$MeleeEnemySoundNode.play()
	var backwards = MeleeEnemy.transform.basis.x.normalized()
	var pushbackImpulse = (backwards * pushBack) + Vector3(0, pushUp, 0);
	MeleeEnemy.set_velocity(pushbackImpulse)
	MeleeEnemy.move_and_slide()

func destroy_self():
	#audio_node.stop()
	queue_free()
