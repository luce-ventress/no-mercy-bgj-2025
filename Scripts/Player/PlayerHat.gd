extends Node3D
@onready var time: float = 0
func _process(delta: float) -> void:
	
	time += delta
	var move = sin((2 * PI * time))
	
	var deltaPos = Vector3(0, move/200, 0)
	var meshPos  = get_position()
	set_position(meshPos + deltaPos)
	
