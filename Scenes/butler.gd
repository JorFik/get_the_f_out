extends CharacterBody2D

var cur_dial
var riddle2_scene: PackedScene = preload("res://riddle_2.tscn")
var riddle2
var riddle_solved: bool = false


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_dialogic_signal(argument:String):
	print("dial")
	if argument == "klara":
		get_node("/root/Scene2/CorpseScene/Klara").visible = false
	if argument == "briefcase":
		riddle2 = riddle2_scene.instantiate()
		$"../Marker2D".add_child(riddle2)
		riddle2.connect("correct", _on_riddle2_correct)
		get_node("/root/Scene2/CorpseScene").visible = false
		
func _on_riddle2_correct():
	print ("_ON_SIGN_CORRECT_IN_ANOTHER_NODE_AA")
	riddle2.visible = false
	riddle2.queue_free()
	# get_node("/root/Start/DialogueSceneGeezer").visible = true
	#$"../Riddles/Number RIddle".visible = false
	#Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	#Dialogic.Save.load(slot)
	riddle_solved = true
	
func init_dial():
	if (riddle_solved):
		get_node("/root/Scene2/CorpseScene").visible = true
		cur_dial = Dialogic.start("res://corpse_after.dtl")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		cur_dial.show()
		return
	print("DIAL")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	get_node("/root/Scene2/CorpseScene").visible = true
	cur_dial = Dialogic.start("res://corpse.dtl")
	cur_dial.show()

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/Scene2/CorpseScene").visible = false
