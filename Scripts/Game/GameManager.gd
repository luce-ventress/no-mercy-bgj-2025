extends Node

@onready var game_start_time: float = Time.get_unix_time_from_system()
@onready var game_time_label: Label = get_parent().find_child("GameTime", true, false)

var time: float


func _process(_delta: float) -> void:
	if game_time_label:
		time = Time.get_unix_time_from_system() - game_start_time
		var time_string = Time.get_time_string_from_unix_time(time as int)
		game_time_label.text = time_string
		if PlayerStats.isDead:
			showEndTime()
	else:
		game_time_label = get_parent().find_child("GameTime", true, false)
		return
	
func showEndTime() ->void:
	time = Time.get_unix_time_from_system() - game_start_time
	var endTime = Time.get_time_string_from_unix_time(time as int)
	game_time_label.text = "End time: " + endTime
	set_process(!is_processing())

func reset():
	time = 0
	game_start_time = Time.get_unix_time_from_system()
