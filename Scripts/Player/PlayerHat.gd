extends Node3D

@export var hat_speed: float = 1
@export var hat_magnitude: float = 0.5

@export var hat_sizes: Array[float]
@export var hat_anim_up_scale: float = 1

var magnitude_scale: float = 100

@onready var current_hat_size = hat_sizes.size() - 1
@onready var originalScale = get_scale()
@onready var time: float = 0

var hat_size_anim_sine_value: float = 1
var hat_size_anim_sine_speed: float = 2
var target_hat_size: float = 1

func _process(delta: float) -> void:
	
	time += delta
	var sinValue = sin((2 * PI * time * hat_speed))
	var deltaPos = transform.basis.y * sinValue * (hat_magnitude / magnitude_scale)
	var meshPos  = get_position()
	set_position(meshPos + deltaPos)
	
	if hat_size_anim_sine_value < 1:
		hat_size_anim_sine_value += hat_size_anim_sine_speed * delta
		set_hat_size(target_hat_size * (1 + (hat_anim_up_scale * sin(PI * hat_size_anim_sine_value))))
	
func shrink_hat():
	current_hat_size -= 1
	if current_hat_size >= 0:
		target_hat_size = hat_sizes[current_hat_size]
		hat_size_anim_sine_value = 0
		
	
func grow_hat():
	current_hat_size += 1
	if current_hat_size < hat_sizes.size():
		target_hat_size = hat_sizes[current_hat_size]
		hat_size_anim_sine_value = 0
	
func set_hat_size(size: float):
	set_scale(originalScale * size)
