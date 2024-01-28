extends Node2D

signal correct

func _on_sign_correct():
	correct.emit()
