extends CharacterBody2D

var riddle1_scene = preload("res://Scenes/Riddles/Number Riddle/number_riddle.tscn")
var slot = "save1"
var riddle_solved = false

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "riddle1":
		#slot = Dialogic.Save.save(slot, true, false)
		get_node("/root/Start/DialogueSceneGeezer").visible = false
		var riddle = riddle1_scene.instantiate()
		$"../Riddles".add_child(riddle)
		#riddle.connect("riddle_correct", _on_riddle_correct, 1)
		
		#Dialogic.paused = true

func _on_riddle_correct():
	print ("_ON_RIDDLE_CORRECT_IN_ANOTHER_NODE_AA")
	get_node("/root/Start/DialogueSceneGeezer").visible = true
	Dialogic.paused = false
	#Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	#Dialogic.Save.load(slot)
	riddle_solved = true

func init_dial():
	print("DIAL")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneGeezer").visible = true
	Dialogic.start("res://Resources/dialogues/timeline1.dtl")

func _on_timeline_ended():
	if (riddle_solved):
		Dialogic.timeline_ended.disconnect(_on_timeline_ended)
		get_node("/root/Start/DialogueSceneGeezer").visible = false

