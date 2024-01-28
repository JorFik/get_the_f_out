extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Text.visible_characters = 0
	while ($Text.visible_ratio < 1):
		await $CharacterTimer.timeout
		$Text.visible_characters += 1
	$EndTimer.start()
	await $EndTimer.timeout
	#get_tree().change_scene_to_file("res://Scenes/first_cut_Scene.tscn")
	#res://Scenes/outro_cut_scene.tscn
	#if Input.is_physical_key_pressed("KEY_ESCAPE") or Input.is_physical_key_pressed("KEY_Q")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_physical_key_pressed(KEY_ESCAPE) or Input.is_physical_key_pressed(KEY_Q):
		get_tree().quit()
