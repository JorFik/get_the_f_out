extends TextureRect

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/first_cut_Scene.tscn")

func _on_end_pressed():
	get_tree().quit()
