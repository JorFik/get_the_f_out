extends CharacterBody2D

var cur_dial
var riddle1_scene = preload("res://Scenes/Riddles/Number Riddle/number_riddle.tscn")
var riddle1
var slot = "save1"
var riddle_solved = false
var first_time = true

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "oldman_happy":
		get_node("/root/Start/DialogueSceneGeezer").visible = false
		self.queue_free()
	elif argument == "entered_addit_talk":
		print("Entered second branch of dialogic timeline")
	elif argument == "riddle1":
		riddle1 = riddle1_scene.instantiate()
		add_child(riddle1)
		riddle1.connect("riddle_correct", _on_riddle_correct)
		#slot = Dialogic.Save.save(slot, true, false)
		get_node("/root/Start/DialogueSceneGeezer").visible = false
		#$"../Riddles/Number RIddle".visible = true
		#$"../Riddles/Number RIddle".connect("riddle_correct", _on_riddle_correct, 1)


func _on_riddle_correct():
	#print ("_ON_RIDDLE_CORRECT_IN_ANOTHER_NODE_AA")
	riddle1.visible = false
	riddle1.queue_free()
	# get_node("/root/Start/DialogueSceneGeezer").visible = true
	#$"../Riddles/Number RIddle".visible = false
	#Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	#Dialogic.Save.load(slot)
	riddle_solved = true

func init_dial():
	if (riddle_solved):
		get_node("/root/Start/DialogueSceneGeezer").visible = true
		cur_dial = Dialogic.start("res://Resources/dialogues/oldman_after_riddle.dtl")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		cur_dial.show()
		return
	print("DIAL")
	cur_dial = Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	cur_dial.show()
	first_time = false
	print("dial end")
	get_node("/root/Start/DialogueSceneGeezer").visible = true

func _on_timeline_ended():
	print("Timeline ended!")
	#if (riddle_solved):
	#	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	#Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneGeezer").visible = false
	#$"../Riddles/Number RIddle".visible = true

