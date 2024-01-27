extends CharacterBody2D

func init_dial():
	print("DIAL")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneButler").visible = true
	Dialogic.start("res://Resources/dialogues/buttler_dialogue.dtl")

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneButler").visible = false
