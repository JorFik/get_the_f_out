extends Node2D

func _ready():
	#$"Riddles/Number RIddle".visible = false
	pass

func _on_door_body_entered(body):
		if body.name == "red":
			get_tree().change_scene_to_file("res://Scenes/upper_floor.tscn")

func _on_door2_body_entered(body):
		if body.name == "red":
			get_tree().change_scene_to_file("res://Scenes/upper_floor_left.tscn")
