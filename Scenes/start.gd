extends Node2D

func _ready():
	$"Riddles/Number RIddle".visible = false

func _on_door_body_entered(body):
		if body.name == "red":
			get_tree().change_scene_to_file("res://Scenes/upper_floor.tscn")



func _on_upper_floor_go_back():
	$red.position = Vector2(1650, 550)
