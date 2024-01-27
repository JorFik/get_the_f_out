extends CharacterBody2D

func init_dial():
	print("DIAL")
	# [+] Block movement
	%DialogueSceneGeezer.visible = true
	# vis of dial scene = on
	#Draw the BG
	#Draw the sprite and all the shit like Schranks
	Dialogic.start("res://Resources/dialogues/timeline1.dtl")
	%DialogueSceneGeezer.visible = false
	#remove shit
	#remove sprite
	#remove bg
	# [+] unlock movement
	
