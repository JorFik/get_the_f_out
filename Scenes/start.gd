extends Node2D


func _on_door_body_entered(body):
		if body.name == "red":
			get_tree().change_scene_to_file("res://Scenes/upper_floor.tscn")

