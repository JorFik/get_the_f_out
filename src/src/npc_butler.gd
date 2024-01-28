extends CharacterBody2D

signal blue

const FIRST_DIAL = 1
const SOLVING_FIRST_RIDDLE = 2
const AFTER_SOLVED_FIRST_RIDDLE = 3
const AFTER_SOLVED_FIRST_RIDDLE_AND_TALKED = 4

var cur_dial
var riddle1_scene = preload("res://Scenes/Riddles/Number Riddle/number_riddle.tscn")
var riddle1
var slot = "save1"
var riddle_solved = false
var first_time = true
var dial_stage = 1

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "riddle1":
		print("dialogic signal riddle1 recieved by butler")
		riddle1 = riddle1_scene.instantiate()
		$"../Marker2D".add_child(riddle1)
		riddle1.connect("riddle_correct", _on_riddle_correct)
		#riddle1.position = Vector2(-500, -500)
		get_node("/root/Start/DialogueSceneButler").visible = false
	if argument == "orange":
		blue.emit()

func _on_riddle_correct():
	print ("abyrwalg wtf_ON_RIDDLE_CORRECT_IN_ANOTHER_NODE_AA")
	print("Trying to change dialogue stage!!")
	Dialogic.VAR.dial_stage = AFTER_SOLVED_FIRST_RIDDLE
	Dialogic.VAR.set('dial_stage', AFTER_SOLVED_FIRST_RIDDLE)
	print("THE DIAL VAR WAS SET TO....")
	print(Dialogic.VAR.dial_stage)
	riddle1.visible = false
	riddle1.queue_free()
	riddle_solved = true


func init_dial():
	print(Dialogic.VAR.dial_stage)
	if (Dialogic.VAR.dial_stage == FIRST_DIAL):
		print("DIAL")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		get_node("/root/Start/DialogueSceneButler").visible = true
		cur_dial = Dialogic.start("res://Resources/dialogues/buttler_dialogue.dtl")
		cur_dial.show()
		return
	elif (Dialogic.VAR.dial_stage == SOLVING_FIRST_RIDDLE):
		print("DIAL")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		get_node("/root/Start/DialogueSceneButler").visible = true
		cur_dial = Dialogic.start("res://Resources/dialogues/buttler_dialogue.dtl")
		cur_dial.show()
		return
	elif (Dialogic.VAR.dial_stage == AFTER_SOLVED_FIRST_RIDDLE):
		get_node("/root/Start/DialogueSceneGeezer").visible = true
		cur_dial = Dialogic.start("res://Resources/dialogues/oldman_after_riddle.dtl")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		cur_dial.show()
	elif (Dialogic.VAR.dial_stage == AFTER_SOLVED_FIRST_RIDDLE_AND_TALKED):
		get_node("/root/Start/DialogueSceneGeezer").visible = true
		cur_dial = Dialogic.start("res://Resources/dialogues/oldman_after_riddle.dtl")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		cur_dial.show()

func _on_timeline_ended():
	print("Timeline ended!")
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneButler").visible = false
	get_node("/root/Start/DialogueSceneGeezer").visible = false
