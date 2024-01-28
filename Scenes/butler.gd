extends CharacterBody2D

var cur_dial

func init_dial():
	print("DIAL")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	.visible = true
	cur_dial = Dialogic.start("res://Resources/dialogues/.dtl")
	cur_dial.show()

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	.visible = false
