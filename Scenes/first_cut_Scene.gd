extends TileMap

func _ready():
	var dialog = Dialogic.start("start_convo")
	add_child(dialog)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _on_dialogic_signal(argument: String):
	if argument == "start_scene":
		get_tree().change_scene_to_file("res://Scenes/start.tscn")
