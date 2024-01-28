extends CharacterBody2D

@onready var tax_collector_sprite = %"Tax collector sprite"

func _physics_process(_delta):
	tax_collector_sprite.flip_h = 1
