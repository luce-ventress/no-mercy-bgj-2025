extends Node3D

@export var hat_speed: float = 1
@export var hat_magnitude: float = 0.5

var magnitude_scale: float = 100

@onready var time: float = 0

func _process(delta: float) -> void:
	
	time += delta
	var sinValue = sin((2 * PI * time * hat_speed))
	print()
	var deltaPos = transform.basis.y * sinValue * (hat_magnitude / magnitude_scale)
	var meshPos  = get_position()
	set_position(meshPos + deltaPos)
	
