extends CharacterBody2D

func init_dial():
	print("DIAL")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	# [+] Block movement
	get_node("/root/Start/DialogueSceneGeezer").visible = true
	# vis of dial scene = on
	#Draw the BG
	#Draw the sprite and all the shit like Schranks
	Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	#remove shit
	#remove sprite
	#remove bg
	# [+] unlock movement



func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_node("/root/Start/DialogueSceneGeezer").visible = false
