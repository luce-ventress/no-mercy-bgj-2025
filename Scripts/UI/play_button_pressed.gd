extends Button

#var level_scene = preload("res://Maps/Level1.tscn").instantiate()
@export var levelScene: PackedScene

func _on_pressed() -> void:
	print("play pressed")
	get_tree().change_scene_to_packed(levelScene)
	GameManager.reset()
	PowerupManager.reset()
