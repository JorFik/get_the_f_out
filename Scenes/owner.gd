extends CharacterBody2D

@onready var tax_collector_sprite = %"Tax collector sprite"
var cur_dial 


func _physics_process(_delta):
	tax_collector_sprite.flip_h = 1

func init_dial():
	print("DIAL INIT")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	get_node("/root/EndScene/DialogueSceneFinal").visible = true
	cur_dial = Dialogic.start("res://Resources/dialogues/end_dialogue.dtl")
	cur_dial.show()

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "geezer_died":
		get_node("/root/EndScene/DialogueSceneFinal").visible = false
		get_node("/root/EndScene/DialogueSceneFinalButOnly").visible = true

func _on_timeline_ended():
	print("Timeline ended!")
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/EndScene/DialogueSceneFinal").visible = false
	get_node("/root/EndScene/DialogueSceneFinalButOnly").visible = false
	get_tree().change_scene_to_file("res://Scenes/outro_cut_scene.tscn")
	
	#Dialogue ends, insert change of scene or something here
